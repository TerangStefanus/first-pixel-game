# First Pixel Game / Wildroot

A small Godot 4 pixel-art prototype built while the owner learns GDScript and draws in Aseprite. Current source implements movement, a following camera, and `idle_down` / `walk_down` animation. See [project context](docs/PROJECT_CONTEXT.md) for verification limits.

## Open and play

Use **Godot 4.6.3 standard** for the first Windows/macOS handoff. Import `project.godot` in the project manager. Press **F5** for the configured project or **F6** for the open scene. Move with WASD or arrows.

Godot and Aseprite stay installed per machine. This GDScript game does not need Node/npm to run. Optional critic setup must not hold up learning.

## Verify on Windows

In PowerShell 7, from the repository root:

```powershell
./tools/verify-godot.ps1 -GodotPath 'C:/your/path/to/Godot_console.exe'
```

Alternatively, set `GODOT_BIN` for the terminal or put a `GodotPath` value in ignored `tools/local/paths.json`. With either configured:

```powershell
./tools/verify-godot.ps1
```

The helper imports resources, parses scripts under `scripts/`, and starts the configured scene for 120 engine iterations. Each process has a timeout. Logs go to ignored `tools/local/verification/`; failures return a nonzero exit code. It does not simulate input or assess visuals, collisions, or fun. Import may update caches or create asset metadata: inspect `git status` afterward.

For macOS, these equivalent commands are provided but **not yet tested on the owner's Mac**. From the repository root, set the actual executable path:

```sh
GODOT_BIN='/Applications/Godot.app/Contents/MacOS/Godot'
"$GODOT_BIN" --headless --path "$PWD" --import
"$GODOT_BIN" --headless --path "$PWD" --check-only --script res://scripts/player.gd
"$GODOT_BIN" --headless --path "$PWD" --quit-after 120
```

Run each only if the preceding check succeeded without errors. These manual commands do not have the Windows helper's timeout/log checks. Manually playtest on each platform.

## A normal learning session

Start with **observable result, learning concept, and the part I will implement myself**. Pair is the default. Use Learning for hints, Explain for tracing without edits, Review for your attempt, and Agent for an explicitly delegated task.

| Time | Suggested split |
| --- | --- |
| 30 minutes | 3 goal/status, 5 inspect/predict, 15 implement, 5 run, 2 next step |
| 60 minutes | 5 goal/ownership, 10 concept, 25 implement, 12 play/fix, 8 diff/checkpoint |
| 120 minutes | 10 goal, 15 concept, 35 implement, 10 play/break, 25 revise/art, 15 verify, 10 checkpoint |

Use one prediction or explanation when useful, not an exam every commit. Ask for a concrete hint when stuck. Drawing sessions should stay mostly drawing.

First session: play the baseline, trace W through input, movement, and animation, then choose one small code or scene change to implement yourself. An Inspector speed change is a warm-up. Setup has not implemented your learning task for you.

For a bug: reproduction steps, expected result, actual result, relevant error/scene. For playtesting: one question, observations separate from hypotheses, and one next experiment. Passing headless checks does not prove gameplay feels good.

Update useful notes before a checkpoint commit. Record consequential choices in [DECISIONS.md](docs/DECISIONS.md). Create learning/playtest/art docs only when real content exists. End with what changed, what was verified, and one next action in the [roadmap](docs/ROADMAP.md).

## Move between Windows and macOS

1. Keep separate clones outside cloud-sync folders. Work on one device at a time on the same active branch.
2. Before leaving: save Godot/Aseprite, review changed and untracked files, update the next step, and commit a clear checkpoint. Unfinished work may stay on its feature branch.
3. Push when authorized; set the upstream on first publication. Local files/commits reach the other machine only after a push.
4. On arrival: save/close editors, ensure a clean worktree, fetch, and switch to the same branch (create a tracking branch on first checkout). For an existing tracking branch use `git pull --ff-only`. If it refuses, inspect divergence instead of forcing it.
5. Open the agreed Godot version, allow imports, inspect the diff, and verify/play. Track `.uid` and asset `.import` metadata; exclude `.godot/` caches.

Do not edit one Aseprite source on both machines before syncing. Preserve both versions of conflicting binary assets before choosing the result. GitHub carries source, exports, docs, and shared settings. Authentication, local paths, plugins, and caches stay per machine. Existing `.gitattributes` handles LF text endings.

## Art and optional reviews

Draw in Aseprite, save original source, export, then inspect in Godot at game scale. Agree names/tags before export automation. AI may critique readability or explain tools; the owner creates final art.

Call MiniMax for consequential uncertainty, risky changes, or unresolved diagnosis. Use a fresh session with a neutral problem, goals, constraints, and exact files/diff. Compare initial findings before sharing Codex's verdict. Keep useful decisions rather than a mandatory transcript archive.

Existing prompts/settings are preparation only. Installation, human authentication, model access, and permissions must be verified before use. Prefer a stable user-managed Node/npm installation if needed, not permanent dependencies on Codex runtime caches. Reuse ECC selectively.

The [original bootstrap](WILDROOT_CODEX_BOOTSTRAP.md) remains a setup reference. [AGENTS.md](AGENTS.md), this README, and the current roadmap describe the approved daily workflow.
