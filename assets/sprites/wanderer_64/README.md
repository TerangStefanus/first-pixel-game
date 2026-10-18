# Wanderer 64

**Editing handoff:** use the [source/reference guide](../../../docs/ASEPRITE_HANDOFF.md) to select layered files and export the PNGs Godot actually reads. The latest front/back run artwork remains rejected by the owner because arms/body appear detached. It is preserved for manual repair on Windows; technical checks below do not establish visual approval. Old build scripts can overwrite manual native edits.

Four-direction character pack: 64×64 transparent frames, six opaque colors, eight-frame lateral walks at 100 ms/frame and four-frame down/up walks at 125 ms/frame. Directions are from the player's perspective: down = front, up = back, left/right = profiles.

- `base/`: four standing direction PNGs and `approved-original.png`, the original approved sprite.
- `source/`: editable Aseprite master, individual direction/base files, approved original, generation reference and reproducible Aseprite export script.
- `animations/`: horizontal walk strips (512×64 for left/right, 256×64 for down/up) and a complete 576×256 sheet.
- `frames/`: twenty-four individual 64×64 walking frames.
- `previews/`: enlarged GIF loops and contact sheet for inspection; these are previews, not game textures.

The complete sheet uses rows `down`, `left`, `right`, `up`. Each row has nine 64×64 columns: standing base, then up to eight walking frames. Left/right use all eight; down/up use the first four with the final four cells empty. Left/right frames are 100 ms; down/up frames remain 125 ms.

Palette: transparent index 0, then `#252323`, `#574236`, `#68734b`, `#e6cf9a`, `#d79b5b`, `#ad5739`. Indexed sources and exports share this exact palette. No dithering, partial alpha, or filtering.

## Use in Godot

Open `res://scenes/previews/wanderer_64_preview.tscn` and press **F6** to test with WASD or arrow keys. The existing main/player scenes remain unchanged.

To use the character in another scene, instance `res://scenes/wanderer_64.tscn`. Its origin is at the feet. `res://resources/sprite_frames/wanderer_64.tres` contains `idle_down/left/right/up` and `walk_down/left/right/up`. Releasing movement preserves the last facing direction. Textures use nearest filtering.

The original direction bases and down/up poses were generated with image_gen, then cleaned and exported using Aseprite. The current lateral walk directly edits the approved idle-right pixel base in Aseprite: all pixels above row 46 remain identical, and only the original eight-row leg region is articulated. Left mirrors right. No newly generated side pose artwork is used in the current walk. The set is editable in `source/wanderer_64.aseprite`.

Validation: `Godot --headless --path <project> --script res://tools/validate_wanderer_64.gd` checks frame sizes, all eight animations, movement and idle direction retention.

The official Mana Seed demo was downloaded separately for motion/timing study. Its artwork is not included in this repository or supplied to image generation. See `source/side-walk-review.md` for findings.

Lateral gait revision: each physical leg retains its own color and uses the same joint lengths and rigid 7×4 boot shape, offset by four frames. Contact poses 1 and 5 swap the leading foot. Editable direction files contain separate dark-leg, brown-leg and approved-upper-body layers. `previews/leg_identity_slow.gif` shows the whole sprite, isolated dark leg and isolated brown leg. `source/gait-joints.tsv` records the joints and boot dimensions.

The current trouser silhouettes are thicker to match the chunky approved base. This changes garment volume only; the accepted eight-frame leg trajectory and rigid boots are unchanged. The `_chunky.aseprite` copies expose the current revision without reusing an older open tab.

## Running — redrawn revision

`run_down` and `run_up` use six reference-derived poses at 90 ms each (540 ms per cycle). The accepted lateral runs keep 80/55/125/80/55/125 ms (520 ms). Side poses are image-generated and retouched in Aseprite; current front/back limb silhouettes are adapted from JIK-A-4’s CC0 MetroCity preview, fitted to the approved Wanderer identity. The light near hand moves behind-to-front across the right-facing cycle; the dark far arm follows the opposite path with a stable identity. Head pixels reuse the approved base; torso and legs are fitted to the approved short proportions.

`source/wanderer_64_run_redraw.aseprite` has all four tagged runs. `source/run_right_redraw.aseprite` exposes the separate dark arm and light-hand layers. `previews/run_arm_swing_check.gif` shows full character, light hand and dark arm independently at reduced speed. Exact prompts and visual review notes are in `source/run-redraw-prompts.json` and `source/run-redraw-notes.md`.

Rebuild through `source/build-run.lua` or `source/publish-run-redraw.lua`. The original walk/base assets remain unchanged. Legacy eight-frame run PNGs 07/08 are excluded from version control; the strips, JSON and native six-frame sources define the current animation.

In Godot hold Shift with WASD/arrows to run at 104 px/s; release Shift to walk at 64 px/s. Open `scenes/previews/wanderer_run_preview.tscn` and press F6. The current preview uses the Wildroot woodland with matched props, 32px terrain, a 1× camera and a live HUD. R resets, Z switches zoom, and H hides the HUD.


## Rebuild with Aseprite

Run these from the repository root with `aseprite` on your PATH (or use the executable's full path):

```sh
aseprite --batch --script-param root=assets/sprites/wanderer_64 --script assets/sprites/wanderer_64/source/build-animations.lua
aseprite --batch --script-param root=assets/sprites/wanderer_64 --script assets/sprites/wanderer_64/source/build-run.lua
```

These scripts overwrite generated exports and native animation files. Save manual Aseprite edits separately before rebuilding. The retained concept PNGs are build inputs; `sides-concept-v2.png` and versioned review files are historical references. Current masters are `source/wanderer_64.aseprite` (idle/walk) and `source/wanderer_64_run.aseprite` (run). For manual edits, open a native master and export the affected animation rather than rerunning the concept conversion.


## Native front/back run revision

The current front/back runs replace the previous geometric limb rig with observed MetroCity poses. Open `source/run_down_reference.aseprite` or `source/run_up_reference.aseprite`: trousers/boots, rear sleeves, trunk, forward fists and approved head are separate layers. `source/front-run-arms.lua` contains hand-pixelled native-size arms; both 3×3 palms remain visible in every frame. Source GIF, pose masks, credit, license and derivation are in [reference/metrocity/SOURCE.md](reference/metrocity/SOURCE.md). No image generation was used for this revision. Head identity, six colors, standing/walking assets and accepted lateral runs are preserved.
The woodland preview now uses a 1× camera, Z for optional 2× inspection, H to hide the live HUD, and R to reset. See `docs/ART_GUIDE.md` from the project root for the current scale and animation decisions.
