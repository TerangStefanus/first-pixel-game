# First Pixel Game / Wildroot

A small Godot 4 pixel-art game project. The current project targets Godot 4.6 and includes the original movement prototype plus a separate Wanderer character preview.

## Run the project

1. Import `project.godot` in Godot 4.6.
2. Press **F5** to run the existing main scene.
3. To explore the character testing map, open `scenes/previews/wanderer_run_preview.tscn` and press **F6**.

In the Wanderer preview, use **WASD / arrow keys** to walk and hold **Shift** to run. Walking uses 64 px/s; running uses 104 px/s. Releasing movement keeps the last facing direction. Press **R** to return to the central clearing, **Z** to switch between 1× and 2× zoom, and **H** to hide/show the HUD.

The testing scene uses a new Wildroot woodland set: 32px ground tiles, larger native tree sprites, quieter ground colors and props matched to the character. A 1× camera shows more world than the earlier 3× view. The live HUD displays movement state/speed and a minimap. [Gameplay view](docs/previews/wildroot-play.png) · [Map overview](docs/previews/wanderer-map.png).

## Wanderer assets

- Transparent 64×64 frames with six opaque colors.
- Four standing bases and four-direction walk/run animations.
- Eight-frame side walks at 100 ms per frame; four-frame front/back walks at 125 ms per frame.
- Six-frame runs at 80/55/125/80/55/125 ms, with opposing arm swings and consistent limb colors.
- Editable Aseprite sources, exported PNG strips, JSON metadata and GIF previews.
- A reusable `scenes/wanderer_64.tscn` and shared `resources/sprite_frames/wanderer_64.tres`.

See the [asset guide](assets/sprites/wanderer_64/README.md) for the palette, source files, rebuild commands and animation layout. The character artwork was created at the owner's request with image generation and native Aseprite edits; generation prompts and review notes are retained alongside the sources.

The current environment assets are in [Wildroot woodland](assets/tilesets/wildroot/README.md). The six-color character remains the palette/style reference; its front/back runs now use native Aseprite poses with a stable head, torso and backpack. See [the art guide and research](docs/ART_GUIDE.md).

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

See [CHANGELOG.md](CHANGELOG.md) for completed updates and [WILDROOT_CODEX_BOOTSTRAP.md](WILDROOT_CODEX_BOOTSTRAP.md) for the proposed learning-first workflow. The bootstrap describes setup work; its presence does not mean those tools are already configured.

Commit messages use Conventional Commits: `type(scope): concise description`, with a body describing the change and relevant validation when useful.
