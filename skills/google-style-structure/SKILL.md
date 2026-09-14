---
name: google-style-structure
description: Google's rules for how a document is put together — headings and titles (task-based vs conceptual, sentence case, hierarchy), lists (numbered, bulleted, description, run-in headings, capitalization and end punctuation), tables vs lists, step-by-step procedures, note/caution/warning notices, paragraphs, and cross-references and link text. Use when outlining a doc, writing a procedure or tutorial, choosing between a list and a table, writing headings, or writing link text.
---

# Document structure

Source: https://developers.google.com/style (retrieved 2026-09-13).

## Headings and titles

Write the document title from the document's primary purpose; write each
section heading from the type of content in that section.

| Kind | Form | Recommended | Not recommended |
| --- | --- | --- | --- |
| Task | Bare infinitive (base-form verb) | Create an instance | Creating an instance |
| Concept | Noun phrase not starting with _-ing_ | Migration to Google Cloud | Migrating to Google Cloud |
| Optional section | `Optional:` prefix | Optional: Customize your alias | Customize your alias (optional) |

Mixing task and concept headings in one document is fine — each heading takes
the form that fits its own section.

Avoid an _-ing_ verb as the first word of a heading. These translate
inconsistently and eat characters. Gerunds that are simply the name of the
thing — _Billing_, _Pricing_ — are fine, and an _-ing_ form later in a heading
is fine: "Introduction to BigQuery monitoring."

**Format:**

- Sentence case. No period at the end.
- Keep punctuation simple. Complex punctuation means the heading is too
  complicated.
- Limit abbreviations to the more commonly known form of a word; define it in
  the first paragraph after the heading.
- No numbers to indicate sequence — the hierarchy carries that.
- Avoid code items in headings. If you must, add a descriptive noun after the
  code-font item.
- No links in headings.

**Hierarchy:**

- One unique `h1` per page, used once.
- Don't skip levels: an `h3` only under an `h2`.
- Don't use a heading level for its visual weight. Use CSS.
- Never leave a heading with no content under it.
- Don't repeat the page title as a heading on the page. If the page is
  _Create and start VM instances_, its sections are _Create a VM_ and _Start a
  VM_.

When you introduce a group of lower-level sections, write "the following
sections," not "this section" or "these sections."

**Anchors.** Add a custom anchor when the automatic one is long, when the
section gets linked to often, or when you're about to revise a heading that
already has links pointing at it. Anchor text is lowercase with hyphens
between words. If you revise a heading, create a custom anchor using the old
ID so existing links keep working. Don't change an existing custom anchor
unless it contains a term you need to remove.

## Lists

Don't make a list of one item.

| Type | Use for | Elements |
| --- | --- | --- |
| Numbered | A sequence: ordered steps, phases, priorities | `ol`, `li` |
| Bulleted | Anything not a sequence | `ul`, `li` |
| Description | Terms each with a definition, as in a glossary | `dl`, `dt`, `dd` |
| Description with bulleted run-in headings | Several concepts to highlight and explain, or to save space | `ul`, `li` |

Nested numbered lists use lowercase letters, then lowercase Roman numerals.

**Introductions.** Precede a list with a complete sentence, not a fragment the
list items finish. End it with a colon if the list follows immediately, a
period if something (such as a note) sits between. You can use _the following_
as a noun phrase. Skip the introduction when the preceding heading is context
enough.

| Recommended | Not recommended |
| --- | --- |
| Use the **Submit** button for any of the following purposes: | Use the **Submit** button to: |
| To get the USB driver, follow these steps: | To get the USB driver: |
| If you need to add an instance manually, do the following: | If you need to add an instance manually: |

**Parallel syntax.** Every item in a list takes the same structure.

**Capitalization and end punctuation.** Start each item in a numbered,
lettered, or bulleted list with a capital letter, unless case carries meaning
(a list of glossary terms). End each item with a period, except when:

- the item is a single word,
- the item has no verb,
- the item is entirely code font, or
- the item is entirely link text or a document title.

If that produces a list with mixed punctuation, either rewrite for parallel
construction or punctuate every item.

```
The following words are adjectives:      The API supports the following actions:
- Big                                    - Create
- Small                                  - Replace
- Gratuitous                             - Delete

You can do any of the following by using the API:
- Create an item.
- Replace one item with another.
- Delete an item.
```

**Description lists.** Capitalize each term; no period after the term; a
period at the end of each description. Don't attach an explanatory phrase to
only one item of a bulleted list — convert the whole thing to a description
list.

**Run-in headings.** Capitalize the heading. End it with a period or a colon,
consistently within the list. Text after a period starts capitalized and ends
with a period; text after a colon starts lowercase and takes a period only if
it contains a verb or expresses a standalone thought. Never use a dash to set
off the description.

```
The following words are adjectives:
- **Big**: a short word
- **Relevant**: a fancy word
- **Purple**: a vibrant color

Budget Airlines reduces your ticket cost in several ways:
- **It increases fuel economy by reducing baggage weight**. By charging...
- **It carries more passengers per flight**. By reducing leg room...
```

**Comma-separated lists in a paragraph** use serial commas. Don't end one with
_etc._ or _and so on_; introduce it so the reader knows it isn't exhaustive:
"The service processes data like event logs, clickstream data, social network
interactions, and e-commerce transactions."

Any list item can hold more than one paragraph. Use `p` elements, not `br`.

## Lists or tables

| Each item is | Example | Use |
| --- | --- | --- |
| A single unit | Language names; steps to follow | A numbered, lettered, or bulleted list |
| A pair of related data | Term and definition | A description list (sometimes a table) |
| Three or more related data | Parameters with a name, type, and description | A table |

**Don't use a table** for page layout, for a single column, for code snippets,
or to break one long list into columns. Avoid tables inside a numbered
procedure. A single-row table is usually the wrong choice, though reference
docs sometimes want one for layout consistency.

**Table rules:**

- Introduce every table with a complete sentence — screen readers don't always
  announce a table. Colon if the table follows immediately, period otherwise.
  Refer to its position: "the following table," "the preceding table."
- Don't put a table in the middle of a sentence.
- No styling on the `table` element; no font or background color standing in
  for a header. Use `th`, plus the `scope` attribute.
- Headings on the first row and first column only.
- Never merge cells. No `colspan`, no `rowspan`.
- Sort rows logically, or alphabetically when there's no logical order.
- Split a long or multi-header table into several tables.
- Column heads: sentence case, concise, no end punctuation.
- Never convey information in a table through an image or symbol alone —
  always give the image a descriptive `alt` attribute.
- Avoid footnotes; if you need them, put them immediately after the table.
- One table needs no caption. Several tables near each other each get one, as
  the first child `caption` element, in the form "**Table 2.** Description" —
  sentence case, no final period. Refer to it by number ("as shown in table
  2"), lowercase _table_ except at the start of a sentence.
- Avoid linking to a table; refer to it by number.
- Use CSS that adapts to the viewport.

## Procedures

A procedure is a numbered sequence of steps for one task.

**Introduce it** with a sentence that adds context the heading doesn't already
give. If the heading says it all, skip the introduction. Never introduce a
procedure with a fragment the steps complete.

Recommended: To customize the buttons, follow these steps:
Recommended: Customize the buttons:
Recommended: To customize the buttons, do the following:
Not recommended: To customize the buttons:

**One step?** Write it as a single sentence formatted as a bulleted list item,
not a one-item numbered list.

**Sub-steps** take lowercase letters, then lowercase Roman numerals. A step
with sub-steps ends in a colon or a period, like any list introduction.

**Order inside a complex step:**

1. The action to take.
2. The command, if any.
3. The placeholders used in the command.
4. Further explanation of the command, if needed.
5. The command's output, if needed.
6. In a separate paragraph, the result of the action.

**The rules that catch most drafts:**

| Rule | Recommended | Not recommended |
| --- | --- | --- |
| Start each step with an imperative verb | Clone the repository that contains the sample data. | You need the project ID later. Retrieve the project ID. |
| State where before stating the action | In Google Docs, click **File > New > Document**. | Click **File > New > Document** in Google Docs. |
| State the goal before the action | To start a new document, click **File > New > Document**. | Click **File > New > Document** to start a new document. |
| Mark an optional step with `Optional:` | Optional: Type an arbitrary string… | (Optional) Type an arbitrary string… |
| Don't say _please_ | To open a document, click **File > Open**. | To open a document, please click **File > Open**. |
| Don't introduce code with "run the following command" | In Cloud Shell, deploy the load generator: | Run the following command: |
| Keep a required **Enter** in the same step | Click the search box, type `custom function`, and then press **Enter**. | Two separate steps |
| Don't include keyboard shortcuts | Copy the command, and then paste it… | Press Ctrl+C, and then press Ctrl+V… |
| No directional language | In the preceding diagram… | In the diagram below… |

When a "To …" goal could read as making a required step optional, use the
colon form instead: "Sort the data by date: …".

**Results and justifications** come after the action, in the same paragraph:
"Click **Run**. The query results appear after the query runs." Don't state a
result and then repeat it as the next step's context.

**Combining actions.** One step per action, except sequential menu selections,
which combine with angle brackets: "Click **File > New > Document**." If a
step feels long, split it.

**Multiple ways to do the same task.** Document one procedure that works for
everyone. Prefer the one that works with a keyboard alone, then the shortest,
then the one in the language most of your audience knows. If you must document
several, separate them by page, heading, or tab.

**Repetition.** Don't repeat a procedure — link to it.

Make sure the reader knows what they need before they start, and keep the
number of steps and interruptions as low as you can.

## Notices

A notice sets information off from the flow of the text. Readers skip things
outside their focus, so write the information as ordinary text first and then
decide whether it needs a notice. Too many notices on a page cancel each other
out; two in a row is a sign to reorganize.

| Type | Means |
| --- | --- |
| Note | An aside or tip: useful, not critical. |
| Caution | Proceed carefully. |
| Warning | Don't do this, or this may be irreversible — lost money, lost work, a security breach. |
| Success | An action succeeded. Interactive or dynamic content only. |

Use a **note** only when all three are true: the information is relevant but
not necessary; interrupting here doesn't obstruct the reader; and the
information isn't a continuation, a result, or a pointer to more reading.

Don't use a note for a cross-reference, for a prerequisite (that belongs
before the step), for a whole procedural step, for anything the reader needs
in order to succeed, or for text that simply continues what precedes it.

## Paragraphs

One idea per paragraph, in the fewest sentences. Put the most important
information first — readers don't read every word. More than five or six
sentences usually means the paragraph carries too much, though a single-idea
paragraph can run longer, and a one-sentence paragraph is fine.

Don't lengthen sentences to shorten a paragraph. Left-align text. Don't force
line breaks inside sentences.

## Cross-references and links

Every link is a decision for the reader and a chance to lose their place.

**Choose links selectively.** When a definition, a short concept explanation,
or two steps would do, put it on the page instead of linking. Don't duplicate
a link within a page, except when linking to a specific section, when the page
is long and the links are far apart, or when the page has several entry
points. Link to the most relevant page, and to the most relevant heading on
it.

**Write descriptive link text** — either the exact page title, or a phrase
describing the destination, capitalized as part of the sentence. Put the
important words first. Don't reuse the same link text for different targets in
one document. Keep it short.

Recommended: For more information, see [Load balancing and scaling](…).
Recommended: You can use Cloud Scheduler and Cloud Functions to manage [task scheduling on Compute Engine](…).
Not recommended: See [this blog post](…).
Not recommended: Want more? [Click here!](…)

Never use _this document_, _this article_, or _click here_. Don't use a URL as
link text. Include an abbreviation inside the link text: "[Google Kubernetes
Engine (GKE)](…)", not "[Google Kubernetes Engine](…) (GKE)". Include the
descriptive noun with a code element: "the [`--hostname` flag](…)", not "the
[`--hostname`](…) flag."

**Introduce a standalone cross-reference** with "For more information, see …"
or "For more information about …, see …". Use _about_, never _on_. Use _see_,
not _refer to_ or _read_. Add the "about" clause whenever the link text alone
doesn't say why you're sending the reader there.

**Explain unexpected behavior.** Say so when a link downloads a file (and name
the file type), opens an email, jumps to another section of the same page, or
opens in a new tab. Don't force a link to open in a new tab. Don't use an
external-link icon; if it matters that the reader is leaving, say so in the
text.

**Punctuation and formatting.** Put punctuation outside the link tags. Don't
put link text in quotation marks. For an unlinked reference: quotation marks
for a section or short work, italics for a full-length work.

Avoid external links in a documentation set's navigation. If you need one,
make it obvious the reader is leaving.

**Link styling**, if you control the CSS: contrast link color against body
text, underline link text and nothing else, and change the color of visited
links.

## Footnotes

Avoid them — they're bad for accessibility and for localization. Use a
cross-reference, a note, or a parenthetical instead. If there's no other way,
use a superscript number (`<sup>1</sup>`).
