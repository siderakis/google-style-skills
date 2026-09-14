---
name: google-code-review
description: Review someone else's change the way Google's engineering practices describe — the standard of code review (approve once it improves code health, not once it's perfect), what to look for (design, functionality, complexity, tests, naming, comments, style, consistency, docs, every line), how to navigate a large change, how fast to respond, how to write comments that land (courtesy, explain why, Nit/Optional/FYI labels), and how to handle pushback. Use when reviewing a PR, branch, diff, or patch, or when deciding whether to approve or what to say in a review comment.
---

# How to do a code review

Source: https://github.com/google/eng-practices (Google's Code Review
Developer Guide, CC-BY 3.0, retrieved 2026-09-13). Google writes _CL_
("changelist"); read it as pull request, branch, or commit. The author's side
is in `google-cl-author`.

## The standard

**The primary purpose of code review is to make sure the overall code health
of the codebase improves over time.**

That sits on top of a trade-off. Developers have to be able to make progress —
if no improvement ever lands, the codebase never improves, and a reviewer who
makes every change hard discourages the next one. At the same time the
reviewer owns the code and has to keep each change from degrading it, because
codebases rot through small losses under time pressure.

So:

> **Approve a change once it definitely improves the overall code health of
> the system, even if the change isn't perfect.**

That is the senior principle among all of these guidelines. There is no
perfect code, only better code. Don't hold up approval to polish every piece;
weigh the value of your suggestion against the cost of another round. Seek
continuous improvement, not perfection.

You can still deny approval for a change you don't want in the system at all,
however well written it is.

Always feel free to comment that something could be better. If it isn't
important, prefix it with "Nit:" so the author knows they can skip it.

Nothing here justifies approving a change that makes code health worse. The
only exception is an emergency.

### Mentoring

Teaching is part of review. Leave the comment that explains the language
feature or the design principle. If the comment is purely educational and not
required by the standard above, mark it "Nit:" or otherwise say it isn't
mandatory.

### Principles

- Technical facts and data overrule opinions and personal preferences.
- On style, the style guide is the absolute authority. A pure style point not
  in the style guide is personal preference: match what's already there, and
  if there's no precedent, accept the author's choice.
- **Software design is almost never pure style or personal preference.** Weigh
  it on underlying principles. If the author shows that several approaches are
  equally valid, accept theirs. Otherwise standard design principles decide.
- Failing everything else, ask for consistency with the existing codebase, as
  long as that doesn't make code health worse.

### Conflicts

Try for consensus first, on the basis of these guidelines. If comments aren't
converging, talk face to face or on a call — then record the outcome as a
comment for future readers. If that fails, escalate: a team discussion, the
tech lead, the maintainer, a manager. **Never let a change sit because the
author and reviewer can't agree.**

## What to look for

**Design.** The most important thing in the review. Do the pieces fit
together? Does this belong in this codebase or in a library? Does it integrate
with the rest of the system? Is now the right time for it?

**Functionality.** Does it do what the author intended, and is that good for
its users — both end users and the developers who'll call this code later?
Think about edge cases and concurrency, and read for bugs. Validate behavior
yourself when the change is user-facing, especially a UI change; ask for a demo
if patching it in is inconvenient. Parallel code deserves careful thought from
both of you, because deadlocks and races don't show up by running the code.

**Complexity.** Is it more complex than it needs to be — line by line,
function by function, class by class? "Too complex" means other readers can't
understand it quickly, or callers are likely to introduce bugs. Watch
especially for **over-engineering**: code made more generic than it needs to
be, or functionality nothing needs yet. Push authors to solve the problem they
have now. The future problem gets solved when its actual shape is visible.

**Tests.** Ask for unit, integration, or end-to-end tests as the change
warrants; they belong in the same change as the production code unless it's an
emergency. Then review the tests themselves — nobody tests the tests. Will
they fail when the code breaks? Will they go false-positive as the code
changes? Are the assertions simple and useful? Are cases split across methods
sensibly? Tests are code you'll maintain; don't accept complexity in them just
because they don't ship.

**Naming.** Long enough to say what the thing is, short enough to read.

**Comments.** Clear, and necessary. A good comment explains **why** the code
exists, not what it does — if the code can't explain itself, simplify the
code. Regular expressions and complex algorithms are the usual exceptions.
Also look at the comments that were already there: a TODO that can now go, a
comment warning against exactly this change. Comments differ from
documentation of a class or function, which states purpose, usage, and
behavior.

**Style.** Follow the language style guide. Prefix a style improvement that
isn't in the style guide with "Nit:" and don't block on personal preference.
Major reformatting shouldn't ride along with functional changes — ask for the
reformat as its own change first.

**Consistency.** The style guide wins over surrounding code where it states a
requirement. Where it only recommends, it's a judgment call between following
the recommendation and matching the neighbors; lean toward the style guide
unless local inconsistency would be confusing. Otherwise, consistency with
existing code. Either way, encourage a bug and a TODO for cleaning up what's
already there.

**Documentation.** If the change alters how people build, test, use, or
release the code, the README and reference docs change with it. If code is
deleted or deprecated, its docs probably should be too. Ask for missing docs.

**Every line.** Look at every line you were assigned. Skim data files,
generated code, and large data structures if you must, but never skim a
human-written block and assume it's fine. If the code is too hard to read and
that's slowing the review, say so and wait for the author to clarify — if you
can't understand it, later readers won't either. If you understand it but
aren't qualified to judge part of it (privacy, security, concurrency,
accessibility, i18n), make sure a qualified reviewer is on it.

Exceptions: when you're one of several reviewers and were asked for only some
files or only one aspect, note in a comment which parts you reviewed, and
prefer approving with comments. If you're approving on the strength of another
reviewer's coverage, say so explicitly.

**Context.** The diff shows a few lines around each change. Open the whole
file when you need to — four new lines can be four lines inside a 50-line
method that now needs breaking up. Then think about the system: is this change
improving code health or adding to the complexity? **Don't accept changes that
degrade the code health of the system.** Systems get complex through small
changes that add up.

**Good things.** Say so when you see something nice, especially when the
author addressed an earlier comment well. Reviews skew toward mistakes.
Telling someone what they did right is often the more valuable half of
mentoring.

### Summary

The code is well designed. The functionality is good for its users. UI changes
look right. Parallel code is safe. It's no more complex than it needs to be.
The author isn't building for a future they don't know they have. Tests exist
and are well designed. Names are clear. Comments explain why. The docs are
updated. The style guide is followed. You reviewed every line, looked at the
context, improved code health, and complimented what was good.

## Navigating a change

1. **Take a broad view.** Read the description. Does this change make sense at
   all? If it shouldn't have been written, say so immediately, explain why,
   and suggest what to do instead — courteously:

   > "Looks like you put some good work into this, thanks! However, we're
   > actually going in the direction of removing the FooWidget system that
   > you're modifying here, so we don't want to make new modifications to it
   > right now. How about instead you refactor our new BarWidget class?"

   If you're getting several changes you don't want, fix the process so people
   talk before writing code rather than after.

2. **Examine the main parts first.** Find the file with the largest logical
   change and start there. It gives context for everything else and speeds up
   the rest. If you can't tell which parts are major, ask the author, or ask
   them to split the change.

   **Send major design comments immediately**, even if you haven't reviewed
   the rest. Two reasons: the author is probably already building on top of
   this change, and major rework takes time they need to start now. Reviewing
   the rest may be wasted effort if the design changes.

3. **Go through the rest in a sensible order.** Once the design is settled,
   the tool's file order is usually fine. Reading the tests first often helps —
   they tell you what the change is supposed to do.

## Speed

Optimize for the speed of the whole team, not of one developer.

Slow reviews slow the whole team, breed complaints about "strict" reviewers,
and push code health down as pressure builds to let weaker changes through.
**Most complaints about the code review process are resolved by making the
process faster.**

- If you aren't in the middle of a focused task, review shortly after it
  arrives.
- **One business day is the maximum** — first thing the next morning.
- A typical change should get several rounds within a day.
- **Don't interrupt a focused task to review.** Getting back into flow costs
  the team more than a short wait costs the author. Review at a break point.
- What matters is your **response** time, not the total time to submit. Even a
  long review feels fine when each response is fast.
- Too busy? Reply with when you'll get to it, suggest another reviewer, or
  send initial broad comments. (At a break point, not mid-task.)
- Across time zones, get back to the author while they can still act on it, or
  before they start the next day.
- Spend enough time that your approval means the code meets the standard.

**Approve with comments** when any of these hold: you're confident the author
will handle the remaining comments; the comments don't have to be addressed;
or the suggestions are minor (sort imports, fix a typo, drop an unused dep).
Say which case you mean. This matters most across time zones, where the
alternative is the author waiting a whole day.

**Large changes.** Ask the author to split it into smaller changes that build
on each other. If it genuinely can't be split and you can't review it quickly,
at least comment on the overall design and send it back. One of your goals is
to always leave the author able to take a next step, without sacrificing code
health for it.

Strictness plus speed compounds: authors learn what healthy code looks like
and send better changes; reviewers learn to respond fast. Don't trade away the
standard for imagined velocity — it doesn't make anything faster in the long
run.

## Writing review comments

Summary: be kind; explain your reasoning; balance giving explicit directions
against pointing out problems and letting the author decide; push for
simplified code or a code comment rather than an explanation aimed at you.

**Courtesy.** Comment on the code, never on the developer. Always, but
especially when the comment might sting.

Bad: "Why did **you** use threads here when there's obviously no benefit to be gained from concurrency?"
Good: "The concurrency model here is adding complexity to the system without any actual performance benefit that I can see. Because there's no performance benefit, it's best for this code to be single-threaded."

**Explain why.** Not on every comment, but give the intent, the practice you're
following, or how the suggestion improves code health when it isn't obvious.

**Guidance.** Fixing the change is the author's job, not yours — you don't owe
them a design or the code. But don't be unhelpful either. Pointing out a
problem and letting the author decide teaches them, keeps reviews cheap, and
often produces a better answer, because they're closer to the code. Sometimes
a direct instruction, a suggestion, or a snippet is simply more useful. The
primary goal is the best possible change; the secondary goal is an author who
needs less review over time.

Comment on what you liked too — a messy algorithm cleaned up, exemplary test
coverage, something you learned — and say why.

**Label severity** so the author can prioritize and doesn't read every comment
as mandatory:

> **Nit:** This is a minor thing. Technically you should do it, but it won't hugely impact things.
>
> **Optional** (or **Consider**): I think this may be a good idea, but it's not strictly required.
>
> **FYI:** I don't expect you to do this in this change, but you may find it interesting for the future.

**Accepting explanations.** If you ask what a piece of code does, the right
outcome is usually **rewritten code**, sometimes a code comment. An
explanation typed into the review tool helps nobody who reads the code later.
Accept one only in narrow cases, such as when you're reviewing an unfamiliar
area and the author is telling you something regular readers would know.

## Handling pushback

**Ask first whether they're right.** They're closer to the code and may have
better insight. If their argument holds up on code health, say so and drop it.

If they're not right, explain again — a good explanation shows you understood
their reply and adds information about why you're asking. Keep advocating when
you believe the change improves code health and the improvement justifies the
work. **Code health improves in small steps.** It sometimes takes a few rounds.
Stay polite, and make clear you hear them and simply don't agree.

**"You'll upset them."** Usually that worry lives only in the reviewer's head,
and when there is an upset it's brief and followed by thanks. Upsets come from
how comments are written far more often than from insisting on quality.

**"I'll clean it up later."** Experience says it doesn't happen — not from
irresponsibility, but because the cleanup gets lost under the next thing.
Insist on the cleanup now, before the code is in and "done." Letting people
clean up later is a standard way for codebases to degrade. If a change
introduces new complexity, it gets cleaned up before submission unless it's an
emergency. If it exposes surrounding problems that genuinely can't be fixed
now, have the author file a bug, assign it to themselves, and optionally add a
TODO referencing it.

**"You're too strict."** Loud complaints after a shift to stricter review
usually fade — faster reviews are what makes them fade. It can take months.
The loudest protesters often become the strongest supporters.

## Emergencies

An emergency is a **small** change that lets a major launch continue instead
of rolling back, fixes a bug significantly affecting users in production,
handles a pressing legal issue, or closes a major security hole. In an
emergency, the whole review process is optimized for speed, the reviewer cares
about speed and about whether the code actually resolves the emergency, and
the review preempts other reviews. Review the change properly afterwards.

**Not emergencies:** wanting to launch this week instead of next; a feature
someone worked on for a long time; reviewers being asleep or off-site; Friday
afternoon; a manager citing a soft deadline; rolling back a change that breaks
tests or the build.

A hard deadline is one where something disastrous happens if you miss it: a
contractual obligation, a product that fails in the market, a hardware
manufacturer that ships once a year. Delaying a release a week isn't
disastrous. Most deadlines are soft, and soft deadlines don't buy code health.
If changes routinely land near the end of a cycle with only superficial
review, the team's process needs to change, not the review standard.
