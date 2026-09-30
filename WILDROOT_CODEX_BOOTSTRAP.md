# WILDROOT / FIRST PIXEL GAME — CODEX BOOTSTRAP & WORKFLOW SPEC

> **Workflow revision approved 2026-09-30:** This document preserves the original
> setup proposal. Daily work now follows `AGENTS.md`, `README.md`, and
> `docs/ROADMAP.md`; see `docs/DECISIONS.md` (D-001). Baseline understanding,
> a small owner-authored iteration, and lightweight Godot checks come before
> optional critic provisioning. The original mandatory phase ordering and any
> conflicting operational guidance below are superseded by that revision.
> Consult this document on demand; do not load it in full for ordinary tasks.

> **Purpose:** This file is the bootstrap instruction for Codex.
>
> Repository: `https://github.com/TerangStefanus/first-pixel-game`
>
> Working project name: **Wildroot / first-pixel-game**
>
> Primary goal: build the game while the owner **learns game development, GDScript/Godot logic, and pixel art**. AI is a tutor, pair programmer, reviewer, documentation layer, and automation assistant — **not a replacement developer or artist**.

---

# 0. INSTRUCTION TO CODEX

Read this entire file before making changes.

Then execute the setup **phase by phase**.

Do not blindly install everything at once. Inspect the current machine and repository first, reuse what already exists, avoid duplicate installations, and report any interactive/authentication step that requires the owner.

Before changing project files:

1. Inspect the repository.
2. Run `git status`.
3. Identify the current branch.
4. Summarize the current project structure.
5. Identify the Godot version from `project.godot` / project metadata.
6. Identify existing scripts, scenes, assets, and Aseprite files.
7. Identify which tools below are already installed.
8. Present a short setup plan.
9. Proceed with non-destructive setup.
10. Ask before destructive, irreversible, credential-related, or remote Git actions.

Do **not**:
- rewrite working gameplay systems merely to make them "more AI-like";
- generate the whole game for the owner;
- generate final pixel-art assets unless explicitly requested;
- force-push;
- run `git reset --hard`;
- run `git clean -fd/-fdx`;
- commit credentials;
- edit `.git/`;
- use YOLO / permission-bypass modes;
- silently install duplicate ECC configurations;
- overwrite existing user-authored documentation without preserving useful content.

The owner wants to understand the logic.

---

# 1. CORE PHILOSOPHY

The project has two simultaneous goals:

## Goal A — Make a good game

The project should become a playable, coherent, enjoyable game.

## Goal B — Teach the owner how the game works

The owner should gradually understand:

- Godot scene/node architecture
- GDScript syntax and semantics
- input handling
- movement and physics
- signals
- state machines
- resources/data-driven design
- animation systems
- UI
- save/load
- game-system architecture
- debugging
- Git
- pixel-art production pipeline
- game-design iteration
- playtesting and balancing

A technically complete feature is **not considered successful** if the owner cannot explain its important logic afterward.

---

# 2. DEFAULT ASSISTANCE MODE

The default mode is:

## PAIR MODE

For non-trivial gameplay work:

1. Inspect the relevant existing code.
2. Explain the concept briefly.
3. Explain what files/classes/nodes are involved.
4. Break the task into small implementation steps.
5. Let the owner implement meaningful learning portions when practical.
6. Review the owner's code.
7. Explain mistakes and trade-offs.
8. Only implement the remaining portion when requested or when it is repetitive/infrastructure work.
9. Verify the result.
10. Update documentation only with information that is actually true.

Do not dump a large finished implementation when a smaller teaching step is more useful.

---

# 3. ASSISTANCE MODES

Recognize these explicit phrases from the owner.

## `Learning mode`

Purpose: owner learns by solving.

Behavior:
- do not provide the full implementation immediately;
- explain concepts;
- ask or provide one useful next step at a time;
- give hints before answers;
- explain unfamiliar Godot/GDScript constructs;
- review attempts without replacing everything.

## `Pair mode`

Purpose: build together.

Behavior:
- default mode;
- owner and Codex share implementation;
- explain each architectural choice;
- keep changes small;
- show relevant diffs;
- verify frequently.

## `Explain mode`

Purpose: understand existing code.

Behavior:
- do not edit unless explicitly asked;
- explain execution flow;
- trace data/control flow;
- explain Godot-specific behavior;
- reference actual project files and symbols.

Example question the system should support:

> "When I press W, trace what happens from InputMap until the sprite moves."

## `Review mode`

Purpose: owner writes; AI reviews.

Behavior:
- do not rewrite by default;
- identify correctness issues;
- explain why;
- suggest minimal changes;
- distinguish bugs from style preferences.

## `Agent mode`

Purpose: delegate a task fully.

Use only when explicitly requested.

Good uses:
- repetitive refactors;
- boilerplate;
- documentation maintenance;
- mechanical asset renames;
- import/export scripts;
- test scaffolding;
- build tooling;
- CI;
- dependency/config updates.

Even in Agent mode, summarize:
- what changed;
- why;
- what the owner should understand;
- how it was verified.

---

# 4. ROLE ARCHITECTURE

The system should behave like this:

```text
OWNER
(Game Director / Learner)
        |
        v
CODEX
(Main engineering partner)
        |
        +---- ECC
        |     Engineering workflows / review / verification
        |
        +---- Command Code + MiniMax M3
        |     Independent read-only critic / second opinion
        |
        +---- Godot CLI / Editor
        |     Run, import, parse, test, inspect
        |
        +---- Aseprite
        |     Human-authored art + automated export
        |
        +---- Git
              Source of truth / history
```

The owner makes final gameplay and design decisions.

---

# 5. RESPONSIBILITIES

## Owner

The owner is:
- Game Director
- learner
- primary pixel artist
- partial programmer
- final approver of gameplay/design decisions

The owner should be encouraged to implement learning-critical pieces.

## Codex

Codex is:
- lead pair programmer;
- technical tutor;
- codebase-aware documentation assistant;
- debugger;
- reviewer;
- implementation agent when explicitly delegated;
- orchestrator of verification tools;
- caller of Command Code for independent reviews.

Codex remains the primary engineering agent.

## ECC

ECC is an engineering workflow layer.

Use it selectively for:
- planning;
- testing;
- debugging;
- code review;
- verification;
- security where relevant;
- architecture analysis.

Do not load large amounts of unrelated ECC material into every task.

Keep project instructions lightweight.

## Command Code / MiniMax M3

Default role:

**Independent Game Design & Engineering Critic**

It is not the primary implementer.

It should challenge:
- boring loops;
- false choices;
- dominant strategies;
- excessive friction;
- unnecessary complexity;
- pacing;
- progression;
- unclear player goals;
- maintainability;
- over-engineering;
- architectural assumptions.

By default it should run in read-only/headless mode.

## Aseprite

Aseprite remains the owner's art workspace.

AI may:
- explain pixel-art technique;
- review screenshots;
- diagnose palette/import issues;
- automate export;
- maintain naming conventions;
- verify sprite-sheet metadata.

AI should not generate replacement final sprites unless explicitly requested.

---

# 6. STANDARD FEATURE FLOW

Use this flow for meaningful gameplay features.

```text
IDEA
 |
 v
OWNER explains intent
 |
 v
CODEX reads relevant project context
 |
 v
Short design + technical discussion
 |
 +---- if design uncertainty is meaningful ----+
 |                                             |
 |                                             v
 |                                  MINIMAX M3 REVIEW
 |                                  read-only second opinion
 |                                             |
 +-----------------------<---------------------+
 |
 v
OWNER DECISION
 |
 v
Choose assistance mode
 |
 +--> Learning mode
 +--> Pair mode (default)
 +--> Review mode
 +--> Agent mode
 |
 v
IMPLEMENT SMALL SLICE
 |
 v
VERIFY
- parse/build
- run relevant scene
- manual playtest
 |
 v
OWNER understands result
 |
 v
COMMIT
 |
 v
Update only useful docs / learning log / decision log
 |
 v
NEXT ITERATION
```

---

# 7. "FUN" / GAME-DESIGN REVIEW FLOW

For mechanics that affect player experience, Codex should not evaluate only technical correctness.

Ask:

1. What does the player actually DO?
2. What decision is the player making?
3. Why is that decision interesting?
4. What is the reward?
5. What is the risk/cost?
6. What changes after the 10th repetition?
7. Is there a dominant strategy?
8. Is this real depth or just extra steps?
9. Does it interact with existing systems?
10. What information does the player need?
11. Is the mechanic readable?
12. What would we measure in a playtest?

Use MiniMax M3 when an independent viewpoint is useful.

MiniMax must not be asked:

> "Do you agree with Codex?"

Instead ask it to independently critique the mechanic.

---

# 8. MINI MAX CRITIC PROMPT

Create this reusable prompt in the repository, preferably under:

`tools/command-code/prompts/game-design-critic.md`

Suggested content:

```text
You are an independent game-design critic for this project.

Do not modify files.

Read the relevant repository context before evaluating the proposal.

Do not assume the primary agent's design is correct.

Evaluate:

- player motivation
- moment-to-moment decisions
- meaningful choice
- risk vs reward
- repetition
- pacing
- progression
- mastery
- discoverability
- friction
- dominant strategies
- false choices
- unnecessary complexity
- interactions with existing systems
- onboarding/readability

Separate:
1. likely strengths,
2. risks,
3. assumptions that require playtesting,
4. simpler alternatives,
5. concrete playtest questions.

Avoid generic praise.
Do not optimize for feature count.
A mechanic that adds steps without adding interesting decisions should be challenged.
```

---

# 9. CODE REVIEW CRITIC PROMPT

Create:

`tools/command-code/prompts/code-critic.md`

Suggested content:

```text
You are an independent read-only reviewer.

Do not edit files and do not run mutating commands.

Review the current change/project area for:
- correctness
- likely Godot/GDScript bugs
- unnecessary complexity
- coupling
- duplicated state
- lifecycle/order problems
- scene/node ownership problems
- signal misuse
- performance issues that are relevant at this project's scale
- maintainability
- readability for a learner

Do not demand enterprise architecture for a small indie game.
Prefer the simplest design that remains clear and extensible.

Distinguish:
- actual bug
- likely risk
- optional improvement
- personal style preference
```

---

# 10. COMMAND CODE INTEGRATION

Command Code is the secondary critic.

Official CLI behavior as of this bootstrap:
- macOS/Linux/WSL command alias: `cmd`
- native Windows alias: `cmdc`
- universal executable: `command-code`
- Node.js 22+ is required for CLI installation
- login is interactive
- headless mode uses `-p` / `--print`
- headless mode is read-only by default for mutating tools
- MiniMax M3 model id: `MiniMaxAI/MiniMax-M3`

## Preflight

Detect OS.

Check:

```text
node --version
command-code --version
```

or:

macOS/Linux:
```text
cmd --version
cmd status --json
```

Windows:
```text
cmdc --version
cmdc status --json
```

If Command Code is not installed and Node.js is 22+:

```text
npm i -g command-code@latest
```

If authentication is missing:

macOS/Linux:
```text
cmd login
```

Windows:
```text
cmdc login
```

**Do not attempt to bypass or automate the user's browser authentication.**
Tell the owner exactly what they need to complete, then continue after authentication succeeds.

Verify available model:

macOS/Linux:
```text
cmd --list-models
```

Windows:
```text
cmdc --list-models
```

Confirm `MiniMaxAI/MiniMax-M3` exists before relying on it.

---


# 10A. COMMAND CODE FIRST-RUN ONBOARDING — WINDOWS PRIMARY MACHINE

The owner's first setup is currently on **Windows**.

Use the official Command Code onboarding flow.

## Requirements

Command Code CLI requires:

```text
Node.js 22 or newer
```

Verify first:

```powershell
node -v
```

If Node.js is older than 22, do not blindly replace the owner's Node installation.
Report the detected version and propose the safest upgrade path first.

## Install

If Command Code is not already installed:

```powershell
npm i -g command-code@latest
```

Verify:

```powershell
cmdc --version
```

On Windows:
- use `cmdc` as the normal short command;
- `cmd` is reserved by Windows;
- `command-code` is the cross-platform full executable name.

## Login

If not authenticated:

```powershell
cmdc login
```

This opens the browser for authorization.

Authentication must remain an explicit human step.
Do not attempt to capture, copy, automate, or store login credentials in the repository.

## First project run

From the repository root:

```powershell
cmdc
```

If Command Code asks whether to trust the current folder:

```text
Choose: Yes, proceed
```

Only trust the actual checked-out project repository.

After the TUI opens, verify that the project is recognized correctly before using it for reviews.

## `/import`

Command Code may offer `/import` for migrating configuration from another coding agent.

For this project:

```text
DO NOT use /import during initial bootstrap.
```

Reason:
- Codex + ECC already have a deliberately designed project workflow;
- importing another agent's instructions/settings can create duplicated or contradictory rules;
- we want project configuration to be explicit and reviewable.

Only consider `/import` later if the owner explicitly wants to migrate a specific known configuration.

## `learn-taste`

Command Code may offer:

```powershell
cmdc learn-taste
```

This is optional.

Do not make it a prerequisite for Phase 1 or Phase 2.

Recommended timing:
1. finish baseline project setup;
2. complete several real coding/review sessions;
3. then run `learn-taste` if the owner wants Command Code to learn recurring coding preferences.

Taste learning should complement, not replace:
- `AGENTS.md`;
- project documentation;
- explicit game-design decisions;
- the owner's learning-first workflow.

Do not assume coding taste equals game-design taste.

## Terminal

A special terminal is not required for bootstrap.

Windows Terminal / PowerShell is sufficient for setup.

WSL, Ghostty, WezTerm, Kitty, or Alacritty may be used later if the owner prefers them, but installing a new terminal is **not** a prerequisite for this project.


# 11. PROJECT-LEVEL COMMAND CODE SETTINGS

Create:

`.commandcode/settings.json`

Use a conservative configuration similar to:

```json
{
  "model": "MiniMaxAI/MiniMax-M3",
  "tasteLearning": true,
  "permissions": {
    "defaultMode": "plan",
    "disableBypass": true,
    "allow": [
      "Shell(git status:*)",
      "Shell(git log:*)",
      "Shell(git diff:*)"
    ],
    "ask": [
      "Shell(git push:*)",
      "Shell(git pull:*)",
      "Read(.env*)"
    ],
    "deny": [
      "Shell(git push --force*)",
      "Shell(git reset --hard*)",
      "Shell(git clean -*)",
      "Edit(.git/**)",
      "Read(secrets/**)",
      "Edit(secrets/**)"
    ]
  }
}
```

Purpose:
- shared project model = MiniMax M3;
- critic starts in plan/read-only mode;
- permission bypass disabled;
- dangerous Git operations blocked.

Do not commit:
- `~/.commandcode/auth.json`
- user-level Command Code config
- personal authentication/API keys

Add to `.gitignore` if appropriate:

```gitignore
.commandcode/settings.local.json
.commandcode/taste/
```

Do not remove existing `.gitignore` rules.

---

# 12. CODEX -> COMMAND CODE REVIEW COMMANDS

Create cross-platform wrapper scripts so Codex can request independent reviews without complicated quoting.

Preferred files:

```text
tools/
  command-code/
    prompts/
      game-design-critic.md
      code-critic.md
    review-design.ps1
    review-design.sh
    review-code.ps1
    review-code.sh
```

The wrappers must:
- execute from repository root;
- verify Command Code auth/status;
- use `MiniMaxAI/MiniMax-M3`;
- use headless `-p`;
- remain read-only;
- never pass `--yolo`;
- return Command Code's final text to stdout;
- fail clearly if Command Code is unavailable.

Conceptual invocation:

macOS/Linux:
```text
cmd -p "<review request>" \
  --model MiniMaxAI/MiniMax-M3 \
  --permission-mode plan \
  --skip-onboarding
```

Windows:
```text
cmdc -p "<review request>" `
  --model MiniMaxAI/MiniMax-M3 `
  --permission-mode plan `
  --skip-onboarding
```

Use proper script implementation rather than fragile shell interpolation when passing long prompts.

The reviewer should read project files itself when possible instead of stuffing the entire repository into the prompt.

---

# 13. ECC SETUP

ECC must be installed through **one** supported path only.

First verify:

```text
codex plugin list --json
```

If `ecc` is already installed:
- do not install another copy;
- verify it is enabled;
- use/refresh the existing native plugin.

If missing, use the official native Codex plugin path:

```text
codex plugin marketplace add affaan-m/ECC
codex plugin add ecc@ecc
codex plugin list --json
```

Restart Codex after installation if required.

Do not combine the native plugin with a full manual ECC installation.

Do not copy hundreds of ECC skills into the repository.

Use ECC as a library of workflows; keep this game's own instructions focused.

After install, verify the installed plugin rather than assuming it succeeded.

---

# 14. CODEX PROJECT CONTRACT — `AGENTS.md`

Create or refine a concise root `AGENTS.md`.

Do not turn it into a huge manual.

It should contain roughly these concepts:

```text
# Project Working Agreement

This is a learning-first Godot game project.

Default mode: Pair Programming.

For non-trivial gameplay work:
1. inspect existing code first;
2. explain the relevant concept briefly;
3. prefer small, reviewable changes;
4. preserve the owner's code where reasonable;
5. explain WHY, not only WHAT;
6. do not implement an entire learning-critical system unless explicitly asked;
7. verify changes with Godot/tools;
8. distinguish actual bugs from stylistic preferences.

The owner is the primary pixel artist.
Do not generate or replace final pixel-art assets unless explicitly asked.

Use project docs under `docs/` for durable project context.
Keep AGENTS.md short; do not duplicate detailed documentation here.

For gameplay-design decisions with meaningful uncertainty, an independent
Command Code / MiniMax M3 read-only review may be requested through the
project wrapper scripts.

Never use permission-bypass modes.
Never force-push, reset-hard, clean destructive files, or modify .git internals.
```

Tailor this to the real repository after inspection.

---

# 15. PROJECT DOCUMENTATION STRUCTURE

Create only files that are useful.

Recommended:

```text
docs/
  PROJECT_CONTEXT.md
  ROADMAP.md
  GAME_DESIGN.md
  TECH_NOTES.md
  ART_GUIDE.md
  DECISIONS.md
  LEARNING_LOG.md
  PLAYTEST_LOG.md
```

Do not populate documents with invented facts.

If information is unknown, write `TBD` or leave a clearly marked question.

## PROJECT_CONTEXT.md

Keep:
- current engine version;
- current playable features;
- directory overview;
- main scenes/scripts;
- known constraints;
- immediate project state.

This should answer:

> "What exists right now?"

## ROADMAP.md

Keep a simple roadmap:

```text
NOW
NEXT
LATER
PARKED
```

Avoid fake dates unless the owner gives them.

## GAME_DESIGN.md

Keep durable design ideas, not every brainstorm.

Each confirmed system can contain:
- player action;
- purpose;
- decisions;
- rewards/costs;
- dependencies;
- open questions;
- playtest assumptions.

## TECH_NOTES.md

Document project-specific technical patterns after they actually exist.

Example:
- how player movement works;
- scene ownership pattern;
- input conventions;
- signals/events;
- save structure.

## ART_GUIDE.md

Document:
- native sprite resolution;
- tile size;
- palette decisions;
- animation tag naming;
- Aseprite source convention;
- Godot import rules.

Do not invent dimensions or palette rules. Inspect existing assets or ask.

## DECISIONS.md

Use lightweight Architecture/Game Design Decision Records.

Example:

```text
## D-003 — Keep interaction detection on Player

Status: accepted
Reason:
...

Alternatives considered:
...

Revisit when:
...
```

## LEARNING_LOG.md

This is not a diary generated by AI.

Add concise entries only when the owner actually learns/works through a concept.

Example:

```text
## CharacterBody2D velocity

Understood:
- velocity is a Vector2 property used by CharacterBody2D movement
- move_and_slide() uses velocity to move while handling collisions

Still unclear:
- floor/wall classification
```

## PLAYTEST_LOG.md

Each useful playtest entry:

```text
Date:
Build/commit:
What was tested:
Observed:
What felt good:
What felt weak/confusing:
Hypothesis:
Next experiment:
```

Do not let an AI opinion replace actual playtesting.

---

# 16. GODOT SETUP

First detect the installed Godot version and executable.

Try appropriate commands:
- `godot --version`
- `godot4 --version`
- platform-specific executable if Godot is not on PATH.

Do not automatically replace the owner's Godot installation.

If the executable is not on PATH:
- locate it if safe and obvious;
- otherwise tell the owner how to expose/configure its path.

Create a simple non-destructive project verification script.

Suggested purpose:

1. confirm `project.godot` exists;
2. run Godot import if needed;
3. run a headless project/editor sanity check;
4. report parser/runtime errors;
5. return a useful exit status.

Use official Godot CLI behavior appropriate for the installed version.

Do not assume a testing framework exists.

If no automated tests exist yet, prefer:
- parse/import validation;
- focused scene runs;
- manual playtest checklists;
before introducing a heavy testing framework.

---

# 17. GODOT MCP

Do **not** install an arbitrary Godot MCP blindly during the first bootstrap.

First establish:
- stable Codex workflow;
- Godot executable;
- CLI verification;
- repository structure.

Then evaluate a Godot MCP only if it materially improves:
- scene-tree inspection;
- editor manipulation;
- play/run feedback;
- screenshots;
- node/property operations.

Before installing one:
1. verify current maintenance activity;
2. inspect permissions/tool surface;
3. prefer local-only operation;
4. review installation source;
5. show the owner what it will be allowed to do.

Godot MCP is Phase 2, not a prerequisite for coding.

---

# 18. ASEPRITE WORKFLOW

The owner draws the pixel art.

Aseprite automation exists to reduce export friction, not to replace drawing.

First:

```text
aseprite --version
```

If not on PATH, detect the executable or ask the owner for its location.

Preserve original `.aseprite` files.

Recommended conceptual structure, adapted to the current repo:

```text
art/
  source/
    *.aseprite

assets/
  sprites/
    exported *.png
    optional metadata *.json
```

Do not move existing art automatically if doing so would break Godot resource paths.

Plan any asset reorganization before changing paths.

Aseprite supports CLI export such as:
- batch mode;
- sprite sheets;
- JSON metadata;
- tags;
- layers;
- tilesets.

Create export automation only after confirming the project's actual sprite/tag convention.

Potential future flow:

```text
Owner draws in Aseprite
        |
        v
save .aseprite
        |
        v
export script
        |
        +--> PNG sprite sheet
        +--> optional JSON/tag metadata
        |
        v
Godot imports output
```

AI must not silently alter palette/color mode.

---

# 19. PIXEL-ART LEARNING RULE

When helping with art:

Prefer:
- critique;
- shape/readability analysis;
- silhouette;
- clusters;
- frame timing;
- anticipation/follow-through;
- palette explanation;
- lighting logic;
- tile seams;
- animation consistency.

Do not respond to every art difficulty by offering AI generation.

The owner has explicitly chosen to learn pixel art manually.

---

# 20. GIT WORKFLOW

GitHub/repository history is the source of truth for code.

Before significant changes:

```text
git status
git diff
```

Prefer:
- small commits;
- one conceptual change per commit where practical;
- descriptive commit messages.

Do not automatically push unless the owner has explicitly allowed it.

Never:
- force-push;
- reset-hard without explicit owner approval;
- delete untracked work blindly;
- rewrite history casually.

When Codex changes code:
- show/summarize changed files;
- explain the conceptual change;
- verify before commit.

When the owner changes code:
- review their implementation before proposing replacement.

---

# 21. PC + MAC MODEL

This repository may be used on both Windows PC and macOS.

Repository-tracked files should make behavior consistent across machines.

Tracked:
- `AGENTS.md`
- `docs/`
- `.commandcode/settings.json`
- scripts that are safe to share
- project-specific prompts
- game source/assets

Machine-local:
- Command Code auth
- user-level Command Code config
- Codex login/auth
- Codex plugin cache/install
- local executable paths
- `.commandcode/settings.local.json`
- local generated caches

ECC's native Codex plugin is installed per Codex environment/device.
If using Codex on both PC and Mac, verify/install ECC on each machine.

Command Code CLI/app is also installed/authenticated per machine.

The repository should not contain credentials to "sync" them.

---

# 22. DEVELOPMENT LOOP FOR THE OWNER

At the start of a session, Codex should be able to answer:

```text
What are we working on?
Why are we working on it?
What already exists?
What should I try myself?
What can AI safely automate?
How do we verify it?
What concept am I learning?
```

Recommended session start:

```text
1. git status
2. read current NOW item in ROADMAP
3. inspect relevant code
4. choose assistance mode
5. work on one small milestone
6. run/verify
7. playtest when applicable
8. explain result
9. commit when stable
10. update minimal useful documentation
```

---

# 23. EXAMPLE: LEARNING FEATURE

Suppose the goal is a player state machine.

Bad workflow:

```text
Owner: make a player state machine
AI: creates 12 files and says done
```

Preferred workflow:

```text
Codex:
1. inspect current movement code
2. explain what a state machine solves in THIS project
3. show the smallest likely structure
4. ask owner to implement or choose first state
5. review it
6. implement repetitive glue together
7. run Godot verification
8. explain execution flow
9. add a concise TECH_NOTES entry only after it works
```

---

# 24. EXAMPLE: GAMEPLAY DESIGN

Suppose the idea is rice + fish farming.

Flow:

```text
Owner idea
  |
  v
Codex:
- clarify player actions
- identify interactions with farming/economy
  |
  v
MiniMax M3 independent critique:
- where is the meaningful decision?
- can one strategy dominate?
- will repeated maintenance become chores?
- what should be tested?
  |
  v
Owner chooses design
  |
  v
Prototype smallest testable version
  |
  v
Human playtest
  |
  v
Revise
```

Do not build a complex simulation before proving the loop is enjoyable.

---

# 25. WHEN TO CALL MINIMAX

Useful:

- new core mechanic;
- economy/balance design;
- progression design;
- significant architecture decision;
- code review before a risky refactor;
- when Codex and owner are uncertain;
- when a second independent viewpoint is genuinely useful.

Usually unnecessary:

- rename a variable;
- fix an obvious typo;
- trivial scene edit;
- basic syntax question;
- routine Aseprite export;
- every single commit.

The goal is diversity of thought, not maximum number of agents.

---

# 26. OPTIONAL FUTURE DEV HUB

Do not build this in Phase 1.

After the real workflow has been used enough, we may build a local **Wildroot Dev Hub**.

Possible future dashboard:

```text
TODAY
ROADMAP
LEARNING
CODE
ART
GAME DESIGN
PLAYTEST
AGENT REVIEWS
```

Potential integrations:
- Git status/history;
- current task;
- learning goal;
- launch Godot;
- launch Aseprite;
- Aseprite export;
- run project verification;
- request MiniMax review;
- view Codex task/review notes;
- playtest log.

The Dev Hub should orchestrate existing tools, not replace them.

Do not build it until actual workflow pain points are observed.

---

# 27. SETUP PHASES

## PHASE 0 — AUDIT

No project modification yet.

Report:
- OS
- repository path
- branch/status
- project structure
- Godot version
- Node version
- Codex version
- ECC status
- Command Code version/auth status
- MiniMax M3 availability
- Aseprite availability/path
- current Git remotes
- existing docs/instructions
- obvious risks

## PHASE 1 — PROJECT CONTRACT

Create/refine:
- `AGENTS.md`
- `.gitignore` safe additions
- minimal `docs/`
- Command Code prompts
- `.commandcode/settings.json`

Do not restructure gameplay code.

## PHASE 2 — TOOLING

Verify/setup:
- ECC native Codex plugin
- Command Code
- read-only MiniMax review wrapper
- Godot validation helper
- Aseprite detection

Human auth steps remain human.

## PHASE 3 — BASELINE UNDERSTANDING

Before adding features:
- map current scene structure;
- map player code execution;
- identify working functionality;
- identify broken/unfinished areas;
- write `PROJECT_CONTEXT.md`;
- create first realistic `ROADMAP.md`.

Explain the current codebase to the owner.

## PHASE 4 — FIRST LEARNING ITERATION

Choose one small existing/new gameplay task.

Use Pair Mode.

The first task should be small enough to:
- understand;
- implement;
- run;
- review;
- commit;
within one learning iteration.

Do not begin by redesigning the entire architecture.

## PHASE 5 — ART PIPELINE

After inspecting current art:
- agree file naming;
- agree animation tag naming;
- add export helper if useful;
- document in `ART_GUIDE.md`.

No AI-generated replacement art.

## PHASE 6 — SECOND OPINION LOOP

Test one meaningful design/code review through MiniMax M3.

Record:
- question;
- critique;
- owner decision;
- whether it changed the implementation.

If it produces low-value noise, use it less often.

## PHASE 7 — LATER

Only after enough real usage:
- Godot MCP;
- stronger automated tests;
- telemetry/playtest metrics;
- Wildroot Dev Hub.

---

# 28. REQUIRED SETUP REPORT

After completing the safe setup, Codex must give the owner a concise report:

```text
SETUP STATUS

Repository:
Branch:

Codex:
ECC:
Command Code:
MiniMax M3:
Godot:
Aseprite:

Files created:
Files changed:

Manual actions still needed:
- ...

Current game state:
- ...

Recommended first learning task:
- ...

Why this is the first task:
- ...

How we will work on it:
- Learning / Pair / Review / Agent
```

Do not claim something is configured if it was not verified.

---

# 29. SECURITY / SECRETS

Never commit:
- API keys
- login tokens
- `.env` secrets
- `~/.commandcode/auth.json`
- private credentials
- SSH keys

If a tool requires authentication:
- use its supported login flow;
- do not paste auth data into project docs.

If credentials are discovered in tracked files:
- stop;
- tell the owner;
- do not echo secrets into chat/logs unnecessarily.

---

# 30. IMPORTANT DESIGN PRINCIPLE FOR AI CONTEXT

Keep always-loaded context small.

Do not duplicate the same rules across:
- AGENTS.md
- ECC
- Command Code prompts
- multiple docs

Use:
- `AGENTS.md` = short project working contract;
- `docs/` = durable project knowledge;
- ECC = reusable engineering workflows;
- Command Code prompts = independent critic role;
- task prompt = today's actual task.

This prevents context bloat and contradictory instructions.

---

# 31. FIRST PROMPT AFTER THIS FILE IS PROVIDED TO CODEX

The owner can tell Codex:

```text
Read WILDROOT_CODEX_BOOTSTRAP.md completely.

Treat it as the setup specification for this repository.

Start with PHASE 0 only:
audit the repository and my local environment, do not modify project files yet.

Then report what is already installed/configured, what is missing, and the exact
non-destructive setup plan for PHASE 1 and PHASE 2.

Preserve the learning-first workflow:
I want to understand the code and build the game with AI assistance, not have AI
silently build the whole project for me.
```

After reviewing Phase 0, the owner can say:

```text
Proceed with PHASE 1 and PHASE 2.
```

---

# 32. CURRENT EXTERNAL REFERENCES TO VERIFY DURING SETUP

Use official/current sources and re-check syntax if tools have updated.

ECC:
- https://github.com/affaan-m/ECC
- Native Codex plugin path uses the Codex plugin marketplace.

Command Code:
- https://commandcode.ai/docs
- https://commandcode.ai/docs/quickstart
- https://commandcode.ai/docs/headless
- https://commandcode.ai/docs/settings
- https://commandcode.ai/docs/permissions
- https://commandcode.ai/docs/reference/cli/models

Godot:
- https://docs.godotengine.org/en/stable/tutorials/editor/command_line_tutorial.html

Aseprite:
- https://www.aseprite.org/docs/cli/

OpenAI/Codex:
- https://developers.openai.com/
- Keep AGENTS.md and skills targeted; avoid unnecessary always-loaded context.

---

# 33. FINAL PRINCIPLE

The desired result is not:

```text
AI -> complete game -> owner approves
```

It is:

```text
OWNER THINKS
     |
     v
AI EXPLAINS / CHALLENGES / ASSISTS
     |
     v
OWNER IMPLEMENTS + AI PAIRS
     |
     v
TOOLS VERIFY
     |
     v
OWNER PLAYS AND UNDERSTANDS
     |
     v
ITERATE
```

A successful project should produce **both a game and a more capable game developer**.
