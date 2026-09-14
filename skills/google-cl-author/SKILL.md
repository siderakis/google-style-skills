---
name: google-cl-author
description: Get your own change through review the way Google's engineering practices describe — write small self-contained changes and split large ones (stacking, by file, horizontally, vertically), write a commit or PR description that says what changed and why, and handle reviewer comments without taking them personally. Use when preparing a commit, PR, or branch for review, when a change has grown too large to review, or when writing a commit message or PR body.
---

# Getting a change through review

Source: https://github.com/google/eng-practices (The CL Author's Guide,
CC-BY 3.0, retrieved 2026-09-13). Google writes _CL_ ("changelist"); read it
as commit, pull request, or branch. The reviewer's side is in
`google-code-review`.

## Write small changes

Small, simple changes are:

- **Reviewed more quickly.** Five minutes several times is easier to find than
  a 30-minute block.
- **Reviewed more thoroughly.** Large changes produce volumes of commentary,
  and important points get dropped.
- **Less likely to introduce bugs.** Fewer changes, easier to reason about the
  impact.
- **Less wasted work when rejected.** A huge change sent in the wrong
  direction is a lot of work thrown away.
- **Easier to merge.** Long-running work means frequent conflicts.
- **Easier to design well.** Polishing a small change beats refining every
  detail of a large one.
- **Less blocking.** You can keep working while a self-contained piece is in
  review.
- **Simpler to roll back.** A large change is likelier to touch files that
  moved since, which drags intermediate changes into the rollback.

**A reviewer can reject a change outright for being too large.** Splitting
after the fact is more work than writing small in the first place.

### What counts as small

The right size is **one self-contained change**:

- It makes a minimal change addressing **just one thing** — usually part of a
  feature, not a whole feature. Err small.
- It includes the related tests.
- Everything the reviewer needs is in the change, its description, the
  existing codebase, or a change they already reviewed.
- The system still works for users and developers after it lands.
- It isn't so small that its implications are unclear. A new API should come
  with a use of that API, so the reviewer sees how it's used and no unused API
  lands.

No hard limits: 100 lines is usually reasonable, 1000 is usually too large,
and the reviewer's judgment decides. File count matters too — 200 lines in one
file may be fine; the same 200 lines across 50 files usually isn't. You have
been living in this code; your reviewer has no context. When in doubt, go
smaller. Reviewers rarely complain that a change is too small.

### When large is okay

- Deleting an entire file counts as roughly one line — it's quick to review.
- A change produced by an automated refactoring tool you fully trust, where
  the reviewer's job is to confirm they want it. The merge and testing caveats
  still apply.

### Working without blocking yourself

Don't write a small change and then sit waiting. Run several projects at once,
find reviewers who'll respond immediately, pair, or split so that you can keep
going.

### How to split

Think about the split before you start coding, not after.

**Stacking.** Send one small change, then immediately start the next one based
on it.

**By files.** Group files that need different reviewers but are self-contained
on their own — the protocol buffer change in one, the code that uses it in
another. They review in parallel even though they submit in order. Tell each
set of reviewers about the other change.

Another version: the code change in one, the configuration or experiment that
turns it on in another. That's also easier to roll back, since config often
reaches production faster than code.

**Horizontally.** Split across layers of the stack, using shared stubs or
signatures to isolate them. A shared proto signature abstracts the service and
data model from each other; an API stub splits client from service. The same
idea works at function and class level.

**Vertically.** Split into smaller full-stack features that progress in
parallel — multiplication and division as separate tracks, even though they
share button styling and validation.

**Both.** Chart the implementation as a grid where each cell is its own
change, and work up from the model:

| Layer | Feature: Multiplication | Feature: Division |
| --- | --- | --- |
| Client | Add button | Add button |
| API | Add endpoint | Add endpoint |
| Service | Implement transformations | Share transformation logic |
| Model | Add proto definition | Add proto definition |

### Refactorings go in their own change

Moving and renaming a class belongs in a different change from fixing a bug in
that class. Small cleanups — a local variable name — can ride along with a
feature or bug fix. Where the line falls is a judgment call between you and
the reviewer.

### Tests go in the same change

Smallness is about focus, not line count. A change that adds or alters logic
comes with new or updated tests. A pure refactoring should be covered by
tests; if they don't exist, add them.

Independent test work can go first, in its own change: covering existing
submitted code, refactoring test code, or introducing a larger test framework.
Adding tests before a refactoring is the way to show behavior didn't change.

### Don't break the build

When changes depend on each other, make sure the system still works after each
one lands. Otherwise you break everyone between your submissions — longer if
something goes wrong with a later one.

### "I can't make it small enough"

Almost always untrue. Consider a refactoring-only change first to clear the
way. Ask teammates how they'd decompose it. If everything fails — which should
be rare — get your reviewers' consent in advance so they know what's coming,
expect a long review, be vigilant about bugs, and be extra diligent about
tests.

## Write a good description

A description is a public record of the change, and it has to communicate two
things:

1. **What** is changing — enough that a reader gets the shape of it without
   reading the whole diff.
2. **Why** — the context you had, the decisions that aren't visible in the
   source.

It becomes a permanent part of version control history and may be read by
hundreds of people over years. People will search for it later from a vague
memory, so the important information belongs in the description, not only in
the code. And they need the _why_: source code shows what the software does,
not why it exists, which is what tells a future developer whether they can
move [Chesterton's fence](https://abseil.io/resources/swe-book/html/ch03.html#understand_context).

### First line

- A short summary of what is being done.
- A complete sentence, written as an order (imperative).
- Followed by a blank line.

It appears alone in history summaries, so it has to stand on its own — a
reader skimming should know what this change did and how it differs from the
others. Say "**Delete** the FizzBuzz RPC and **replace** it with the new
system," not "Deleting the FizzBuzz RPC and replacing it…". The rest of the
description doesn't have to be imperative.

### Body

Fill in the details and anything needed to understand the change as a whole: a
brief description of the problem, why this is the best approach, any
shortcomings of that approach, and background such as bug numbers, benchmark
results, and links to design docs. External links may not survive access
restrictions or retention, so include enough context inline. Even small
changes deserve a sentence of context.

### Bad descriptions

"Fix bug." What bug? What did you do? Same for "Fix build.", "Add patch.",
"Moving code from A to B.", "Phase 1.", "Add convenience functions.", "kill
weird URLs." All real, all useless.

### Good descriptions

Functionality change:

> RPC: Remove size limit on RPC server message freelist.
>
> Servers like FizzBuzz have very large messages and would benefit from reuse.
> Make the freelist larger, and add a goroutine that frees the freelist
> entries slowly over time, so that idle servers eventually release all
> freelist entries.

Refactoring:

> Construct a Task with a TimeKeeper to use its TimeStr and Now methods.
>
> Add a Now method to Task, so the borglet() getter method can be removed
> (which was only used by OOMCandidate to call borglet's Now method). This
> replaces the methods on Borglet that delegate to a TimeKeeper.
>
> Allowing Tasks to supply Now is a step toward eliminating the dependency on
> Borglet. Eventually, collaborators that depend on getting Now from the Task
> should be changed to use a TimeKeeper directly, but this has been an
> accommodation to refactoring in small steps.

Small change that needs context:

> Create a Python3 build rule for status.py.
>
> This allows consumers who are already using this as in Python3 to depend on
> a rule that is next to the original status build rule instead of somewhere
> in their own tree. It encourages new consumers to use Python3 if they can,
> and significantly simplifies some automated build file refactoring tools
> being worked on currently.

### Tags

Tags are optional labels — `[tag]`, `#tag`, `tag:`. Keep them short if they
go in the first line, since long or numerous tags crowd out the content;
otherwise put them in the body.

```
[banana] Peel the banana before eating.        # okay, short
Peel the #banana before eating.                 # okay, inlined
#banana #apple: Assemble a fruit basket.        # okay, short
[banana peeler factory factory][apple picking service] Assemble a fruit basket.   # too much
```

**Check the project first.** If the repository's `CLAUDE.md`, `CONTRIBUTING.md`,
or recent `git log` shows a title convention, follow it — a short surface tag
in front of an imperative summary satisfies Google's first-line rules, so the
two don't conflict. Match what the history already does, and put the _why_ in
the body.

```
[iOS] Fix horizontal drags opening the side menu instead of scrolling content
```

```bash
git log --oneline -20   # read the convention before you write the title
```

### Generated descriptions

A tool-written description follows the same rules: a short, focused,
standalone first line, and a body with details that help reviewers and future
searchers.

### Review the description before you submit

A change can move a long way during review. Check that the description still
describes what the change does.

## Handling reviewer comments

**Don't take it personally.** The goal is the quality of the codebase and the
product. A critique of your code is an attempt to help you and the codebase,
not an attack. Reviewers sometimes let frustration into their comments — not
good practice on their part, but when it happens, ask yourself what the
constructive version of the comment is and act on that.

**Never respond in anger.** It's a serious breach of professional etiquette
and it lives forever in the review tool. Walk away and come back when you can
reply politely. If a reviewer is consistently unconstructive, raise it with
them in person or privately by email — kindly, saying what you'd like
different. Escalate to your manager only if that doesn't work.

**Fix the code, not the review thread.** When a reviewer doesn't understand
something, clarify the code. If the code can't be clarified, add a comment
explaining why it's there. Only if a comment would be pointless should you
answer in the review tool. A reviewer who didn't understand your code is
evidence that future readers won't either, and a reply in the review tool
helps none of them.

**Think collaboratively.** Finishing a change is satisfying, and comments
asking for more work are frustrating — especially ones you disagree with. Step
back and ask first: do I understand what the reviewer is asking for? If not,
ask. If you understand and still disagree, engage rather than defend:

Bad: "No, I'm not going to do that."

Good: "I went with X because of [these pros/cons] with [these tradeoffs]. My
understanding is that using Y would be worse because of [these reasons]. Are
you suggesting that Y better serves the original tradeoffs, that we should
weigh the tradeoffs differently, or something else?"

Courtesy and respect come first. Ask for clarification, discuss tradeoffs,
explain why your approach serves the codebase and the users better. Sometimes
you know something about the users or the code that the reviewer doesn't — fix
the code where that applies, and give them the context. Consensus on technical
facts is the usual outcome.

**Conflicts.** Try for consensus first. If you can't reach it, the principles
in `google-code-review` — technical facts over preference, the style guide as
the authority on style, design weighed on principles — are what settle it, and
escalation is the backstop. Don't let the change sit.
