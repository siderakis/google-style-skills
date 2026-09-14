#!/usr/bin/env bun
// Interactive skill picker: arrow keys to move, space to toggle, enter to apply.
// install.sh runs this when bun is available and stdin is a terminal, and falls
// back to a plain prompt when it isn't. All symlink changes go through
// `install.sh set`, so this file only decides the selection.

import { basename, join } from "node:path";
import { readdirSync, readFileSync, lstatSync, readlinkSync } from "node:fs";
import { spawnSync } from "node:child_process";

const [repo, target] = process.argv.slice(2);
if (!repo || !target) {
  console.error("usage: pick.ts REPO_DIR TARGET_SKILLS_DIR");
  process.exit(2);
}

const src = join(repo, "skills");

type Skill = {
  name: string;
  group: string;
  presets: string[];
  blurb: string;
  on: boolean;
  conflict: boolean;
};

// --- catalog ---------------------------------------------------------------

function readManifest(): Omit<Skill, "on" | "conflict">[] {
  return readFileSync(join(repo, "manifest.tsv"), "utf8")
    .split("\n")
    .filter((line) => line.trim() && !line.startsWith("#"))
    .map((line) => {
      const [name, group, presets, blurb] = line.split("\t");
      return {
        name,
        group,
        presets: presets.split(",").map((p) => p.trim()),
        blurb: blurb ?? "",
      };
    });
}

function isOurs(name: string): boolean {
  const link = join(target, name);
  try {
    if (!lstatSync(link).isSymbolicLink()) return false;
    return readlinkSync(link) === join(src, name);
  } catch {
    return false;
  }
}

function isConflict(name: string): boolean {
  const link = join(target, name);
  try {
    const st = lstatSync(link);
    if (!st.isSymbolicLink()) return true;
    return readlinkSync(link) !== join(src, name);
  } catch {
    return false;
  }
}

const skills: Skill[] = readManifest()
  .filter((s) => {
    try {
      return readdirSync(src).includes(basename(s.name));
    } catch {
      return false;
    }
  })
  .map((s) => ({ ...s, on: isOurs(s.name), conflict: isConflict(s.name) }));

if (skills.length === 0) {
  console.error(`no skills found in ${src}`);
  process.exit(1);
}

// The other writing skills read the word list inside google-style.
const ROOT = "google-style";
const dependsOnRoot = (name: string) => name.startsWith("google-style-");

const rootIsForced = () => skills.some((s) => s.on && dependsOnRoot(s.name));

function enforceDependency() {
  const root = skills.find((s) => s.name === ROOT);
  if (root && rootIsForced()) root.on = true;
}

// --- rendering -------------------------------------------------------------

const color = process.env.NO_COLOR === undefined && process.stdout.isTTY;
const c = (code: string, text: string) => (color ? `\x1b[${code}m${text}\x1b[0m` : text);
const dim = (t: string) => c("2", t);
const bold = (t: string) => c("1", t);
const green = (t: string) => c("32", t);
const yellow = (t: string) => c("33", t);

const out = (s: string) => process.stdout.write(s);
const ALT_ON = "\x1b[?1049h\x1b[?25l";
const ALT_OFF = "\x1b[?25h\x1b[?1049l";

let cursor = 0;
const nameWidth = Math.max(...skills.map((s) => s.name.length));

function render() {
  const cols = process.stdout.columns || 80;
  const lines: string[] = [];

  lines.push("");
  lines.push("  " + bold("Google style skills"));
  lines.push(
    "  " + dim("Each enabled skill costs a little context in every session."),
  );
  lines.push("");

  let group = "";
  skills.forEach((s, i) => {
    if (s.group !== group) {
      group = s.group;
      lines.push("  " + dim(group.toUpperCase()));
    }
    const here = i === cursor;
    const box = s.conflict ? yellow("[!]") : s.on ? green("[x]") : "[ ]";
    const pointer = here ? bold("›") : " ";
    const name = here ? bold(s.name.padEnd(nameWidth)) : s.name.padEnd(nameWidth);
    const room = cols - (nameWidth + 10);
    const text =
      s.name === ROOT && rootIsForced() ? "required by the other writing skills" : s.blurb;
    const blurb = room < 8 ? "" : text.length > room ? text.slice(0, room - 1) + "…" : text;
    lines.push(`  ${pointer} ${box} ${name}${blurb ? "  " + dim(blurb) : ""}`);
  });

  const count = skills.filter((s) => s.on).length;
  lines.push("");
  lines.push(`  ${count} of ${skills.length} enabled`);
  lines.push("");
  lines.push(
    "  " +
      dim("↑↓ move   space toggle   enter apply   q cancel"),
  );
  lines.push(
    "  " + dim("presets: c core   d docs   r review   a all   n none"),
  );
  if (skills.some((s) => s.conflict)) {
    lines.push("");
    lines.push("  " + yellow("[!] something else already owns that name; it won't be touched"));
  }

  out("\x1b[H\x1b[2J" + lines.join("\n") + "\n");
}

// --- input -----------------------------------------------------------------

function applyPreset(preset: string) {
  for (const s of skills) {
    s.on = preset === "all" ? true : preset === "none" ? false : s.presets.includes(preset);
  }
  enforceDependency();
}

function finish(apply: boolean) {
  out(ALT_OFF);
  process.stdin.setRawMode?.(false);
  process.stdin.pause();

  if (!apply) {
    console.log("Unchanged.");
    process.exit(0);
  }

  enforceDependency();
  const chosen = skills.filter((s) => s.on).map((s) => s.name);
  const result = spawnSync(
    join(repo, "install.sh"),
    ["--target", target, "set", ...chosen],
    { stdio: "inherit" },
  );
  process.exit(result.status ?? 0);
}

if (!process.stdin.isTTY) {
  console.error("pick.ts needs a terminal");
  process.exit(2);
}

out(ALT_ON);
render();

// A terminal can deliver several keystrokes in one chunk — a fast typist, a
// paste, or a pty test — so split the buffer into keys instead of comparing
// the whole thing.
function splitKeys(input: string): string[] {
  const keys: string[] = [];
  for (let i = 0; i < input.length; i++) {
    if (input[i] === "\x1b" && input[i + 1] === "[" && input[i + 2]) {
      keys.push(input.slice(i, i + 3));
      i += 2;
    } else {
      keys.push(input[i]);
    }
  }
  return keys;
}

process.stdin.setRawMode(true);
process.stdin.resume();
process.stdin.on("data", (buf: Buffer) => {
  let dirty = false;
  for (const key of splitKeys(buf.toString())) {
    const action = handleKey(key);
    if (action === "quit") return;
    if (action === "render") dirty = true;
  }
  if (dirty) render();
});

function handleKey(key: string): "render" | "quit" | "ignore" {
  switch (key) {
    case "\x1b[A":
    case "k":
      cursor = (cursor - 1 + skills.length) % skills.length;
      break;
    case "\x1b[B":
    case "j":
      cursor = (cursor + 1) % skills.length;
      break;
    case " ":
      skills[cursor].on = !skills[cursor].on;
      enforceDependency();
      break;
    case "c":
      applyPreset("core");
      break;
    case "d":
      applyPreset("docs");
      break;
    case "r":
      applyPreset("review");
      break;
    case "a":
      applyPreset("all");
      break;
    case "n":
      applyPreset("none");
      break;
    case "\r":
    case "\n":
      finish(true);
      return "quit";
    case "q":
    case "\x1b":
    case "\x03":
      finish(false);
      return "quit";
    default:
      return "ignore";
  }
  return "render";
}
