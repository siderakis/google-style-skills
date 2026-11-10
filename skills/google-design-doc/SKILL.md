---
name: google-design-doc
description: Write a software design doc in the structure Google engineers use — context and scope, goals and non-goals, overview, detailed design, alternatives considered, cross-cutting concerns, open questions — with the trade-offs as the point of the document. Includes a fill-in template, a 1–3 page mini design doc, and when a design doc is the wrong tool. Use when asked for a design doc, a technical design, a design proposal, an RFC, an architecture write-up, or a plan the reader has to approve before work starts.
---

# Writing a design doc

Source: Malte Ubl, "Design Docs at Google"
(https://www.industrialempathy.com/posts/design-docs-at-google/, retrieved
2026-11-10). The section structure below is the one that post describes; the
wording here is a rewrite for an agent, not a copy. For the prose inside each
section, follow `google-style`.

A design doc records the high-level implementation strategy and the key
decisions, with the emphasis on the trade-offs that were weighed. It is
written before the code, so problems surface while changes are still cheap.
Its readers want to know three things: what is being built, why this way, and
what it costs.

Google's own first rule: write it in whatever form makes the most sense for
the project. The structure below is the one that has proved useful often
enough to be the default. Drop a section that has nothing to say, and say so
in one line rather than padding it.

## The template

Copy this, then fill or delete each section.

```markdown
# <What this design does, as a sentence a stranger can understand>

- **Author:** <who wrote it>
- **Reviewer:** <who approves it>
- **Status:** <Proposal | Approved | Implemented | Deployed | Outdated>
- **Delivery:** <what is built today, if anything, and what is not>

## Context and scope

<Objective facts about the landscape the system lives in and what is being
built. Link to detail instead of repeating it.>

## Goals and non-goals

### Goals

- <An outcome a reader can check.>

### Non-goals

- **<Something that could reasonably be a goal.>** <Why it isn't one here.>

## Overview

<The design in one paragraph. A reader who stops here knows what you chose.>

## Detailed design

### <A claim about one part of the design>

<How it works, and the trade-off it makes.>

## Alternatives considered

### <Alternative>

- **Advantages:** <what it would have given>
- **Why it lost:** <the trade-off that ruled it out, against the goals>

## Cross-cutting concerns

- **Security:** <how the design affects it and how that is handled>
- **Privacy:** <...>
- **Observability:** <...>
- **Compatibility and migration:** <...>
- **Rollout and rollback:** <...>

## Open questions

1. <A decision still open, with the option you recommend and why.>

## References

- <Prior art, the code this builds on, related designs.>
```

## What goes in each section

### Title and header

The title says what the design does, specifically enough that it could not
sit on an unrelated document. "Agents read Markdown documents without their
embedded images" names the change; "Image handling" does not.

The header says who wrote it, who decides, and its status. Status is the line
that stops a reader from taking a proposal for how the system works today, so
it is never left out. Add a delivery line when part of the work already exists
or when a related change ships separately.

### Context and scope

Bring the reader up to speed on the landscape the new system is being built
in, and say what is being built. Assume some prior knowledge and link to the
rest.

- **Facts only.** This section is objective background: what exists, what is
  broken, what was measured. Opinions and proposals start in Overview.
- **Not a requirements doc.** Keep it short.
- **Cite evidence.** A file and line, a measurement, a count, a dated
  incident. "About one document in thirteen is over the limit" beats "many
  documents are too large."
- **Subheadings as claims.** When the context runs longer than a few
  paragraphs, give each part a heading that states its finding ("Base64
  images make a document too big for agents to read"), so the headings alone
  tell the story.

### Goals and non-goals

A short bulleted list of each.

- **Goals** are outcomes a reviewer can check later, not activities. "An agent
  gets every word of a document at close to its own size" is checkable; "Improve
  image handling" is not.
- **Non-goals** are things that could reasonably be goals but are deliberately
  excluded. "The system shouldn't crash" is a negated goal, not a non-goal.
  "ACID compliance" for a new database is a real non-goal: a reader would want
  to know. A good non-goal often names a nearby problem and says it belongs to
  a separate decision.
- A solution that happens to deliver a non-goal is still allowed, as long as
  it costs none of the goals.

### Overview

One paragraph, sometimes two, that states the chosen design. Write it so a
busy reviewer who reads only the header, Goals and Overview can approve or
object. Put the system context here when it helps: one diagram or sentence
showing the new piece inside the landscape the reader already knows.

### Detailed design

Start from the overview and go into detail. This is where the trade-offs are
written down: given the facts (context) and the requirements (goals and
non-goals), show why this solution satisfies the goals best.

- **Say how constrained the problem is.** A greenfield design ranges widely
  and has to narrow the options fast. A design inside a system that already
  works (a legacy service, a host language, a storage format that can't
  change) can enumerate its options, and its job is choosing the best
  combination. Say which kind this is near the top; it tells the reviewer
  what to scrutinize.
- **APIs:** sketch only the parts that matter to the design. Pasting full
  interface definitions adds noise and goes stale.
- **Data storage:** describe what is stored and in roughly what shape. Skip
  complete schemas for the same reason.
- **Code:** rarely. Include code or pseudo-code only for a novel algorithm,
  and link to a prototype when one proves the design can be built. "I tried it
  and it works" is one of the strongest arguments a design doc can make.
- **One subsection per decision,** headed by the decision ("Saving swaps
  references back from the Version being edited"), each ending on the
  trade-off it makes.
- **Number the subsections** only when they describe a sequence the reader
  must follow in order.

### Alternatives considered

The section that shows the chosen design is the best one. List every
alternative that would reasonably have achieved a similar outcome, including
the one the reviewer is most likely to suggest, and including "do nothing"
when it is a live option.

For each, name what it would have given and the trade-off that ruled it out,
measured against the goals. Brevity about a rejected option is fine; leaving
out the reason it lost is not. A design doc with no alternatives reads as the
only option there was, and it invites the review to supply them.

### Cross-cutting concerns

Short entries on how the design affects each concern the organization always
checks, and how that is handled. Security, privacy and observability are the
usual minimum. Add the ones that apply: compatibility for existing callers,
cost, availability, rollout order and rollback, data migration, accessibility.

Write "no change" with a one-line reason when a concern is untouched, so the
reviewer can see it was considered. When a concern has its own dedicated
review or document, link to it instead of repeating it.

### Open questions

Number them. Each is a decision the reviewer can make, with the option you
recommend and why. "Should very small images stay inline? I recommend
filtering everything, because it is simpler and restores exactly." An open
question with no recommendation hands the work back to the reviewer.

If nothing is open, say so in one line.

### References and prior art

Link the code the design builds on, earlier designs it extends or replaces,
and how other well-run projects solved the same problem. When an outside
pattern was adopted, name the project and say which part was taken and which
part is new.

## Length

Detailed enough to review, short enough that busy people read it. A large
project lands around 10–20 pages; well beyond that, split the problem into
designs that can be decided separately.

For an incremental change or a subtask, write a **mini design doc** of 1–3
pages: the same sections, each a few lines. Context and goals still come
first, and alternatives are still required.

## When not to write one

A design doc is overhead. It earns that cost when the solution is ambiguous,
because the problem is complex, the solution is, or both.

- If the document would only say "this is how we will implement it", with no
  trade-offs and no real alternatives, it is an implementation manual. Write
  the code instead.
- If the answer is obvious, there is nothing for a reviewer to decide.
- Prototyping can be part of writing the doc: build the risky piece, then
  report what it showed.

## After review

- **Revise the doc when the design changes during implementation.** Until the
  system ships, update it in place. After it ships, a follow-up document that
  links back is fine; link forward from the original so readers find it.
- **Move the status** when the design is approved, built and deployed, and
  mark it outdated when it no longer describes the system. A doc whose status
  is stale misleads the reader who finds it a year later.

## Before you send it

- [ ] The title says what the design does.
- [ ] The header has an author, a reviewer and a status.
- [ ] Context is facts, with evidence, and no proposals.
- [ ] Every goal is checkable; every non-goal is something a reader might
      have assumed was a goal.
- [ ] The overview alone tells a reader what was chosen.
- [ ] Each detailed-design subsection ends on its trade-off.
- [ ] At least one real alternative, each with why it lost.
- [ ] Security, privacy and observability each have an entry.
- [ ] Each open question carries a recommendation.
- [ ] Nothing is described as built that is not.
