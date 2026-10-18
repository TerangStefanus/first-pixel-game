# First Pixel Game / Wildroot

A small Godot 4 pixel-art game project. The current project targets Godot 4.6 and includes the original movement prototype plus a separate Wanderer character preview.

## Run the project

1. Import `project.godot` in Godot 4.6.
2. Press **F5** to run the existing main scene.
3. To explore the character testing map, open `scenes/previews/wanderer_run_preview.tscn` and press **F6**.

In the Wanderer preview, use **WASD / arrow keys** to walk and hold **Shift** to run. Walking uses 64 px/s; running uses 104 px/s. Releasing movement keeps the last facing direction. Press **R** to return to the central clearing, **Z** to switch between 1× and 2× zoom, and **H** to hide/show the HUD.

The testing scene uses a new Wildroot woodland set: 32px ground tiles, larger native tree sprites, quieter ground colors and props matched to the character. A 1× camera shows more world than the earlier 3× view. The live HUD displays movement state/speed and a minimap. [Gameplay view](docs/previews/wildroot-play.png) · [Map overview](docs/previews/wanderer-map.png).

## World bible, novel and discussion references

The user-provided [Wildroot reference index](docs/references/wildroot/README.md) includes Bible v2, the complete A/B/C novel collection, the earlier world bible and Jalur A novel, character/world concept images, and gameplay review screenshots. It also records the current feedback: the vertical run artwork remains rejected and needs further visual work on Windows, despite passing technical checks.

## Wanderer assets

- Transparent 64×64 frames with six opaque colors.
- Four standing bases and four-direction walk/run animations.
- Eight-frame side walks at 100 ms per frame; four-frame front/back walks at 125 ms per frame.
- Six-frame runs: front/back at 90 ms per pose; side runs retain 80/55/125 ms repeated.
- Editable Aseprite sources, exported PNG strips, JSON metadata and GIF previews.
- A reusable `scenes/wanderer_64.tscn` and shared `resources/sprite_frames/wanderer_64.tres`.

See the [asset guide](assets/sprites/wanderer_64/README.md) for the palette, source files, rebuild commands and animation layout. The character artwork was created at the owner's request with image generation and native Aseprite edits; generation prompts and review notes are retained alongside the sources.

The current environment assets are in [Wildroot woodland](assets/tilesets/wildroot/README.md). The six-color character remains the palette/style reference; its front/back runs adapt observed poses from the free CC0 MetroCity pack, keeping Wanderer’s own head, torso and backpack. [Reference, license and derivation](assets/sprites/wanderer_64/reference/metrocity/SOURCE.md). See [the art guide and research](docs/ART_GUIDE.md).

The earlier Ninja Adventure sample by Pixel-Boy and AAA is retained separately under CC0 with [provenance](assets/tilesets/ninja_adventure/SOURCE.md). It is no longer used by the woodland testing scene.

## Verify

Run from the repository root with the Godot executable on your PATH (or replace `godot` with its full path):

```sh
godot --headless --editor --path . --import
godot --headless --path . --script res://tools/validate_wanderer_64.gd
godot --headless --path . --script res://tools/validate_wanderer_run.gd
godot --headless --path . --script res://tools/validate_wanderer_map.gd
```

The checks cover animation frame sizes/counts, side-walk mirroring and proportions, movement/facing transitions, run timing, map traversal, collisions, reset, zoom controls, integer scaling and the live HUD. Visual previews remain the reference for judging the artwork in motion.

## Project layout

| Path | Purpose |
| --- | --- |
| `scenes/main.tscn`, `scripts/player.gd` | Existing playable prototype |
| `scenes/previews/` | Separate character and tileset previews |
| `assets/sprites/wanderer_64/` | Bases, walk/run exports, editable sources and previews |
| `assets/tilesets/wildroot/` | Current woodland props, 32px ground and editable sources |
| `assets/tilesets/ninja_adventure/` | Earlier CC0 sample and attribution |
| `resources/` | Godot SpriteFrames and TileSet resources |
| `tools/validate_wanderer_*.gd` | Focused headless validation |

See [CHANGELOG.md](CHANGELOG.md) for game updates. [AGENTS.md](AGENTS.md) and [the learning roadmap](docs/ROADMAP.md) describe the approved daily workflow; [WILDROOT_CODEX_BOOTSTRAP.md](WILDROOT_CODEX_BOOTSTRAP.md) retains the original setup reference.

Commit messages use Conventional Commits: `type(scope): concise description`, with a body describing the change and relevant validation when useful.

## A normal learning session

Start with **observable result, learning concept, and the part I will implement myself**. Pair is the default. Use Learning for hints, Explain for tracing without edits, Review for your attempt, and Agent for an explicitly delegated task.

| Time | Suggested split |
| --- | --- |
| 30 minutes | 3 goal/status, 5 inspect/predict, 15 implement, 5 run, 2 next step |
| 60 minutes | 5 goal/ownership, 10 concept, 25 implement, 12 play/fix, 8 diff/checkpoint |
| 120 minutes | 10 goal, 15 concept, 35 implement, 10 play/break, 25 revise/art, 15 verify, 10 checkpoint |

Use one prediction or explanation when useful, not an exam every commit. Ask for a concrete hint when stuck. Drawing sessions should stay mostly drawing.

For the next session, use the current handoff in [ROADMAP.md](docs/ROADMAP.md). Trace the relevant input through the actual controller before one small owner-authored code or scene change. An Inspector speed change is a warm-up. Setup has not implemented your learning task for you.

For a bug: reproduction steps, expected result, actual result, relevant error/scene. For playtesting: one question, observations separate from hypotheses, and one next experiment. Passing headless checks does not prove gameplay feels good.

Update useful notes before a checkpoint commit. Record consequential choices in [DECISIONS.md](docs/DECISIONS.md). Create learning/playtest/art docs only when real content exists. End with what changed, what was verified, and one next action in the [roadmap](docs/ROADMAP.md).

## Move between Windows and macOS

1. Keep separate clones outside cloud-sync folders. Work on one device at a time on the same active branch.
2. Before leaving: save Godot/Aseprite, review changed and untracked files, update the next step, and commit a clear checkpoint. Unfinished work may stay on its feature branch.
3. Push when authorized; set the upstream on first publication. Local files/commits reach the other machine only after a push.
4. On arrival: save/close editors, ensure a clean worktree, fetch, and switch to the same branch (create a tracking branch on first checkout). For an existing tracking branch use `git pull --ff-only`. If it refuses, inspect divergence instead of forcing it.
5. Open the agreed Godot version, allow imports, inspect the diff, and verify/play. Track `.uid` and asset `.import` metadata; exclude `.godot/` caches.

Do not edit one Aseprite source on both machines before syncing. Preserve both versions of conflicting binary assets before choosing the result. GitHub carries source, exports, docs, and shared settings. Authentication, local paths, plugins, and caches stay per machine. Existing `.gitattributes` handles LF text endings.

## Design and optional reviews

The latest Bible v2 and A/B/C narrative prototypes are indexed in [Wildroot references](docs/references/wildroot/README.md). The [earlier game design](docs/WILDROOT_GAME_DESIGN.md), [design review](docs/DESIGN_REVIEW.md), and [decisions](docs/DECISIONS.md) preserve their history and the current integration review. The roadmap retains planning hypotheses; it is not evidence that the new Mac changes have been playtested on Windows.

Command Code / MiniMax M3 remains optional. Use it for a concrete design or engineering uncertainty; see [critic setup and limits](tools/command-code/README.md). Authentication and quotas remain per account and device.
