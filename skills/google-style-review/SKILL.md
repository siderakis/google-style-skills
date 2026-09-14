---
name: google-style-review
description: Audit an existing document against Google's developer documentation style guide and report findings ranked by severity, with the exact rewrite for each. Runs mechanical checks (banned words, directional language, passive voice, heading case, date formats, missing alt text) then a reading pass. Use when asked to style-check, copyedit, or review a README, doc, tutorial, API reference, release notes, or any developer-facing text against the Google style guide.
---

# Style review

Source: https://developers.google.com/style (retrieved 2026-09-13). The rules
live in the `google-style*` skills; this one is the procedure for applying
them to a document that already exists.

Target: `$ARGUMENTS` — a file path, a glob, or a diff range. Ask only if
nothing is named and nothing obvious is in the working tree.

## How to run it

Four passes, in this order. Earlier passes change text that later passes would
have flagged, so don't reorder them.

### 1. Purpose and shape

Read the whole document once before flagging anything.

- What is this document for, and who is _you_ in it? If the audience is never
  established, that's the first finding.
- Is it a task document or a concept document? The title takes a bare
  infinitive for a task, a noun phrase for a concept.
- Does the heading hierarchy hold up — one `h1`, no skipped levels, no empty
  headings, no heading repeating the page title?
- Is anything pre-announced — a future feature, a "coming soon"? That's a
  blocker, not a nit.
- Are there excessive claims — superlatives, unsourced performance numbers,
  or a flat security guarantee?

### 2. Mechanical checks

Run these against the file. They find most of what a first review catches.

```bash
F=path/to/doc.md

# Timeless-documentation violations
grep -nEi '\b(currently|at present|presently|as of this writing|for now|soon|latest|newest|new(er)?|old(er)?|eventually|does not yet|doesn.t yet)\b' "$F"

# Directional language (accessibility + localization)
grep -nEi '\b(above|below|left-hand|right-hand|upper right|lower left|on the right|on the left)\b' "$F"

# Tone and filler
grep -nEi "\b(simply|simple|easy|easily|just |quickly|obviously|of course|please|note that|let's|we'll)\b" "$F"

# Banned abbreviations and slang
grep -nE '\b(i\.e\.|e\.g\.|etc\.|tl;dr|ymmv|RTFM|and/or)\b' "$F"

# Vague link text
grep -nEi '\[(click here|here|this|this document|this article|this page|read more|learn more|link)\]' "$F"

# Non-inclusive terms
grep -nEi '\b(whitelist|blacklist|master|slave|sanity.?check|dummy|crazy|insane|blind to|cripple|man-hours|mankind|grandfathered|native speaker)\b' "$F"

# Likely passive voice
grep -nE '\b(is|are|was|were|be|been|being) [a-z]+(ed|en)\b' "$F"

# First person
grep -nE '\b(we|our|us|I) \b' "$F"

# Missing serial comma
grep -nE '[a-z]+, [a-z]+ (and|or) [a-z]+' "$F"

# Ambiguous numeric dates
grep -nE '\b[0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4}\b' "$F"

# Images with no alt text
grep -nE '!\[\]\(' "$F"
grep -nE '<img[^>]*>' "$F" | grep -v 'alt='

# En dashes and curly quotes (the guide bans both)
grep -nE '[–“”‘’]' "$F"

# Headings that start with an -ing verb, or aren't sentence case
grep -nE '^#{1,6} [A-Za-z]+ing\b' "$F"
grep -nE '^#{1,6} ([A-Z][a-z]+ ){2,}[A-Z][a-z]+' "$F"

# Headings ending in a period, or containing a link
grep -nE '^#{1,6} .*\.$|^#{1,6} .*\]\(' "$F"
```

A grep hit is a candidate, not a finding. `above` in "the layer above" is
fine; `new` in a release note is fine; a passive "The file is saved" is fine.
Check each one in context.

### 3. Reading pass

Grep can't see these. Read for them:

- **Sentence order.** Condition before instruction. "To delete the document,
  click **Delete**" — not the reverse.
- **Procedures.** Every step starts with an imperative verb. Location before
  action, goal before action. `Optional:` prefix, not `(optional)`. No
  keyboard shortcuts. No "run the following command."
- **List introductions.** A complete sentence, not a fragment the items
  finish. Colon before an immediate list.
- **List punctuation.** Parallel structure; consistent capitalization; end
  punctuation applied by the rule (no period on a single word, a verbless
  item, a pure code-font item, or bare link text).
- **Code font.** Filenames, paths, flags, values, types, status codes, and
  placeholders in code font. Product names and browser URLs not in code font.
- **Placeholders.** `UPPER_SNAKE_CASE`, no `MY_` or `YOUR_` prefix, explained
  the first time each appears.
- **UI elements.** Bold labels. No UI element used as a verb. Right noun for
  the widget — pane, not section; field, not box, in Google contexts.
- **Example data.** Real domains, emails, names, IPs, or phone numbers are a
  blocker. Replace them with the reserved ones.
- **Tables.** Introduced by a complete sentence; sentence-case headings; no
  merged cells; nothing conveyed by an image or symbol alone.
- **Notices.** Is each one load-bearing? A note carrying information the
  reader needs to succeed should be body text or a step.
- **Jargon.** Every term a newcomer wouldn't know is either written around,
  replaced, or defined on first use.
- **The word list.** For any term you're unsure about:
  `grep -A4 -i '^\*\*TERM' ~/.claude/skills/google-style/references/word-list.md`

### 4. Report

Rank findings by what they cost the reader, not by how many there are:

| Severity | What qualifies |
| --- | --- |
| Blocker | Wrong or unverifiable information; a pre-announced feature; a real name, domain, or IP in an example; an excessive security or performance claim; a step the reader can't follow. |
| Major | Structure that hides the task: missing audience, wrong heading form, no alt text, directional language, a procedure whose steps don't start with verbs, passive voice that hides who acts. |
| Minor | Word choice, punctuation, capitalization, list punctuation, code font. |
| Nit | Preference with no reader cost. Say so, and don't pad the list with these. |

For each finding give the line, the text as written, the rewrite, and the rule
in one clause. Never quote the guide at length.

```
docs/setup.md:34  Major — directional language
  As written: "Click the button in the upper right of the page."
  Rewrite:    "Click settings **Settings**."
  Rule:       Directional language breaks for screen readers and in RTL locales.
```

Close with the one change that would most improve the document. If the
document is in good shape, say that in a sentence and list only what you
found — don't manufacture findings to fill a report.

### Applying the fixes

If the user asked for fixes rather than a report, apply blockers, majors, and
minors, and list the nits you skipped. Don't restructure a document you were
asked to copyedit; if the structure is the problem, say so and ask.

Google's own principle stands: deviate from the guidance when it serves the
reader better. If a rule makes a specific sentence worse, note the exception
rather than enforcing it.
