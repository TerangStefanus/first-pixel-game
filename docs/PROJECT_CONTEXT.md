# Project Context

Working name: **Wildroot / first-pixel-game**. Godot project name: `mini_pixel_game`.
Repository: https://github.com/TerangStefanus/first-pixel-game

The owner learns Godot/GDScript and draws the pixel art. See `../AGENTS.md` for the agreement and `ROADMAP.md` for the next step.

## Current structure

| Path | Role |
| --- | --- |
| `project.godot` | Main scene UID, InputMap, viewport, renderer, and texture filter |
| `scenes/main.tscn` | Node2D with a ColorRect background and Player instance; no world collision obstacles |
| `scenes/player.tscn` | CharacterBody2D, collision shape, following Camera2D, AnimatedSprite2D, and hidden Sprite2D |
| `scripts/player.gd` | The only gameplay script: input, movement, and idle/walk selection |
| `assets/sprites/` | Original Aseprite sources, PNG exports, player frames, and import metadata |
| `tools/verify-godot.ps1` | Lightweight import, script parsing, and startup checks |
| `tools/command-code.ps1` | Human onboarding, auth/model checks, and bounded code/design reviews |
| `tools/command-code/prompts/` | Neutral, independent critic instructions |

## Execution map

`project.godot` selects `main.tscn`, which instances `player.tscn` and attaches `player.gd`.
`_ready()` starts `idle_down`. Each `_physics_process()` reads movement actions with `Input.get_vector()`, assigns `velocity = direction * speed`, and calls `move_and_slide()`. Zero input selects `idle_down`; nonzero input selects `walk_down`.

WASD and arrows are mapped. All movement directions currently use downward-facing animation. The following camera and uniform background may make movement hard to judge visually; confirm by playing or watching Player position in the Remote Inspector.

Exact speed, zoom, frame timing, and viewport values live in source/Inspector rather than being duplicated here.

## Art and constraints

- Player sources/frames have a 32 by 32 canvas. Both player Aseprite sources have six frames; preserve the backup source.
- The wyvern source/PNG have a 128 by 128 canvas and are not referenced by current scenes or scripts.
- Godot animation names are `idle_down` and `walk_down`. Aseprite tags/export conventions, tile size, and palette rules remain unconfirmed.
- Preserve resource paths and original artwork. Inspect visual results in Godot after exporting.

## Verification and tools

- Baseline gameplay: commit `edce1b2`. The project declares Godot 4.6 / GL Compatibility; the verified Windows executable is 4.6.3 stable. Use the same patch for the first Mac handoff.
- Windows automated baseline, 2026-09-30: Godot 4.6.3 passed resource import, `player.gd` parsing, and configured-project startup for 120 engine iterations, with no reported errors. This does not simulate input or prove visual/gameplay correctness.
- The first sandboxed import reported Windows profile/cache access errors despite exit code 0; the helper correctly failed it. The normal-context rerun passed. Import generated `red_wyvern_128.png.import` metadata for the existing PNG; gameplay source and artwork were unchanged.
- Human input report, 2026-09-30: the owner says basic WASD movement has been tried and works. This does not establish diagonal/collision behavior, animation quality, game feel, or understanding of the code.
- macOS install, runtime checks, and cross-device handoff: not yet verified.
- Phase 0 verified Git, Codex, native ECC 2.2.2, Godot 4.6.3, and Aseprite 1.3.18.6 on Windows. Executable paths stay machine-local.
- Windows critic tooling: standalone Node 24.21.0 (official archive SHA256 verified), npm 11.19.0, and Command Code 1.72.4 installed outside the repository. Local paths are ignored; system PATH was not changed.
- Command Code onboarding verified on 2026-09-30: authenticated status, MiniMax M3 listed, and a completed independent review of the player script/scene and InputMap. The sandboxed request could not connect to the API; the authorized normal-context retry succeeded. The review found no supported movement bug; optional cleanup suggestions were not applied. This was source review, not a playtest.
- A live permission diagnostic recorded `tool_denied` for both `write_file` and a shell redirection targeting disposable ignored fixtures. Both files retained their original contents, and Git stayed clean. This verifies those two attempts with the current configuration, not every possible tool path.
- Wrapper checks passed for prompt/flag handling, missing authentication/model, upstream failure, and timeout using a simulated CLI; live access and the bounded permission diagnostic were checked separately.
- No test framework, addons, CI, or export presets exist. The broader game loop is undecided.
