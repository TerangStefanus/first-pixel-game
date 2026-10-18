# Project Context

Working name: **Wildroot / first-pixel-game**. Godot project name: `mini_pixel_game`.
Repository: https://github.com/TerangStefanus/first-pixel-game

The owner learns Godot/GDScript and draws the pixel art. See `../AGENTS.md` for the agreement and `ROADMAP.md` for the next step.

## Game direction

Latest supplied sources (2026-10-18): [Bible v2](references/wildroot/documents/Wildroot_Bible_v2.docx) and the [A/B/C novel collection](references/wildroot/documents/Wildroot_Kumpulan_Novel_Jalur_A_B_C_v1.docx). The integrated draft reports the owner's genre choice B: action-adventure and farming contribute meaningfully to progression. This does not select ending B. Persistent ecological consequences, recovery, non-spoiler information and narrative closure are design principles; the full cast, Sela/Orin backstory, calendar, balancing and three endings remain draft content or open questions.

The shared narrative thread is building a home while investigating Sela and the costs of old resource-distribution infrastructure. A emphasizes adaptive local stewardship, B bounded operation with oversight, C prepared withdrawal from central dependence. None is a morality score or three mandatory campaigns. The older Route A leaves Sela unresolved; B/C find her alive and accountable. See [DESIGN_REVIEW.md](DESIGN_REVIEW.md#pembaruan-18-oktober-2026) for other continuity/production issues and [ROADMAP.md](ROADMAP.md) for the proposed next small task.

The original GDD, independent review and earlier learning decisions are preserved. They describe design proposals and historical verification, not completed ecological gameplay or owner mastery. Codex remains a tutor/pair/reviewer; this document-and-merge session does not authorize implementing the proposed gameplay systems or resuming automatic character-art work.

## Current structure

| Path | Role |
| --- | --- |
| `project.godot` | Main scene UID, InputMap, viewport, renderer, and texture filter |
| `scenes/main.tscn` | Node2D with a ColorRect background and Player instance; no world collision obstacles |
| `scenes/player.tscn` | CharacterBody2D, collision shape, following Camera2D, AnimatedSprite2D, and hidden Sprite2D |
| `scripts/player.gd` | Original main-scene controller; all directions use down-facing idle/walk |
| `scenes/wanderer_64.tscn`, `scripts/wanderer_64.gd` | Separate four-direction controller, standing/walking/running and retained facing |
| `scenes/previews/wanderer_run_preview.tscn` | Woodland testing map with collisions, camera controls, depth occlusion and live movement HUD |
| `scripts/wanderer_map_preview.gd`, `scripts/wildroot_test_hud.gd` | Preview controls and debug/status UI; not quest/inventory/combat systems |
| `assets/sprites/wanderer_64/`, `assets/tilesets/wildroot/` | 64×64 six-color character and woodland environment sources/exports |
| `tools/validate_wanderer_*.gd` | Focused walk/run/map validation; passing does not establish visual quality |
| `assets/sprites/` | Original Aseprite sources, PNG exports, player frames, and import metadata |
| `tools/verify-godot.ps1` | Lightweight import, script parsing, and startup checks |
| `tools/command-code.ps1`, `tools/command-code.sh`, `tools/command-code.mjs` | Windows PowerShell and native Mac onboarding/discussion, auth/model checks and bounded reviews |
| `tools/command-code/prompts/` | Neutral, independent critic instructions |

## Execution map

`project.godot` selects `main.tscn`, which instances `player.tscn` and attaches `player.gd`.
`_ready()` starts `idle_down`. Each `_physics_process()` reads movement actions with `Input.get_vector()`, assigns `velocity = direction * speed`, and calls `move_and_slide()`. Zero input selects `idle_down`; nonzero input selects `walk_down`.

WASD and arrows are mapped. In this original main scene, all movement directions use downward-facing animation. The following camera and uniform background may make movement hard to judge visually; confirm by playing or watching Player position in the Remote Inspector.

The newer woodland/character is a separate **F6 preview**, not the configured **F5 main game**. Its controller preserves facing and uses Shift to run; the preview supports R reset, Z zoom and H HUD toggle. Its collision/map/HUD are implemented. Crop plots, animal care, attack/dodge/damage, interactable pickups, quest progression, journal evidence, daily ecology and save/load are not implemented in the inspected gameplay sources.

Exact speed, zoom, frame timing, and viewport values live in source/Inspector rather than being duplicated here.

## Art and constraints

- Original player sources/frames have a 32 by 32 canvas. Both player Aseprite sources have six frames; preserve the backup source.
- The wyvern source/PNG have a 128 by 128 canvas and are not referenced by current scenes or scripts.
- The original player's animation names remain `idle_down` and `walk_down`. Wanderer has `idle_`, `walk_` and `run_` for four directions; its approved base canvas is 64×64 with six opaque colors. Woodland ground tiles are 32×32. Bible v2's older 48–56px sprite-height suggestion is not a request to resize these assets.
- The owner accepted the newer woodland/UI, but rejected vertical run artwork at `30c5b39`, specifically apparent separation of hands/body and earlier clipping. Preserve this feedback; do not call the character production-ready because technical tests pass. Further art work was stopped on Mac and deferred to Windows.
- Preserve resource paths and original artwork. Inspect visual results in Godot after exporting.

## Verification and tools

- Baseline gameplay: commit `edce1b2`. The project declares Godot 4.6 / GL Compatibility; the verified Windows executable is 4.6.3 stable. Use the same patch for the first Mac handoff.
- Windows automated baseline, 2026-09-30: Godot 4.6.3 passed resource import, `player.gd` parsing, and configured-project startup for 120 engine iterations, with no reported errors. This does not simulate input or prove visual/gameplay correctness.
- The first sandboxed import reported Windows profile/cache access errors despite exit code 0; the helper correctly failed it. The normal-context rerun passed. Import generated `red_wyvern_128.png.import` metadata for the existing PNG; gameplay source and artwork were unchanged.
- Human input report, 2026-09-30: the owner says basic WASD movement has been tried and works. This does not establish diagonal/collision behavior, animation quality, game feel, or understanding of the code.
- Mac Godot/Aseprite use, asset import and focused walk/run/map checks were exercised during 17–18 October asset work. GitHub carries those files and the references. This does not prove the latest art is accepted or the merged build has been played on Windows.
- Phase 0 verified Git, Codex, native ECC 2.2.2, Godot 4.6.3, and Aseprite 1.3.18.6 on Windows. Executable paths stay machine-local.
- Windows critic tooling: standalone Node 24.21.0 (official archive SHA256 verified), npm 11.19.0, and Command Code 1.72.4 installed outside the repository. Local paths are ignored; system PATH was not changed.
- Command Code onboarding verified on 2026-09-30: authenticated status, MiniMax M3 listed, and a completed independent review of the player script/scene and InputMap. The sandboxed request could not connect to the API; the authorized normal-context retry succeeded. The review found no supported movement bug; optional cleanup suggestions were not applied. This was source review, not a playtest.
- A live permission diagnostic recorded `tool_denied` for both `write_file` and a shell redirection targeting disposable ignored fixtures. Both files retained their original contents, and Git stayed clean. This verifies those two attempts with the current configuration, not every possible tool path.
- Wrapper checks passed for prompt/flag handling, missing authentication/model, upstream failure, and timeout using a simulated CLI; live access and the bounded permission diagnostic were checked separately.
- Focused Godot validation scripts exist; no general test framework, addons, CI, or export presets are present in the inspected tree. The intended ecological loop is now documented; its rules, pacing, scope, and player experience remain to be tested.

## Mac critic verification 2026-10-18

Reused Node 24.12.0/npm 11.6.2 and installed Command Code 1.84.0. Browser login completed, status authenticated, and the catalog included MiniMax M3. The native wrapper completed a real bounded M3 source-reading request for `scripts/player.gd`; this is not a gameplay test or endorsement of every reviewer claim. A live permission diagnostic denied direct writing and shell redirection to two disposable ignored fixtures, both unchanged afterward. Nine mocked native-wrapper tests passed, including nonzero failure propagation, timeout and interrupt cleanup.

Use `./tools/command-code.sh interactive` to discuss in plan mode, or `review --kind code|design` with a focused question. Any project trust prompt remains a human step. Account credentials and Node/CLI/Godot/Aseprite paths remain machine-local; the Windows wrapper and shared permission settings are preserved. No gameplay/art or active learning-task status changed during this setup. See `tools/command-code/README.md` for limits and commands.
