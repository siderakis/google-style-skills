---
name: google-style-grammar
description: Google's rules for grammar in developer documentation — active voice, present tense, second person, pronouns and singular they, articles, capitalization and sentence case, contractions, abbreviations and acronyms, plurals, possessives, prepositions, anthropomorphism, and verbs in reference docs. Use when writing or fixing sentences in docs, when deciding whether to spell out an acronym, how to capitalize something, or whether a construction is passive.
---

# Grammar in developer documentation

Source: https://developers.google.com/style (retrieved 2026-09-13). Core
principles live in the `google-style` skill; punctuation lives in
`google-style-punctuation`.

## Active voice

Use active voice: the grammatical subject performs the action. Passive voice
lets you leave out who is supposed to act, which is exactly the information
the reader needs.

Recommended: Send a query to the service. The server sends an acknowledgment.
Not recommended: The service is queried, and an acknowledgment is sent.
Not recommended: The service is queried by you, and an acknowledgment is sent by the server.

Passive is fine in three cases:

- To emphasize the object over the action: "The file is saved."
- To de-emphasize the actor: "Over 50 conflicts were found in the file,"
  rather than "You created over 50 conflicts in the file."
- When the reader doesn't need to know who acted: "The database was purged in
  January."

## Present tense

Use present tense for behavior that isn't tied to a particular time.

Recommended: Send a query to the service. The server sends an acknowledgment.
Not recommended: Send a query to the service. The server **will** send an acknowledgment.

Future tense is correct when the action genuinely happens later: "Add the
filename to the backup list. The file will be archived the next time the
backup process runs." Asynchronous behavior is the common case: "A message is
sent that will notify any Pub/Sub subscribers."

Never use future tense to describe how a product will work after the next
release. Avoid the hypothetical _would_.

## Second person

Address the reader as _you_. Use _user_ only for the user of the software your
reader is building.

Recommended: The following sections describe how **you** can create a website.
Not recommended: The following sections describe how **we** can create a website.
Not recommended: **Let's** add a description to our table.

For an instruction, use the imperative — the _you_ is implied: "Click
**Submit**." It's fine to use the imperative in running text once you've
established who you're addressing, but consider whether the text should be a
formatted procedure instead.

Use the third person for what the software or an end user does. In API
reference, state facts about programming elements in the third person and
address the reader as _you_ when telling them what to do.

First-person plural (_we_, _our_, _us_) is acceptable for the organization
that authors the document, as long as the antecedent is clear: "Example
Organization provides A and B, but we don't provide C and D." Avoid _I_,
except in FAQ questions and signed commentary.

Identify who _you_ is — a developer, a sysadmin, someone else — and stay
consistent. An explicit audience sentence near the top helps.

## Sentence structure

Put the circumstance, condition, or goal before the instruction, so a reader
it doesn't apply to can skip it.

| Recommended | Not recommended |
| --- | --- |
| For more information, see [link]. | See [link] for more information. |
| To delete the entire document, click **Delete**. | Click **Delete** if you want to delete the entire document. |
| If your app is located in one of the following regions, using custom domains might add latency: | Using custom domains might add latency if your app is located in one of the following regions: |

## Pronouns

Make sure every pronoun clearly refers to its antecedent.

Recommended: If you type text in the field, **the text** doesn't change.
Not recommended: If you type text in the field, **it** doesn't change.

Follow a demonstrative pronoun with a noun: "Set **this value** to true," not
"Set this to true." "**These approaches** are your best options," not "These
are your best options."

**Gender-neutral pronouns.** Don't use _he_, _him_, _his_, _she_, or _her_ as
gender-neutral pronouns, and don't use _he/she_ or _(s)he_. Use singular
_they_.

**Optional pronouns.** Keep _that_ and _which_ even when speech would drop
them: "Right-click the link **that** you want to open."

**Relative pronouns.** _That_ introduces a restrictive clause and takes no
comma — "The echidna that has a long snout is furry" describes one particular
echidna. _Which_ introduces a nonrestrictive clause and takes a comma — "The
echidna, which has a long snout, is furry" describes all echidnas. Use _who_
for people; _that_ is acceptable if you're unsure. _Whose_ works for people,
animals, and things: "Examine the variables whose values are set at compile
time."

## Articles

Include _a_, _an_, and _the_. Don't drop them for brevity, including in
headings.

Recommended: Create **a** VM instance
Not recommended: Create VM instance

Choose _a_ or _an_ by the following word's sound, not its spelling. The guide
settles three common abbreviations: _a SQL_, _a FHIR_, _an SAP_.

Don't use _the_ before a product name unless the name modifies something else.
Do use _the_ before tool and API names: "The Transcoder API," "The `gcloud`
CLI," "The Google Cloud console," but "Using Cloud Datastore with Cloud
Dataproc."

## Capitalization

Follow standard American English rules, plus:

- Don't capitalize a word without a reason.
- Don't let capitalization carry meaning. A reader new to Kubernetes won't
  register the difference between _Pod_ and _pod_.
- No all-uppercase except in official names, always-capitalized
  abbreviations, or code that uses all caps.
- No camel case except in official names or code.

**Sentence case for titles and headings** — capitalize the first word, the
first word after a colon in a subheading, and proper nouns. No period at the
end of a heading.

When you reference a title from a document that follows this guide, write it
in sentence case even if the original uses title case. Keep the original
capitalization when citing an outside work.

After a colon, start with lowercase unless the text is a proper noun, a
heading, a quotation, or follows a label such as _Caution_ or _Note_.

Sentence case also applies to: captions, labels and callouts in images,
glossary definitions, all list items, and every element of a table (contents,
headings, labels, captions). Glossary and index terms themselves are
lowercase unless the term is a proper noun.

When a hyphenated word starts a sentence or heading, capitalize only the first
element unless a later element is a proper noun.

**Don't name a casing style.** _camel case_ and _snake case_ don't localize
and aren't standardized. Describe the requirement and show an example: "Enter
the value for the `attribute` field in the format where there are no spaces
between words and the first letter of each word is capitalized — for example,
`AssertionAccount`."

Product names are title case; feature names are lowercase unless officially
capitalized. Match a UI label's capitalization when you're referring to the
label, and use sentence case if the label is all caps or the labels are
inconsistent.

## Contractions

Use common two-word contractions: _you're_, _don't_, _there's_. Negation
contractions especially — a reader scanning can miss _not_ but rarely misreads
_don't_ as _do_.

Don't invent contractions (_guides're_, _browser's_ meaning "browser is") and
don't use three-word contractions (_mightn't've_).

## Abbreviations

An acronym is pronounced as a word (NATO, scuba); an initialism is spelled out
letter by letter (CIA, API). The distinction rarely matters — _acronym_ covers
both. A shortened word is part of a word, sometimes with a period (_Dr._,
_etc._, _min_, _CA_).

Short forms of words — _app_, _demo_, _sync_ — aren't abbreviations and take
no period. The test: if you say it as a word, treat it as a word.

**When to spell out.** Spell out an unfamiliar abbreviation on first mention
with the abbreviation in parentheses, then use the abbreviation alone. If a
term appears only once, include the abbreviation only if it's as common as the
spelled-out form. If first mention falls in a heading, you can use the
abbreviation there and spell it out in the first paragraph.

Don't abbreviate a term unrelated to the document's main topic:

Recommended: The internet of things (IoT) service can even be used for connecting to sensors in low Earth orbit.
Not recommended: The IoT (internet of things) service can even be used for connecting to sensors in LEO (low Earth orbit).

Don't spell out a term when spelling it out doesn't help — _portable document
format_ explains nothing about a PDF. These rarely need spelling out: AI, API,
DVD, file formats (PDF, XML), HTML, PC, RAM, REST, units (MB, MiB, GB, GiB),
URL, USB.

**Format of the introduction.** Italicize both the term and the abbreviation:
"Establish _Border Gateway Protocol_ (_BGP_) sessions…". Capitalize the
spelled-out form only if it's a proper noun — _data manipulation language
(DML)_, not _Data Manipulation Language (DML)_. Include the abbreviation
inside link text.

**Never use** _i.e._ or _e.g._ — write _that is_ and _for example_. Avoid
_etc._ in most lists. No internet slang. Spell out symbol substitutions: "10
times faster," not "10x faster." Use the spelled-out word when it's common and
clear: _approximately_, not _approx._

**Periods.** None on acronyms or initialisms. A period ends a shortened word,
except date and time abbreviations. None after a word-like short form (_app_,
_sync_). None in country, US state, or DC abbreviations.

**Don't use an abbreviation as a verb.** "Use SSH to log in to your remote
shell," not "Then ssh into your remote shell."

## Anthropomorphism

Don't give software or hardware human qualities.

Recommended: A Delimiter object specifies where to split a string.
Not recommended: A Delimiter object tells the splitter where a string should be broken.

Recommended: The PC detects a new device.
Not recommended: The PC sees a new device.

## Pluralization

Standard US English plurals. Never form a plural with _'s_ — it collides with
possessives and contractions.

Watch agreement in long subjects: "Confirm that **the number** of entries
listed in the directory **is** accurate." With subjects joined by _and_ or
_or_: "The request payload and header information **are** logged"; "Either the
API keys or service account **wasn't** authenticated."

Use a plural after _one or more_ ("If one or more tests fail…") and a singular
after _more than one_ ("You can create more than one instance at a time").

**Abbreviations.** APIs, SKEs, IDEs — no apostrophe. Add _es_ after _s_, _sh_,
_ch_, or _x_: OSes, DISHes, BMXes. Match number between the spelled-out term
and the abbreviation: _virtual machines (VMs)_, not _virtual machines (VM)_.
Don't pluralize a unit abbreviation used with a number: _64 GB_, not _64 GBs_.
Spell out the unit as singular only for one: _1 degree_, but _0 degrees_, _0.5
degrees_, _15 degrees_.

**Class names.** Don't inflect them. Write `Intent` objects and `Activity`
instances — never `Intent`s, `Intents`, or `Activities`.

**No optional plurals in parentheses.** Pick one form:

| Recommended | Not recommended |
| --- | --- |
| To find your API key, visit the **Credentials** page. | To find your API key(s), visit the **Credentials** page. |
| The value of the parent depends on the values of its children. | The value of the parent depends on the value(s) of its child(ren). |
| a physical linecard, which can contain one or more ports | a physical linecard, which can contain port(s) |

Don't form a plural or possessive from a product, feature, or company
trademark.

## Possessives

Singular nouns, including those ending in _s_, take _'s_: "each vector's
record," "the storage class's quota." Plural nouns ending in _s_ take an
apostrophe only: "the models' capabilities." Plural nouns not ending in _s_
take _'s_.

If a possessive reads awkwardly, rewrite: "Analyze the business data," not
"Analyze the businesses' data." "The rule that the Federal Trade Commission
(FTC) issued," not "The Federal Trade Commission's (FTC's) rule."

**Product, feature, and trademark names** take no possessive when you're
describing function or performance. Use the name as a modifier or rewrite with
_of_:

Recommended: You can use this template to monitor Google Search performance.
Recommended: …to monitor the performance of Google Search.
Not recommended: …to monitor Google Search's performance.

A company name takes _'s_ when it isn't acting as a trademark: "Google's new
office is nearby," but not "the capabilities of Google's Search."

**Code items** never take a possessive. Form it from the following noun, or
rewrite:

Recommended: Compare the number to the `wordCount` method's return value.
Recommended: Compare the number to the value returned by the `wordCount` method.
Not recommended: Compare the number to `wordCount`'s return value.

## Prepositions

There's no rule against ending a sentence with a preposition. Put it where the
sentence reads best.

Recommended: For details, see the client library documentation for the language you're interacting with.
Not recommended: …for the language with which you're interacting.

Keep prepositions that add clarity, drop the ones that don't, and don't pile
them up.

## Verbs in reference documents

Phrase a method description in terms of what the method does, not what the
developer uses it to do. The difference is one _-s_.

Recommended: tasks.insert: **Creates** a new task on the specified task list.
Not recommended: tasks.insert: **Create** a new task on the specified task list.

## Spelling

Standard American spelling. For a specific word, grep the word list:
`~/.claude/skills/google-style/references/word-list.md`. When the word list is
silent, Merriam-Webster settles it; if the entry lists several spellings, use
the first.
