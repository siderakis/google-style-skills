---
name: google-style-inclusive
description: Google's rules for writing accessible and inclusive developer documentation — screen-reader-safe structure, no directional language, alt text and captions, keyboard access, color as a secondary cue, gender-neutral language, ableist and violent terms to replace, how to write around a non-inclusive term that is embedded in code, and respectful language about disability. Use when auditing docs for accessibility or inclusive language, replacing terms like whitelist/master/sanity check, or writing examples involving people.
---

# Accessible and inclusive documentation

Source: https://developers.google.com/style (retrieved 2026-09-13). The word
list at `~/.claude/skills/google-style/references/word-list.md` carries the
per-term verdicts.

## Accessibility

Roughly 15% of the world's population has an accessibility need. Writing for
it improves the document for everyone.

### General

- Don't use ableist language.
- Every part of the page — tabs, buttons, interactive elements — must be
  reachable with a keyboard alone.
- Test with a screen reader. It doubles as a self-edit.
- Use semantic HTML, and prefer native elements over custom styles.
- Avoid unnecessary font formatting; screen readers announce text
  modifications explicitly.
- Never force line breaks inside sentences or paragraphs.
- Avoid camel case and all caps — some screen readers read capitals letter by
  letter, and some languages are unicase.
- Don't rely on punctuation to carry meaning; not all of it is read aloud.
  Avoid exclamation marks, question marks, and semicolons where you can.
- Don't use `&` for _and_ in headings, text, navigation, or contents. It's OK
  in a UI label that uses it, in a space-constrained table heading or diagram
  label, and in code.
- Document a product's accessibility features explicitly when it has them.

### Ease of reading

- Break up walls of text with paragraphs, headings, and lists.
- Keep sentences under 26 words.
- Define acronyms on first use, and again if they're used rarely.
- Use parallel structure for similar things.
- Put the distinguishing information of a paragraph in its first sentence.
- Avoid double negatives and exceptions to exceptions.
  - Recommended: You can continue without a path.
  - Not recommended: A missing path won't prevent you from continuing.
- Left-align text. Never center or full-justify.

### Headings, links, lists

- Descriptive, unique headings, in a hierarchy with no skipped levels, no
  empty headings, tagged with real heading elements. One `h1` for the page
  title.
- Link text must make sense read out of context — people who use screen
  readers jump link to link. Never _click here_ or _read this document_.
- Use _see_ for cross-references.
- Say so when a link does something unexpected: downloads a file, opens a new
  tab, jumps elsewhere on the page.
- Avoid adjacent links; separate them with a character.
- In a procedure, make each instruction its own list item.

### Images and media

- Every image needs an `alt` attribute — descriptive text, or `alt=""` when
  the image is decorative.
- Never present new information only in an image. Always give the text
  equivalent.
- Don't repeat images unnecessarily.
- Never an image of text, code, or terminal output.
- Prefer SVG to PNG; it stays sharp when zoomed.
- Provide captions, transcripts, or descriptions for audio and video, and make
  sure captions can be translated.
- No flickering or flashing elements — they can cause motion sickness or a
  seizure.

### Tables

- Introduce the table in the preceding text; not all screen readers announce
  tables.
- `th` for the first row and first column only; add `scope` when the table has
  both row and column headings; use `headers` with unique IDs for multi-level
  headings.
- Never merge cells — no `colspan`, no `rowspan`.
- Avoid a table inside a numbered procedure.
- Don't use a table unless it's the best way to present the information.
- Never convey information in a table through an image or symbol without a
  descriptive `alt`.

### Interactive elements and forms

Introduce an interactive element in the text before it: "To see a list of
requirements, expand the **Requirements** section."

Label every input field with a `label` element, placed outside the field.
Write validation errors that say what went wrong and how to fix it: "Name is a
required field."

### CSS and JavaScript

- Meet contrast ratios — 4.5:1 for text.
- Never `visibility:hidden` or `display:none` to convey something; both hide
  content from screen readers.
- Avoid mouseover events; if you use them, add focus and blur handlers.
- Keep the visual order consistent with the DOM order.

### Document rendering

Your document must still convey everything without sound, with only sound,
without images, without color, with a keyboard only, under screen
magnification, and without punctuation.

Never make color, size, position, or another visual cue the only carrier of
information. If color or an icon conveys state, add a second cue such as a
text label.

Refer to controls by their label: "Click **Save**," "Click
**Notifications**" — not "Click the bell icon."

**Never use directional language.** _Above_, _below_, and _right-hand side_
break for screen readers and reverse in right-to-left locales. Use _earlier_,
_preceding_, or _following_.

Recommended: In the preceding diagram, clients run jobs on multi-team or single-team clusters.
Not recommended: In the diagram above, clients run jobs on multi-team or single-team clusters.

Recommended: Click menu **Menu**.
Not recommended: In the left-side panel, click the button with three lines.

**Menu paths.** When you use angle brackets for a menu path, add an
`aria-label="and then"` so screen readers don't read `>` as "greater than."

## Inclusive language

### Gendered language

Use singular _they_. Watch for gendered nouns too.

| Recommended | Not recommended |
| --- | --- |
| Equipment installation takes around 16 person-hours. | …16 man-hours. |
| Build AI that benefits humanity. | Build AI that benefits mankind. |

### Figurative language

Precise beats clever. No metaphors, no terms used in a metaphorical sense —
don't reach for _pets versus cattle_ to describe stateless systems.

**Ableist language** — _crazy_, _insane_, _blind to_, _cripple_, _dumb_,
_sanity check_, _dummy_ — has a more accurate replacement in every case.

| Recommended | Not recommended |
| --- | --- |
| Before launch, give everything a final check for completeness and clarity. | …a final sanity-check. |
| There are some baffling outliers in the data. | There are some crazy outliers. |
| It slows down the service, causing a poor user experience. | It cripples the service… |
| Replace the placeholder in this example. | Replace the dummy variable… |

**Graphic and violent language** has one too. Instead of _STONITH_, describe
the process that stops the errant node; if you must name the term, mention it
once and de-emphasize it: "This approach might require you to fence failed
nodes (sometimes referred to as _STONITH_)."

| Recommended | Not recommended |
| --- | --- |
| If the connection doesn't respond, check for errors. | If the connection hangs, check for errors. |
| Point to **File**, and then click **New**. | Hover over **File**, and hit **New**. |

Some industry terms have a precise technical meaning with no accurate
synonym — _terminate_ and _execute_, for instance. Use the most precise
well-understood term for your context.

### Divisive framing

Don't sort people into categories the document doesn't need. Instead of
_native speakers_ and _non-native speakers_, ask whether the document needs to
raise it at all, and write the feature in terms that work for anyone. Avoid
socially charged terms for technical concepts: _blacklist_, _native_ feature,
_first-class citizen_.

### Replacing an established term

When a non-inclusive term is widely used and dropping it would confuse
readers, name it once in parentheses on first use, then use the inclusive term
throughout.

Recommended: To make sure that administrators get the notification, add them to an allowlist (sometimes called a _whitelist_).
Recommended: In this model, a Jenkins controller (master) handles HTTP requests. The Jenkins controller is designed to…

Often the better fix is to rewrite the sentence rather than swap the word:

Recommended: You can allow requests from a range of IP addresses by entering a CIDR block instead of a single address in the field.
Not recommended: You can allowlist a range of IP addresses by entering a CIDR block…

### Writing around a term embedded in code

When the term is a name or keyword you can't change, minimize it instead of
propagating it. **Never use a non-inclusive name or keyword outside code
font.** On first reference, name it in code font, in parentheses if possible;
afterwards, use the preferred term.

Recommended: The configuration file helps you create a parent node (which is named `master` in the file).
Recommended: Start the replica by using the `START SLAVE` statement.

In later mentions, write _parent node_ and _replica_, and use the literal
keyword only in code font.

### Disability and accessibility

Research how the communities you're writing about identify themselves, and use
their terms.

- Don't call people without disabilities _normal_ or _healthy_. Use
  _nondisabled person_, _sighted person_, _hearing person_, _person without
  disabilities_, _neurotypical person_.
- Avoid terms that erase personhood or define a person by a disability — _the
  disabled_, _a quadriplegic_. Use _people with disabilities_, _a
  quadriplegic person_. Many members of the autistic, blind, and Deaf
  communities prefer identity-first language, and capitalization varies;
  research and follow the community's preference.
- Avoid judgment and pity: not _victim of_, _suffering from_, or
  _wheelchair-bound_ — use _experiencing_, _living with_, _uses a wheelchair_.
- Avoid euphemisms: _physically challenged_, _special_, _differently abled_,
  _handi-capable_.

## Examples with people in them

Real people read hypothetical examples. Use a diverse set of names, genders,
ages, and locations. Use singular _they_ and don't specify gender unless it's
integral — and check that a name you picked doesn't carry a conflicting gender
connotation in another language or culture.

Watch for stereotypes in role assignment: which personas get to be the
executive, which get to be the engineer.

When writing about older adults, avoid _the elderly_, _the aged_, _seniors_,
_senior citizens_, _80 years young_. Use _older adults_ or _aging
population_, or give the person's relative age when it's relevant.

The approved given names and other safe example data are in the
`google-style-code` skill.
