---
name: google-style-punctuation
description: Google's punctuation rules for developer documentation — serial commas, em dashes (and the banned en dash), hyphens and compound modifiers, colons, semicolons, parentheses, periods with URLs and quotation marks, straight quotation marks, ellipses, and slashes. Use when punctuating docs, deciding whether to hyphenate a compound, whether a comma goes before "and", or how to punctuate around code and links.
---

# Punctuation in developer documentation

Source: https://developers.google.com/style (retrieved 2026-09-13). Grammar
lives in `google-style-grammar`; list and heading punctuation lives in
`google-style-structure`.

## Commas

**Serial comma, always.** In a series of three or more items, put a comma
before the final _and_ or _or_.

Recommended: Locations are divided into zones, regions, and multi-regions.
Not recommended: Locations are divided into zones, regions and multi-regions.

**After an introductory word or phrase:** "Finally, only groups that contain
parameters appear in this list." "Based on the requirements of your game, you
can implement this method."

**Between two independent clauses** joined by _and_, _but_, _or_, _nor_,
_for_, _so_, or _yet_ — unless both clauses are very short.

Recommended: The libraries make feed creation easier, and they ensure that only valid feeds are produced.
Recommended: Type your ID and click **OK**.
Not recommended: Type your ID, and click **OK**.

**Between an independent and a dependent clause:** only if the sentence could
be misread without it.

Recommended: Direct-access flags are plain variables and can be read directly.
Recommended: The manager acknowledged the last team member who entered the room, and started the meeting.

**Other clauses.** Put a comma before _which_ at the start of a nonrestrictive
clause. Put a semicolon, period, or dash before a conjunctive adverb
(_however_, _otherwise_, _therefore_) and a comma after it. Don't put a comma
before _because_ unless it starts a nonrestrictive clause.

| Recommended | Not recommended |
| --- | --- |
| Name of the group, which has a maximum length of 200 characters. | Name of the group which has a maximum length of 200 characters. |
| The variable must have a value; otherwise, the server returns an error. | The variable must have a value otherwise the server returns an error. |
| You can use the same key name in multiple backend services and backend buckets, because each set of keys is independent. | …and backend buckets because each set of keys is independent. |

## Em dashes

Use an em dash (—) for a break in the flow of a sentence. No space before or
after it. In HTML, `&mdash;`. On macOS, Option+Shift+hyphen.

**Don't use an en dash at all.** Use a hyphen or the word _to_ instead.

Don't use a dash to separate an item from its description. Use a colon or a
period:

Recommended: Example: This is an example.
Not recommended: Example - This is an example.

Recommended: Appendix A: My first appendix
Not recommended: Appendix A—My first appendix

## Hyphens

Hyphenate for clarity. Three things decide it: where the term sits in the
sentence, whether the sentence is ambiguous without the hyphen, and
convention. When unsure, check in this order: the convention in the
documentation you're working on, then the word list, then Merriam-Webster.

**Prefixes.** In general, no hyphen: _infrastructure_, _megabyte_, _metadata_,
_preprocessing_, _pseudocode_, _semiconductor_. Add one when:

- The prefix is _self_ or _cross_: _self-managing_, _cross-region_.
- The noun is capitalized or a number: _non-Google_, _post-2000_.
- It prevents a misreading: _de-energize_, _intra-index_, _re-mark_, _re-sign_.
- The base term already has hyphens or spaces: _un-Google-like_.
- Consistency within a document requires it: _pre-processing_, _post-processing_.

_non_ often needs a hyphen because it forms hard-to-parse words. Both
_noncurrent_, _nonempty_, _noninteractive_, _nonpublic_ and _non-existence_,
_non-integer_, _non-key_, _non-managed_, _non-negative_ are recommended; be
consistent. Always hyphenate before a hyphenated compound: _non-KSA-based_.

**Compound nouns** are closed by default: _webpage_, _hostname_, _tradeoff_,
_workaround_. The word list carries the exceptions (_multi-region_, _style
sheet_). Hyphenate multiplied units: _5 vCPU-hours_, _40 person-hours_.

**Compound modifiers before a noun.** Hyphenate for clarity — it's almost
never wrong: _a well-designed app_, _Android-specific techniques_. Hyphenate
after _more_ or _most_ when needed: _edge locations with more-reliable
internet links_. Avoid compound modifiers longer than two words; move words
after the noun instead:

Recommended: test cases that are specific to the 2023 edition
Recommended: cross-data-center replication
Not recommended: edition-2023-specific test cases

Hyphenate a number with a spelled-out unit when they modify a noun: _a 64-bit
system_, _100,000-byte files_, _a five-minute wait_. Don't hyphenate when the
unit is abbreviated — use a nonbreaking space instead: `200&nbsp;GB disk`.

Don't hyphenate _-ly_ adverbs: _publicly available implementations_. Don't
hyphenate compounds that convention leaves open: _a managed instance group_,
_a machine learning model_.

**After a verb**, generally no hyphen: "The app is well designed." "The logs
are written in real time." "The product supports high availability." Some
terms stay hyphenated anyway: _on-premises_, _add-on_, _cloud-based_,
_customer-facing_, _user-friendly_, _game-like_.

**Number ranges** take a hyphen, not an en dash: _8-20 files_, _5-10 minutes_.
If a hyphen is ambiguous, use words — _from 8 to 20 files_ — but don't mix
("from 8-20 files" is wrong).

**Spaces.** Never around a hyphen, except after a suspended hyphen: "scan for
new files at one-, two-, or three-hour intervals."

## Colons

The text before a colon must stand alone as a complete sentence.

Recommended: The fields are defined as follows:
Not recommended: The fields are:

Lowercase the first word after a colon, unless it's a proper noun, a heading,
a quotation, or follows a label such as _Caution_.

## Semicolons

Avoid semicolons if you can. Three cases justify one:

- Joining two closely related independent clauses where a period or comma is
  weaker: "You can easily test compatibility by computing the centroid; if it
  is on the opposite side of the planet, reverse the order of your vertices."
- Before a conjunctive adverb or a phrase such as _that is_ that joins two
  independent clauses: "…below the Main Camera; therefore, only the stereo
  cameras are affected."
- Separating long or complex series items that contain their own punctuation:
  "…checking for the following: present tense and active voice; typos,
  punctuation, and grammar; and whether you can shorten anything."

## Parentheses

Some readers skip anything in parentheses, so don't put important information
there. Whenever you reach for parentheses, check whether commas, dashes,
semicolons, or a second sentence would work. Keep a mid-sentence parenthetical
short.

Recommended: Enter a name for the instance—for example, `my-instance-99`.
Recommended: Enter a six-digit hex number (for example, `228B22`), and then click **OK**.
Not recommended: Enter a name for the instance (for example, `my-instance-99`).
Not recommended: Enter a six-digit hex number (for example, if you want the color forest green, enter `228B22`), and then click **OK**.

A full standalone sentence inside parentheses keeps its period inside.

## Periods

End every complete sentence with a period unless it's a question. Lists are
the exception — see `google-style-structure`.

**URLs.** A period right after a URL is hard to tell apart from the URL. Avoid
URLs in text; rewrite so the URL isn't last; or put the URL on its own line
with no period.

Recommended:
> We use your feedback to improve the Animals API, in accordance with Example Pet Store's Privacy Policy:
>
> http://www.examplepetstore.com/privacy/

**Quotation marks.** The period goes inside, even when it isn't part of the
quoted material: `you might say "Fixed typo."` If the quoted material ends
with a question mark or exclamation point, don't add a period: `Children
always ask "Why?"`

**Parentheses.** Period outside when the parenthetical ends a sentence; inside
when the parentheses contain a whole sentence.

**Headings** take no period. **Decimal points** are periods, not commas. One
space between sentences.

**Exclamation points.** Avoid them. By content type: never in concept and
reference docs; avoid in procedures (use a period for a completion step — "The
VM is created."); acceptable in blog posts but not every paragraph. They're
fine in code (`!=`), in literal error strings that must match exactly, and
sparingly at a tutorial milestone. In Japanese and Korean an exclamation mark
can read as shouting.

## Quotation marks

Use straight double quotation marks and straight apostrophes everywhere — not
curly ones. Code requires straight marks, autocorrect tools get curly marks
wrong, and curly marks are hard to proofread.

Technical writing barely needs quotation marks. Use them for:

- A section of a larger document you can't link to directly.
- The title of a parent document when you're linking to a section of it.
- A direct quotation, slogan, or motto.
- A term used metaphorically, when that usage isn't established in the domain.

Titles of full-length works take italics instead.

Commas and periods go inside quotation marks — "See the section titled 'Care
and feeding of the emu.'" **Exception:** when the quoted text is a literal
string, put other punctuation outside so nothing extraneous lands inside the
string. Better still, use code font and no quotation marks:

Recommended: If you enter `escape`, the program crashes.
Acceptable: If you enter "escape", the program crashes.
Not recommended: If you enter "escape," the program crashes.

Single quotation marks appear only in code samples in languages that use them,
and around a quotation nested inside a quotation.

## Ellipses

In general, don't use them. Never as suspension points ("The answer is …
wait for it …").

When a UI label ends in an ellipsis, leave it out of the documentation: a
button reading **Save …** is documented as "click **Save**."

In quoted text, an ellipsis can replace omitted material, but not at the
beginning or end of the quotation. Use three periods, not the ellipsis
character. Put a space before and after, unless punctuation immediately
follows. If the omitted material crosses a sentence boundary, use four dots
(the fourth is the period).

## Slashes

Avoid slashes except in code, file paths, and URLs.

- **Dates:** never. See `google-style-formatting`.
- **Alternatives:** use _and_ or _or_. "…developed or is hosted by a
  commercial entity," not "developed/hosted."
- **And/or:** usually _and_ implies _or_. "You can view and edit your own
  data." When you need both: "You can export raw events, processed events, or
  both." Use _and/or_ only where space is tight, such as a table.
- **File paths and URLs:** forward slashes, backslashes for Windows paths.
  Break a long URL after a slash; never insert a hyphen to break one.
- **Fractions:** ambiguous. Use ¾, 0.75, or 75%.
- **Abbreviations:** spell them out. _care of_, _with_ — not _c/o_, _w/_.
