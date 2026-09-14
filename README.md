# Google style skills

Ten [Claude Code](https://claude.com/claude-code) skills that carry Google's
developer documentation style guide and Google's code review practices, so an
agent can apply them without fetching a web page mid-task.

Each skill holds the rules themselves — the wording, the thresholds, and
Google's own Recommended / Not recommended example pairs — organized by the
task you're doing rather than by the page the rule came from.

## Install

```bash
git clone https://github.com/siderakis/google-style-skills.git
cd google-style-skills
./install.sh
```

`./install.sh` with no arguments opens a picker:

```
  Google style skills
  Each enabled skill costs a little context in every session.

  WRITING
  › [x] google-style              the guide on one page + the word list
    [x] google-style-review       audit a draft, findings ranked
    [ ] google-style-grammar      voice, tense, person, capitalization
    [ ] google-style-punctuation  commas, dashes, hyphens, quotes
    [ ] google-style-structure    headings, lists, tables, procedures
    [ ] google-style-formatting   numbers, dates, units, images, alt text
    [ ] google-style-code         code font, CLI syntax, placeholders, UI
    [ ] google-style-inclusive    accessibility and inclusive language
  REVIEW
    [ ] google-code-review        reviewing someone else's change
    [ ] google-cl-author          small changes, descriptions, feedback

  2 of 10 enabled

  ↑↓ move   space toggle   enter apply   q cancel
  presets: c core   d docs   r review   a all   n none
```

Arrow keys move, space toggles, a preset letter sets the whole list at once,
and enter applies. The boxes show what you have installed now, so you're
editing a state rather than starting from nothing.

Enabling a skill symlinks it into `~/.claude/skills`, so what you have
installed tracks this repository. Start a new session for a change to take
effect, then run `/google-style`.

The picker needs [bun](https://bun.sh) and a terminal. Without either,
`./install.sh` prints the same list and reads a line of numbers instead, and
the commands below work anywhere.

### Pick what you'll use

Every enabled skill puts its name and a one-line description into every
session's context, whether or not you invoke it. Ten of them is a real cost
for someone who only wanted the writing rules. So enable a few and add more
when you reach for them.

| Preset | Enables | Choose it when |
| --- | --- | --- |
| `core` | `google-style`, `google-style-review` | You want good documentation prose and a way to audit a draft. Start here. |
| `docs` | All eight writing skills | You write documentation often enough to want the detailed rules on hand. |
| `review` | `google-code-review`, `google-cl-author` | You want Google's code review norms and nothing about writing. |
| `all` | Everything | You're trying them out. |
| `none` | Nothing | You're done with them. |

```bash
./install.sh preset core              # apply a preset
./install.sh enable google-style-code # add one skill
./install.sh disable google-cl-author # drop one skill
./install.sh set google-style         # enable exactly this, disable the rest
./install.sh status                   # what's enabled right now
```

`core` is the recommendation because `google-style` is the whole guide
compressed into one page — it answers most questions on its own and carries
the word list. The six detailed writing skills are for the questions it sends
you to: a hyphenation call, a table's punctuation, how to document a flag.
Enable those individually when you find yourself asking.

Enabling any writing skill also enables `google-style`, because the others
read its word list.

### Install into one project

```bash
./install.sh --project /path/to/repo preset docs
```

That writes symlinks into `/path/to/repo/.claude/skills` instead of your home
directory, so the skills load for that repository and nowhere else. Add
`.claude/skills/google-*` to the project's `.gitignore` unless you want your
teammates to get them too.

## The skills

### Writing documentation

| Skill | Covers |
| --- | --- |
| `google-style` | The core you always read: voice and tone, prescriptive writing, timeless documentation, excessive claims, jargon, and writing for a global audience. Routes to the rest. |
| `google-style-grammar` | Active voice, present tense, second person, pronouns, articles, capitalization, contractions, abbreviations, plurals, possessives. |
| `google-style-punctuation` | Serial commas, em dashes, hyphens and compound modifiers, colons, quotation marks, ellipses, slashes. |
| `google-style-structure` | Headings, lists, tables, procedures, notices, paragraphs, cross-references and link text. |
| `google-style-formatting` | Numbers, dates and times, units, mathematical notation, images and alt text, and when to use bold, italic, or code font. |
| `google-style-code` | Code font, code samples, command-line syntax, placeholders, UI elements, API reference comments, filenames, and safe example data. |
| `google-style-inclusive` | Accessibility and inclusive language, including how to write around a non-inclusive term that's embedded in code. |
| `google-style-review` | Audits a document against all of the above in four passes and reports findings ranked by what they cost the reader. |

`google-style` also carries the complete
[word list](skills/google-style/references/word-list.md) — 597 entries with
Google's "Don't use" and "Use with caution" verdicts intact, sized for `grep`
rather than reading:

```bash
grep -A4 -i '^\*\*whitelist' ~/.claude/skills/google-style/references/word-list.md
```

### Code review

| Skill | Covers |
| --- | --- |
| `google-code-review` | Reviewing someone else's change: the standard (approve once it improves code health, not once it's perfect), what to look for, navigating a large change, review speed, writing comments that land, and handling pushback. |
| `google-cl-author` | Getting your own change reviewed: writing small self-contained changes, four ways to split a large one, writing a description that says what changed and why, and handling reviewer comments. |

## How it was built

The style skills were written from the guide's own pages, fetched and read in
full rather than recalled. The code review skills were written from the
[google/eng-practices](https://github.com/google/eng-practices) repository,
read in full.

Two things were deliberately preserved. Google's example pairs are quoted as
written, because a rule stated without its example is a rule an agent
interprets loosely. And Google's own first rule survives everywhere: deviate
from the guidance when it serves your readers better.

## Attribution and license

Derived from Google's
[developer documentation style guide](https://developers.google.com/style)
(CC BY 4.0) and
[engineering practices documentation](https://github.com/google/eng-practices)
(CC BY 3.0). This is an unofficial adaptation, not produced or endorsed by
Google. See [NOTICE.md](NOTICE.md) for what came from where, and
[LICENSE](LICENSE) for the CC BY 4.0 terms this repository is offered under.

Where this repository and a Google guide disagree, the Google guide is
correct — please open an issue.
