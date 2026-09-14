---
name: google-style-formatting
description: Google's rules for numbers, dates and times, units of measurement, currency, mathematical notation, phone numbers, figures and images with alt text, and the text-formatting summary (when to use bold, italic, code font, and underline). Use when writing a number or a date in docs, formatting a quantity or a range, adding a screenshot or diagram, writing alt text, or deciding whether something should be bold or italic.
---

# Numbers, images, and text formatting

Source: https://developers.google.com/style (retrieved 2026-09-13).

## Text-formatting summary

| Format | Use for |
| --- | --- |
| **Bold** (`<b>`, `**`) | UI element names, run-in headings, the label at the start of a notice. Nothing else. |
| _Italic_ (`<i>`, `_`) | Terms being introduced or discussed, words as words, abbreviation introductions, titles of full-length works, mathematical variables, version variables (version 1.4._x_), and emphasis. |
| Underline | Link text only. |
| `Code font` (`<code>`, backticks) | Code in text, inline code, user input. Code blocks (`<pre>`, fences) for samples. |

In Markdown, use `**` for bold and `_` for italic — `__` and `*` are hard to
tell apart in source. In HTML, `em` means emphasis and `strong` means
importance; when you want italics or bold without that meaning, use `i` and
`b`. Never override font styles inline.

Use all capitals for placeholders. Use sentence case for headings, titles, and
navigation.

**Italics for terms.** Italicize a new term on its first mention when you
define it right there: "A _Clos network_ is a kind of multistage circuit
switching network." Italicize a word referred to as a word: "Don't use _&_ as
a conjunction. Use the word _and_ instead." Don't use bold or quotation marks
for either.

## Numbers

**Spell out:**

- Zero through nine: _four options_, _five minutes_, _nine developers_.
- A number that starts a sentence: "Fifteen directories are created." Often
  it's better to rearrange so the number comes later. A four-digit year at the
  start of a sentence is acceptable.
- A number followed by a numeral: "creates fifteen 100,000-byte files" — but
  "creates 15 of the 100,000-byte files."
- Indefinite or casual numbers: "thousands of combinations," "a million
  songs."
- All ordinals: _first_, _fifth_, _twelfth_, _forty-third_. Never _1st_,
  _5th_.

**Use numerals for:**

- 10 and greater: _24 hours_, _728 shipments_, _18,000,000 users_.
- Version numbers (_version 3_), technical quantities (_6 queries per second_,
  _50 Mbps_, _128 bits_), page numbers, chapter and section numbers, step
  numbers, prices, and numbers without units.
- Numbers under 10 that share a sentence with a number over nine: "The menu
  contains 15 options but 6 of them are deselected."
- Negative numbers, most fractions, percentages, dimensions, decimals, and
  measurements (_8 pixels_).

**Decimals.** Treat them as plural even at or below 1.0 (_1.0 inches_). Put a
zero before the point (_0.3 inches_).

**Fractions.** Express as decimals when you can. As words, hyphenate the
numerator and denominator unless one is already hyphenated: _one and
one-half_, _two-fifths_, _five sixty-fourths_.

**Percentages.** Numeral plus `%`, no space: _40%_. If it starts a sentence,
spell both out: "Forty percent of the files."

**Ranges.** Hyphen, no spaces, no en dash: _2012-2016_.

**Commas and decimal points.** American formatting: commas every three digits
left of the decimal point, including four-digit numbers (_2,000 vertices_); a
period for the decimal point; no separators right of the decimal point
(`$0.031611/vCPU hour`, not `$0.031 611`).

**Currency.** Make the currency unambiguous — `US$10` when the dollar sign
could mean several currencies. Comma for thousands, period before the
fraction, dollar sign first, no punctuation or spaces after the decimal:
`$10,000`, `$0.006653`.

**Dimensions.** Numerals with a lowercase _x_ and no spaces: _192x192_.

**Roman numerals.** Avoid them, except for sub-sub-steps in a procedure.

Accompany a numerical concept with its real-world implication — if a feature
incurs fees, link to the pricing calculator.

## Units of measurement

Put a nonbreaking space between the number and the unit: `64&nbsp;GB`,
`25&nbsp;mm`. Not `64 GB`, not `64GB`.

No space for money, percent, or degrees of an angle: `$10`, `65%`, `180°`.

Temperature: nonbreaking space before the degree symbol, no space between the
symbol and the scale — `50&nbsp;&deg;C`. Kelvin drops the degree symbol:
`300&nbsp;K`.

**Ranges** repeat the unit and use _to_, not a hyphen, because a hyphen reads
as a minus sign: `-40 °C to 85 °C`.

**Multiplied units** are hyphenated: _5 vCPU-hours_, _40 person-hours_.

**Thousands as _k_:** no space, and add a noun so _k_ doesn't read as
kilobytes: "limited to 55k download operations per day."

**Rates:** use _per_ when space allows — _requests per day_, not
_requests/day_. Shorten to _p_ only in established rate abbreviations: _Gbps_,
_MBps_ — not _Gb/s_.

**Decimal versus binary.** Match the technology you're documenting. Don't
write MB when you mean MiB.

| Decimal | Binary |
| --- | --- |
| kB (1000 bytes) | KiB (1024 bytes) |
| MB | MiB |
| GB | GiB |

## Dates and times

**Times.** 12-hour clock unless the product uses 24-hour time. Capitalize AM
and PM with one space before: _3:45 PM_. Drop the minutes on a round hour:
_3 PM_. Hyphens in ranges with no spaces: _5-10 minutes ago_. _noon_ and
_midnight_ are fine.

**Time zones.** Avoid them. When you need one: tell the reader if a time is
local ("10 AM your local time"); use the timestamp format the UI uses; spell
out the region and add the UTC offset — _US and Canadian Pacific Standard Time
(UTC-8)_. Never abbreviate a time zone name.

**Dates.** Spell out months and days of the week; give the four-digit year:
_January 19, 2017_. With a weekday: _Tuesday, April 27, 2021_. Month and year
alone take no comma: _She was hired in January 2017._ A full date mid-sentence
takes a comma after the year: _The January 19, 2017, release of…_ — but _The
January 2017 release of…_ takes none.

Abbreviate only to save space, such as in a heading or table cell: _Mon, Sep
3, 2018_ — all parts abbreviated or none, capitalized, no period, and applied
consistently.

**Numeric dates** are ambiguous across regions: 04/05/09 is May 4 in the UK,
April 5 in the US, and May 9 elsewhere. If you must use one, use ISO 8601:
`YYYY-MM-DD`, hyphen-separated — _2017-04-15_. In an invented example, pick a
day past the 12th so it can't be read as a month.

Date first, then time: _2017-04-15 at 3 PM_; _May 4, 2009, at 6 PM_.

**Seasons.** Don't. Spring in the northern hemisphere is autumn in the
southern. Use the month, the quarter, or the temperature: "During warmer
months," "In November and December," "Changes are released in October of each
year."

## Mathematical notation

Use HTML entities for symbols rather than keyboard characters: `&minus;`,
`&times;`, `&ne;`, `&plusmn;`, `&le;`, `&ge;`, `&asymp;`, `&equiv;`,
`&radic;`, `&sum;`, `&lt;`, `&gt;`. The plus sign, equals sign, and division
slash can be typed directly. Don't use an asterisk for multiplication in text.

Italicize variables; don't italicize operators. Put a nonbreaking space on
both sides of an operator: `_a_&nbsp;&minus;&nbsp;_b_`.

Keep short expressions inline, joined by nonbreaking spaces so they don't
wrap. Move an expression to its own line when it breaks awkwardly.

Exponents use `<sup>`, subscripts use `<sub>`. Never the caret: `2<sup>3</sup>`,
not `2^3`.

Notation can replace words in running text — "Check whether _a_ > _b_" — as
long as the result stays readable. When it doesn't, use words: "The area is
calculated by multiplying the length by the width," not "by multiplying _l_ ×
_w_."

For complex or multiline equations, use a diagram, an image, or a dedicated
math renderer.

## Phone numbers

Example numbers come from the reserved range 800-555-0100 through
800-555-0199. Never use a real phone number in an example.

Use a nonbreaking hyphen (`&#8209;`) so the number doesn't wrap:
`415&#8209;555&#8209;0132`. For non-NANP countries, include the country and
area codes with a plus sign and no space: _+1‑415‑555‑0132_. For an extension,
follow the number with the word _extension_: _415‑555‑0132, extension 987_.

## Figures and other images

Use an image only when it explains something words can't. Be discreet with
screenshots — capture only the UI that matters.

**Creating them:**

- Never use an image of text, a code sample, or terminal output. Use text.
- Diagrams: SVG if possible, otherwise PNG. Never a transparent background.
- Animations and video: not animated GIF. Use MP4 or similar.
- Be consistent within a doc set: same operating system, same window
  treatment.
- Crop to the relevant part — it helps the reader focus and survives UI
  changes.
- No personally identifying information. Cover it with a solid 100%-opacity
  overlay; blurs and mosaics can be reversed. Flatten layered exports.
- No image maps. Provide a list of text references after the image instead.
- Descriptive filenames.

**Introduce every image** with a complete sentence — colon if the image
follows immediately, period otherwise. A screenshot that immediately follows
the procedural text describing it needs no introduction.

**Alt text** replaces the image for anyone who can't see it. Every `img`
element needs an `alt` attribute, even when the value is empty — without one,
screen readers may read the filename.

- Use `alt=""` for a decorative image: a UI screenshot illustrating text that
  already explains the fields, a UI icon, or decoration. The test from the
  HTML spec: replacing every image with its alt text shouldn't change the
  meaning of the page.
- Don't start with _Image of_ or _Photo of_.
- Include punctuation — screen readers pause on it.
- Use the same alt text for repeated instances of the same image.
- Avoid all caps.
- Use a full sentence or a noun phrase: `alt="Architecture of an app that's
  built with Apps Script."`
- 155 characters or fewer. If the image carries more than that, summarize in
  `alt` and describe it fully in the body text.
- Write alt text for the image's context, not just its content.
- Don't introduce diagrams in the alt text, and don't use a caption as alt
  text.

**Captions** are optional. With numbers, use "**Figure 1**. Description." Use
complete sentences and end punctuation. Refer to a figure by number ("as shown
in figure 1"), lowercase _figure_ except at the start of a sentence. Never
"the image above." If you can't use figure numbers, show the figure again
rather than referring back to it.

**Figure descriptions** carry in text whatever the figure conveys. Any new
information belongs in text, never only in an image.

**Text inside figures** hurts accessibility, search, and localization. When
you must: keep it brief, avoid complete sentences and punctuation, don't
embed captions or descriptions, don't invent abbreviations, use sentence case,
use numbered callouts rather than detailed annotations, and use full
trademarked product names.

**High-resolution images.** Provide `srcset` alongside `src`. Point `src` at
the 1x image so low-resolution devices don't download the large file. The 2x
image must be exactly twice the width and height. Don't upscale a 1x image to
fake a 2x. Name it `BASENAME_2x.EXTENSION`. Browsers that support `srcset`
ignore `src`, so list every resolution in `srcset`.

**Layout.** Use the site's standard CSS — don't hand-place images or set
margins. Don't make an image too small; full column width is fine. Don't
exceed the column width. Don't center the image. Don't put an `img` inside a
`p`.
