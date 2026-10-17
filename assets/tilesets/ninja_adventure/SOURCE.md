# Ninja Adventure terrain, props and animated flowers

Author: Pixel-Boy and AAA.
Official pack: https://pixel-boy.itch.io/ninja-adventure-asset-pack
Author-linked Godot repository: https://github.com/pixel-boy/NinjaAdventure
Downloaded commit: 6ac78232d5aedcc85ce5f27d060ea92366f7c24a
Original file: content/map/tileset_animated.png (copied unchanged).

The official pack page releases its assets under CC0 1.0 Universal: https://creativecommons.org/publicdomain/zero/1.0/
Commercial use and modification are allowed; credit is optional.

The downloaded example contains four flower frames in the first row (16×16 each). The Godot atlas explicitly uses four animation columns at 5 fps. Its other rows are transparent. This is a flower animation sample, not the entire asset pack.

Additional candidates: Mini Meadow (https://myobln.itch.io/game-assets), free CC0, 16×16 water and shoreline animation in four frames. Tiny Swords (https://pixelfrog-assets.itch.io/tiny-swords), free terrain pack with animated waves, bushes and rocks on a 64×64 grid; the current pack has its own no-standalone-redistribution license. These two alternatives are links only, not downloaded or installed.

## Walkable testing map

- `tileset_floor.png`: copied unchanged from `content/map/tileset_floor.png` at the same downloaded commit.
- `tileset_village_abandoned.png`: copied unchanged from `content/map/tileset_village_abandoned.png`; the preview uses tree and ruined-stone regions.
- `resources/tilesets/ninja_ground.tres`: the floor atlas and grass/dirt terrain matching data adapted from the author-linked repository's `content/map/tileset.tres`. Unused physics defaults are omitted.

The preview's route layout, boundary colliders, prop placement, camera limits and reset behavior are project additions. The map is saved as editable TileMapLayer data in `scenes/previews/wanderer_run_preview.tscn`; `tools/build_wanderer_map.gd` rebuilds the initial layout and overwrites that scene. Preserve manual map edits before rebuilding.
