---
name: google-style
description: Google's developer documentation style guide — the core principles (voice and tone, second person, active voice, prescriptive writing, timeless docs, global audience) plus the 597-entry word list and a router to the detailed style skills. Use when writing, editing, or reviewing any developer-facing text — README, API docs, tutorial, quickstart, release notes, error message, CLI help, UI copy — or when asked to follow Google's style guide, the Google developer documentation style guide, or "the Google docs style".
---

# Google developer documentation style guide

Source: https://developers.google.com/style (retrieved 2026-09-13). These
skills carry the rules themselves, so you don't need to fetch the site.

## The one page you always read

This page is the whole guide compressed. If the question is settled here, stop
here. If it isn't, open the skill named in [Where each rule lives](#where-each-rule-lives).

### Break the rules

Google's own first rule: deviate from the guidance when it serves your readers
better. The guide codifies house style, not objective correctness. A rule that
makes a specific sentence worse is a rule to skip — say so, and move on.

### Highlights

Tone and content:

- Be conversational and friendly without being frivolous.
- Don't pre-announce anything. No future features, no "coming soon."
- Use descriptive link text.
- Write accessibly, and write for a global audience.

Language and grammar:

- Second person: _you_, not _we_.
- Active voice: make clear who performs the action.
- Standard American spelling and punctuation.
- Conditions before instructions, not after.
- For a specific word, check `references/word-list.md`.

Formatting, punctuation, organization:

- Sentence case for titles and headings.
- Numbered lists for sequences, bulleted lists for everything else,
  description lists for pairs of related data.
- Serial commas.
- Code font for code-related text. Bold for UI elements.
- Unambiguous date formats.

Images:

- Always provide alt text.
- Provide high-resolution or vector images when practical.

## Voice and tone

Sound like a knowledgeable friend who understands what the developer wants to
do. Casual, natural, approachable — not pedantic, not pushy. Aim for a
conversational tone rather than a formal one, but don't write exactly the way
you speak; speech is more verbose than documentation should be.

Avoid:

- Buzzwords and technical jargon.
- Being too cutesy; wackiness, zaniness, goofiness.
- Figurative language, including metaphors and ableist language.
- Placeholder phrases such as _please note_ and _at this time_.
- Choppy or long-winded sentences.
- Starting every sentence the same way (_You can…_, _To do…_).
- Current pop-culture references.
- Exclamation points.
- Phrasing that denigrates any group of people.
- _Let's_ do something.
- _simply_, _it's that simple_, _it's easy_, _quickly_ in a procedure.
- Internet slang: _tl;dr_, _ymmv_, _RTFM_.

Don't use _please_ in instructions. "To view the document, click **View**,"
never "please click **View**."

The calibration, from the guide's own table:

| Too informal | Just about right | Too formal |
| --- | --- | --- |
| Dude! This API is totally awesome! | This API lets you collect data about what your users like. | The API documented by this page may enable the acquisition of information pertaining to user preferences. |
| Then—BOOM—just garbage-collect, and you're golden. | To clean up, call the `collectGarbage` method. | Please note that completion of the task requires the following prerequisite: executing an automated memory management function. |

## Prescriptive documentation

Write opinionated documentation. Recommend a way to accomplish the task
instead of listing options the reader has to choose between. Sample commands
use the arguments that accomplish the task for the most common case.

The auxiliary verb carries the meaning, so pick it deliberately. **Generally
avoid _should_** — it leaves the reader unsure whether an action is required.

| Situation | Word to use | Example |
| --- | --- | --- |
| Action is required | _must_, or an imperative | "You must set the value to true." |
| Action is recommended | _We recommend…_ | "We recommend a strong password." |
| Action is optional | _can_ | "You can also use approach B." |
| Outcome is expected | describe it | "The process returns 10 items." |
| Outcome is possible | _might_, _can_ | "The process can take about 30 minutes." |
| State is actual | say who sets it | "The server sets the value to true." |

Recommended: The column of the data table that the filter operates on.
Not recommended: The column of the data table that the filter should operate on.

## Timeless documentation

Document the current version of the product. Don't anchor text to a point in
time or assume the reader knows earlier versions.

Recommended: These subcommands let you interact with HTTP load balancing.
Not recommended: These **new** subcommands let you interact with HTTP load balancing.

Avoid these words when describing product capabilities: _as of this writing_,
_currently_, _does not yet_, _eventually_, _existing_, _future_, _in the
future_, _latest_, _new_, _newer_, _now_, _old_, _older_, _presently_, _at
present_, _soon_.

Time-stamped content — blog posts, release notes, press releases — is exempt.
If you must write _new_ in product docs, anchor it: "The January 14, 2021
release of BigQuery includes a new resource panel."

Never document a future feature. Don't pre-announce anything without legal
approval.

## Excessive claims

An excessive claim is one that isn't verifiable with data the reader has, that
a security incident would falsify, or that reads as subjective or disparaging
about someone else's product.

- Avoid superlatives: _best_, _simplest_, _fastest_, _never_, _always_.
- Be careful with _ensure_ and _guarantee_.
- Cite the source of any specific performance claim.
- Say a feature "helps with security" or "is designed for security," never
  that it prevents a class of attack.

Recommended: Using our security product is part of an overall strategy that helps prevent account takeovers from phishing attacks.
Not recommended: Our security product prevents account takeovers from phishing attacks.

## Jargon

Jargon is the figurative shorthand of a specific group: _swim lane_,
_break-glass procedure_, _out-of-the-box_, _post-mortem_. It also covers
overloaded words such as _solution_, _support_, _workload_.

Before using a jargon term, ask:

1. Can you write around it? "When the project is finished, review what
   processes worked" instead of "Hold a post-mortem."
2. Can you replace it with something more specific? _affected area_ for _blast
   radius_; _import_ for _ingest_; _ready-made_ for _off-the-shelf_.
3. Used once? Describe it in plain language and put the term in parentheses:
   "You then move the task to an earlier part of the process (also known as
   _shifting left_)."
4. Used throughout? Define it in parentheses on first reference, or link to a
   trusted definition.
5. In a command or code sample? Use the term only in direct reference to the
   code, formatted as code.

## Write for a global audience

US English, written so that it survives translation and non-native readers.

- Use the simple word: _start_ not _commence_, _so_ not _consequently_, _use_
  not _utilize_ or _leverage_.
- Write shorter sentences. Fewer than 26 words is a good target.
- Avoid phrasal verbs: "This document uses the following terms," not "This
  document makes use of the following terms." (_set up_, _log in_, and _sign
  in_ are fine.)
- Don't stack more than two nouns as modifiers of another noun.
- Put _only_ immediately before what it modifies. "Request only one token,"
  not "Only request one token."
- Avoid gerunds where a clause works: "You must configure the VPC firewall
  rules before you deploy the VM instance," not "Configuring the VPC firewall
  rules is required before deploying the VM instance."
- Don't use the same word as both a noun and a verb nearby.
- Keep helper words that conversation drops — _then_, _that_, _of_:
  - "If the attribute key is not found, **then** the default value is returned."
  - "assumes **that** you have the following knowledge"
  - "Identify all **of** the datasets."
  - "Start the profiler, **and then** run the app."
- Keep relative pronouns: "the rules **that** you previously defined."
- Repeat a word when the redundancy helps: "creates both IAM segmentation and
  network segmentation."
- Replace an ambiguous pronoun with the noun it stands for.
- Use consistent terminology. The same concept gets the same word and the same
  capitalization everywhere.
- No colloquialisms, idioms, humor, holidays, sports, or seasons.

## Don't copy third-party content

Paraphrase and link; don't quote at length. Treat third-party docs, reference
works, Wikipedia, open source docs, and GitHub content as unsafe to reuse
unless you know the license permits it.

## Where each rule lives

| Question | Skill |
| --- | --- |
| Active voice, tense, person, pronouns, capitalization, abbreviations, plurals, possessives | `google-style-grammar` |
| Commas, dashes, hyphens, colons, quotation marks, slashes, periods | `google-style-punctuation` |
| Headings, lists, tables, procedures, notices, links, paragraphs | `google-style-structure` |
| Numbers, dates, units, math, images, bold/italic/code font | `google-style-formatting` |
| Code font, code samples, CLI syntax, placeholders, UI elements, API reference, filenames, example data | `google-style-code` |
| Accessibility, inclusive language, example names | `google-style-inclusive` |
| Auditing an existing document against all of the above | `google-style-review` |
| Reviewing someone's code | `google-code-review` |
| Getting your own change reviewed | `google-cl-author` |

## Word list

`references/word-list.md` holds all 597 entries, alphabetized, with Google's
"Don't use" and "Use with caution" verdicts intact. Grep it before ruling on a
specific term:

```bash
grep -A4 -i '^\*\*whitelist' ~/.claude/skills/google-style/references/word-list.md
```

Entries marked **Don't use** are not preferences — the term is ambiguous,
offensive, or non-inclusive, and the fix is to replace it or write around it.
Entries marked **Avoid** or **Use with caution** leave you the call.

Terms that trip up almost every draft: _above_/_below_ (directional),
_simply_, _easy_, _leverage_, _utilize_, _whitelist_/_blacklist_, _master_,
_sanity check_, _dummy_, _abort_, _kill_, _native_, _i.e._, _e.g._, _etc._,
_please_, _click here_.
