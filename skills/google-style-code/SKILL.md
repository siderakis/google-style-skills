---
name: google-style-code
description: Google's rules for documenting computer interfaces — what goes in code font, code samples, command-line syntax and optional arguments, placeholders (UPPER_SNAKE) and how to explain them, UI elements (bold labels, menus, checkboxes, keyboard keys), API reference comments for classes/methods/parameters/return values, filenames and file types, and safe example domains, names, and IP addresses. Use when documenting a CLI, an API, a UI flow, or writing code samples and placeholders in docs.
---

# Documenting computer interfaces

Source: https://developers.google.com/style (retrieved 2026-09-13).

## Code font in text

Code font signals that text is meant to be entered verbatim, shows where the
text starts and stops, and separates it from the prose around it. HTML:
`code`. Markdown: backticks.

**Put in code font:** attribute names and values; class names; command output;
command-line utility names (`gcloud`, `kubectl`, `bq`); data types; database
row and column names; defined constant values; DNS record types; HTML and XML
element names (without angle brackets); enum names; environment variable
names; filenames, extensions, and paths; folders and directories; HTTP
content-type values; HTTP status codes; HTTP verbs; IAM role names; IP
addresses; language keywords; method and function names; namespace aliases;
placeholder variables; package names; port numbers; query parameter names and
values; strings such as URLs or domain names used inside commands and code;
text the reader types; and UI elements whose label came from text the reader
entered earlier.

**Keep in ordinary font:** domain names in prose; names of products, services,
and organizations; URLs the reader is supposed to open in a browser (better
still, make them a link with descriptive text).

**Sometimes code font:**

- **Boolean values.** Code font for the literal value — "If the update
  succeeds, returns `true`." Ordinary font for the evaluation of a condition —
  "If true, validates the SSL certificate."
- **Command-line utility names.** Code font for the command, ordinary font for
  the project: "Invoke the GCC 8.3 compiler using `gcc`." "The options for the
  `curl` command are explained on the curl project website."
- **Email addresses.** Code font when it's input or output ("enter `alex`, not
  `alex@example.com`"); ordinary font and a `mailto:` link when it's a way to
  reach someone.

A UI element that also qualifies for code font gets **both** bold and code
font: "In the **Network** list, select **`my-net-2`**."

Don't put quotation marks around code unless the marks are part of the code.

**Method names.** Omit the class name unless it prevents ambiguity: "call its
`get` method," not "call its `animal.get` method."

**HTTP status codes.** Call it a _status code_, not a response code or error
code, and put the number and name in code font: "an HTTP `400 Bad Request`
status code." For a range, use `Nxx`: "an HTTP `2xx` or `400` status code," or
"an HTTP status code in the `200`-`299` range."

**Grammar around code elements.** Don't inflect a code element or use it as an
English verb or noun. Add a noun and inflect that instead.

| Recommended | Not recommended |
| --- | --- |
| The `ADDRESS` constant's value is defined in the `settings.h` file. | `ADDRESS`'s value is defined in `settings.h`. |
| To add the data, send a `POST` request. | `POST` the data. |
| You can't call the `close` method for a file before you call `open`. | `Close`ing the file requires you to have `open`ed it first. |
| Takes an array of `INT64` values and returns `BYTES` values. | Takes an ARRAY of INT64 and returns BYTES. |

## Code samples

- Follow the indentation of the relevant language style guide — usually spaces,
  usually two per level.
- Wrap lines at 80 characters, or fewer if readers will have narrow windows or
  print the page.
- Mark code blocks as preformatted: `pre` in HTML, a fence or four-space
  indent in Markdown.
- Indicate omitted code with a comment in the sample's own language. Never
  three dots or `…`. A block with an omission must not be click-to-copy.

Precede a sample with an introductory sentence or paragraph. Colon if the
sample follows immediately; period if something else intervenes or the
paragraph ends on an unrelated sentence.

Recommended: The following code sample shows how to use the `get` method. For information about other methods, see [link]. [sample]
Also recommended: The following code sample shows how to use the `get` method: [sample] For information about other methods, see [link].
Not recommended: The following code sample shows how to use the `get` method. For information about other methods, see [link]: [sample]

Google's public language style guides live at https://google.github.io/styleguide/.

## Command-line syntax

**Best practices:**

- Link inline to the command reference, in the text that introduces the
  command or the procedure.
- Use as few optional arguments as the task needs. Let the reference carry the
  full list.
- Give a click-to-copy example the reader doesn't have to edit — only runnable
  code and placeholders. Brackets, braces, pipes, and ellipses break a pasted
  command, so keep them out of click-to-copy examples.

**Formatting a command:**

- `pre` in HTML, a code fence in Markdown.
- Past 80 characters, break before a hyphen, double hyphen, underscore, or
  quotation mark, and indent continuation lines by four spaces.
- Every line except the last ends with the continuation character: ` \` on
  Linux, ` ^` on Windows. Without it the command doesn't run.
- Follow the command with a list explaining its placeholders.
- End punctuation on an option description only when it's a complete sentence.

**Prompts.** With multiple lines of input, start each line with the prompt
symbol. Never show the current directory path before the prompt; do add a new
prompt indicator when the context changes, such as moving to a remote machine.
For a single-line command the `$` is optional, but if the page has both
single- and multi-line commands, use it everywhere. Put input and output in
separate code blocks.

**Argument notation:**

| Notation | Meaning |
| --- | --- |
| `[ARG]` | Optional. Each optional argument gets its own brackets. |
| `{A \| B}` | Choose exactly one. |
| `ARG ...` | Can repeat. Three dots, no spaces. |

When a command has optional arguments and you want click-to-copy, pick one of
these instead of shipping the brackets: remove the optional arguments and link
to the reference; give a separate code block per option; document each option
in its own section; or state plainly in the introduction that the command
contains optional arguments.

**Output.** Show output only when it adds value — the reader has to copy a
value out of it or verify something in it. Introduce it with "The output is
similar to the following:" or "The output is the following:", customized if
you want to call something out. Mark omitted output lines with `...` on its
own line, never `…`.

**Terminology.** In `gcloud`, a _flag_ is anything other than the command or
group name, and a flag or command can take an _argument_. Linux commands use
_options_, _parameters_, and _arguments_. Rather than teaching the
nomenclature, describe what the whole command does. _Option_ is the safe
catchall.

**Linux signals** are the one place to use these verbs literally, in the
context of process control: `SIGKILL` (kill), `SIGTERM` (terminate),
`SIGQUIT` (quit), `SIGINT` (interrupt), `SIGPAUSE` (pause), `SIGSUSPEND`
(suspend), `SIGSTOP` (stop). Don't substitute gentler words for these.

## Placeholders

A placeholder stands for a value the reader replaces, or a value that varies
in example output. Give it a descriptive name. Don't use a bare `x` or a run
of `x`s, except where a run of `x`s is the standard, as in HTTP status codes.

**Format:** uppercase with underscores — `API_NAME`, `METHOD_NAME`,
`PROJECT_ID`. Not `API-name`, `api_name`, or `apiName`. Never include a
possessive adjective: not `MY_API_NAME`, not `YOUR_API_NAME`.

In HTML, wrap in `var`. In Markdown inline, wrap in backticks with an asterisk
outside each one: `` *`PLACEHOLDER_NAME`* ``. Inside a code fence you can't
apply formatting. Keep brackets, braces, and ellipses outside the `var`
element.

**Explain every placeholder** the first time you use it. Repeat the
explanation only when the document is long, when several other placeholders
intervene, or when the document isn't read start to finish.

One placeholder:

> Replace `BUILD_ID` with the ID of the `WORKING` build that you copied in the preceding step.

Two or more: introduce with _Replace the following:_ and list them in the
order they appear in the command, each followed by a colon and a lowercase
description. Introduce an example inside a description with an em dash or
_such as_.

> Replace the following:
>
> - `ADMIN_PROJECT_ID`: the project that owns the reservation
> - `LOCATION`: the location of the reservation
> - `ZONE`: a Google Cloud zone close to your location—for example, `us-east1`

**Placeholders in output** get the same treatment, introduced with _This
output includes the following values:_.

## UI elements

**Prefer the task to the widget.** "Refresh the page" beats "Click
**Refresh**" when the reader doesn't need the gesture. Know the audience —
sometimes walking through the elements is the point.

**Bold every UI element name** — buttons, menus, dialogs, windows, list items,
anything with a visible label. Not code font, unless the element also
qualifies for code font, in which case use both. Don't bold a product or
feature name except when it names an element on the page.

Recommended: In the **New project** window, select the **New activity** checkbox, and then click **Next**.
Not recommended: In the New Project window, select "New Activity", and then click the "Next" button.

Match the label's capitalization, except that all-caps labels and
inconsistently cased labels become sentence case.

**Don't use a UI element as a verb or noun:**

| Recommended | Not recommended |
| --- | --- |
| In the **Name** field, enter an account name. | **Name** the account. |
| To save the settings, click **Save**. | **Save** the settings. |
| In the **Service account ID** field, enter a name. | Specify a **Service account ID**. |

**Terminology.** A _window_ is the application window or a modular element you
can open and close. A _page_ is a web page or a console subpage. A _dialog_ is
a smaller detached window. A _pane_ (or _panel_) is a region inside a larger
window — not a window, section, area, or column. A _section_ is a labeled
grouping of controls inside a window or pane. A _menu bar_ holds _menus_,
which hold _commands_ (not choices, menu items, or options). A _navigation
menu_ is a list of links to pages — not a navigation bar, pane, panel, or
window. A _toolbar_ holds buttons; one with a menu is a _menu button_. A _tab_
is the file-tab navigation element. A _text box_ is where the user types — use
"the **LABEL** box", except in Google Cloud and Google Workspace, where it's
"the **LABEL** field". A _list box_ is "the **LABEL** list". A _combo box_
takes _type or select_. A _spin box_ takes _enter_. A _checkbox_ is selected
and cleared, not checked and unchecked. A _radio button_ is referred to by its
label. An _expander arrow_ opens an _expandable section_ — never a zippy or an
expando. A _toggle_ is a noun, never a verb: "To turn on the setting, click
the **Wi-Fi** toggle."

Never use slang: no _hamburger icon_, no _zippy_.

**Menu paths with angle brackets.** Put a nonbreaking space before each
bracket, bold the whole sequence in one tag, and wrap each bracket in a span
with `aria-label="and then"` so screen readers don't say "greater than."
Angle-bracket notation is for menu items only, not for a mix of element types.

Recommended: Select **MyApp > Preferences**, and then select the **Languages** preference pane.
Not recommended: Select **MyApp** > **Preferences** > **Languages** > **+** > **CSS**.

**Buttons and icons.** Refer to a button by its label: "Click **OK**," not
"Click the 'OK' button." For an icon button, put the icon before the name from
its tooltip: "Click more_vert **Settings and utilities**," not "Click
more_vert." If you don't know an icon's name, inspect the element for
`aria-label`, `aria-labelledby`, `aria-describedby`, `label`, `placeholder`,
or `title`. If a button has no tooltip, file a bug — tooltips are an
accessibility requirement. Drop a trailing ellipsis from a label: **Browse**,
not **Browse ...**.

**Never use directional language** — _above_, _below_, _right-hand side_. It
breaks for screen readers and reverses in right-to-left locales. For a
hard-to-find element, use the icon with its name, add context ("On the Cloud
Run toolbar…"), or provide a screenshot.

**Prepositions:** _in_ a dialog, field, list, menu, pane, or window; _on_ a
page, tab, or toolbar.

**Keyboard keys.** Use `kbd` in HTML, monospace elsewhere. Uppercase letter
keys: "press Control+S," not "Control+s." Spell out modifier names (Command,
Control, Option, Shift); no symbols. Combination form: _MODIFIER+KEY_, and
_MODIFIER+Shift+KEY_ when Shift is involved. Spell out confusable characters —
comma, hyphen, period, plus. Put the macOS shortcut in parentheses after the
Windows and Linux one: "press Control+C (or Command+C on macOS)." Use _press_
for a key that triggers an action and _enter_ or _type_ for a key typed as
text. Call it a _keyboard shortcut_ or a _key combination_.

**Verbs for procedures:** click, choose, drag, enable, enter, type, go to,
hold the pointer over, press, select, tap, turn on, turn off. Check the word
list for each.

## API reference comments

The reference **must** describe every class, interface, and struct; every
constant, field, enum, and typedef; and every method, with each parameter, the
return value, and any exception thrown.

Strongly recommended: a 5-20 line code sample at the top of each page; every
API name in code font and linked to its reference page; string literals in
code font inside double quotation marks; class names spelled exactly as in
code. Don't pluralize a class name — write `Intent` objects, not `Intents`. If
a class name is also a common word, the everyday sense goes in lowercase
ordinary font (an activity, the action bar).

**Classes.** The first sentence states the purpose or function, adding what
the name and signature don't already say. Don't repeat the class name, don't
write "this class does…", and don't use a period before the end of the
sentence — some generators truncate the summary at the first period, which is
one more reason to write _for example_ instead of _e.g._

**Members.** As brief as possible, with links to the methods that use them.

**Methods.** The first sentence says what the method does. Later sentences
cover why and how to use it, prerequisites, exceptions, dependencies such as
permissions, and what happens when a dependency is missing. Present tense
throughout.

| Method kind | Description starts with |
| --- | --- |
| Performs an operation and returns data | The verb: "Adds a new bird to the ornithology list and returns the ID." |
| Getter returning a boolean | "Checks whether …" |
| Getter returning anything else | "Gets the …" |
| Turns on an ability or setting | "Sets the …" |
| Updates a property | "Updates the …" |
| Deletes something | "Deletes the …" |
| Registers a callback | "Registers …" |
| Is a callback | "Called by …" |
| Constructs the class object | "Creates a …" |

**Parameters.** Capitalize the first word and end with a period. Start a
non-boolean description with _The_ or _A_. For a boolean that tells the API
what to do, state both cases: "If true, validates the SSL certificate before
proceeding. If false, trusts the certificate without validating it." For a
boolean that reports state, use "True if …; false otherwise." Don't put _true_
and _false_ in code font or quotation marks in these descriptions. Explain
default behavior per value or range, then give the default with _Default:_.

**Return values.** Keep them brief; detail belongs in the class description.
Non-boolean starts with _The_; boolean uses "True if …; false otherwise."

**Exceptions.** If the generator inserts "Throws", start with "If …". Otherwise
start with "Thrown when …".

**Deprecations.** Name the replacement in the first sentence, since only the
first sentence reaches the summary: "Deprecated. Use #CameraPose instead."
"Deprecated. Access this field using the `getField` method." Tell the reader
what to change to make their code work, and name the version it was deprecated
in if you track versions.

## Filenames and file types

Lowercase, hyphen-separated, standard ASCII alphanumerics:
`query-data.html`. Search engines read hyphens as word breaks and generally
don't read underscores. Case-sensitive filesystems make
`Impersonate-Service-Accounts.html` a different file from the lowercase
version. Never a generic name such as `document1.html`.

If a directory already uses underscores throughout and changing it isn't
practical, stay consistent with it. Generated reference filenames are exempt.

**Referring to a file:** code font, plus the word _file_ after the name, and
the exact spelling even when it breaks the naming rules: "In the following
`build.sh` file, modify the default values."

**Don't use a file type as a verb:** "Extract a zip file," not "Unzip a zip
file."

**Refer to the file type by its formal name, not its extension:** _a PNG
file_, not _a `.png` file_; _a Bash file_, not _an `.sh` file_.

| Extension | Type name | Extension | Type name |
| --- | --- | --- | --- |
| `.adoc` | AsciiDoc file | `.pdf` | PDF file |
| `.csv` | CSV file | `.png` | PNG file |
| `.exe` | executable file | `.ps` | PowerShell file |
| `.gif` | GIF file | `.py` | Python file |
| `.img` | disk image file | `.sh` | Bash file |
| `.ipynb` | IPYNB file | `.sql` | SQL file |
| `.jar` | JAR file | `.svg` | SVG file |
| `.jpg`, `.jpeg` | JPEG file | `.tar` | tar file |
| `.json` | JSON file | `.tf` | Terraform file |
| `.md` | Markdown file | `.txt` | text file |
| `.yaml` | YAML file | `.zip` | zip file |

## Example data

Never use a real domain, email address, person's name, phone number, project
name, or credit card number.

- **Domains:** example.com, example.org, example.net (IANA-reserved), or
  altostrat.com, examplepetstore.com, example-pet-store.com,
  myownpersonaldomain.com, my-own-personal-domain.com, cymbalgroup.com.
- **Email:** one of those domains plus an example given name — dana@example.com.
  Generic addresses such as support@example.net are fine. No product names or
  made-up names in addresses.
- **Given names:** Alex, Amal, Ariel, Bola, Charlie, Cruz, Dana, Dani, Hao,
  Ira, Izumi, Jie, Kai, Kalani, Kim, Kiran, Lee, Lucian, Luka, Mahan, Noam,
  Nur, Quinn, Raha, Rosario, Sasha, Tal, Taylor, Tristan, Yuri. For a surname,
  use an initial: Quinn N. Use Alice and Bob only when documenting a
  specification that uses them.
- **Company:** Example Organization; Enterprise Example Organization and
  Startup Example Organization when you need two.
- **Phone:** 800-555-0100 through 800-555-0199.
- **IPv4:** `192.0.2.0/24`, `198.51.100.0/24`, `203.0.113.0/24` (RFC 5737).
- **IPv6:** `2001:db8::/32` and addresses within it (RFC 3849).
- **Street addresses:** 1800 Amphibious Blvd., Mountain View, CA 94045;
  Avenida da Pastelaria, 1903, Lisbon, 1229-076; 8 Rue du Nom Fictif, 341
  Paris.
- **Project names:** meaningful and descriptive, applicable to the reader's
  environment — `staging`, `frontend-development`, `production-1`. Never
  `foo`, `bar`, `baz`.
- **Service account numeric ID:** `123456789012345678901`.

## HTML and Markdown

Either is fine; parts of this guide assume HTML. Markdown is easier to read in
source; HTML is more expressive, especially for semantic tagging and special
characters. If your team or template already uses one, use that.

**Semantic tagging.** Use elements for their meaning. `cite` for the title of
a standalone work. `em` means emphasis, not italics — use `i` for
non-emphatic italics. `strong` means importance, not bold — use `b` for
non-important bold. `br` is only for line breaks that are part of the content,
such as a poem or an address; use CSS for spacing. Never use headings for
visual weight, and never use frames or tables for layout.

**HTML formatting.** Follow Google's HTML/CSS style guide, except don't omit
optional elements. Spaces, not tabs. Two-space indentation. Lowercase elements
and attributes. No trailing spaces, except where Markdown needs them. Break
lines at 80 characters, except for a `meta` element at the top of a file and
for long URLs — put a long URL on its own line. Break `pre` blocks at 80
characters too, without changing the meaning of the code.
