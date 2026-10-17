# Wildroot woodland

Original project props created with the built-in imagegen tool using the approved Wanderer as the sole art reference. `source/build-woodland.lua` extracts the eight connected prop silhouettes, removes low-alpha generation residue, fits native pixel dimensions, and constrains foliage/bark/stone palettes in Aseprite. It also creates original low-noise 32px grass/dirt tiles and a tiny flower.

The exact generation prompt is retained in `source/generation-prompt.json`. The concept atlas is a source input; runtime PNGs are cleaned, indexed, binary-alpha native exports. No Ninja Adventure or Mana Seed artwork was used as generation input or copied into these props.

| Export | Visible height | Canvas |
| --- | --- | --- |
| `oak_a`, `oak_b` | 116 / 110 px | 128×144 |
| `pine_a`, `pine_b` | 128 / 120 px | 128×144 |
| `bush`, `flower_bush` | 28 px | 64×48 |
| `rocks` | 24 px | 64×48 |
| `fern` | 20 px | 64×48 |
| `flower` | approximately 8 px | 16×16 |

Tree baseline is row 136; other prop baseline is row 43. The preview places collision at the base and sorts props/character by the same ground position. Canvas padding is intentional and must not be confused with the visible sprite size.

`ground_32.png` is an eight-column atlas: indices 0–3 are grass variants, and 4–19 are dirt tiles with north/east/south/west neighbor masks. The corresponding Godot TileSet uses 32px cells. The full atlas and individual props have editable `.aseprite` sources.

See [the art guide](../../../docs/ART_GUIDE.md) for camera, palette, motion and rebuild details. Ninja Adventure remains in its separate directory as an earlier CC0 reference/sample; the current woodland preview does not use it.
