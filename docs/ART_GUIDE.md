# Wildroot visual scale and animation

## Current decisions

The approved Wanderer is the style reference. Its canvas is 64×64, while the visible character is approximately 40–42 pixels tall. Character exports retain six opaque colors plus transparency; heads, standing bases, accepted walking assets and lateral runs are preserved.

The current woodland uses original 32×32 ground tiles and new props rather than mixing the character with the Ninja Adventure atlas. Tree silhouettes are 110–128 pixels tall, about 2.6–3.2 visible character heights. Bushes are 28 pixels tall, rocks 24, ferns 20, and individual flowers approximately 8. Trees soften when the character is behind their canopy so the sprite remains visible. Native art is rendered at scale 1; larger props have more native pixels, rather than stretching a small tree texture.

The environment palette extends the character's outline, brown, olive and cream with foliage/stone shades and restrained ground colors. The full environment palette has 16 opaque colors; individual props use a smaller subset. The character still uses exactly its original six colors. Ground texture is sparse so it does not compete with the character.

## Camera and UI

The testing scene uses a 640×360 design viewport, nearest filtering, viewport rendering and integer window scaling. Its Camera2D starts at 1×, replacing the previous 3× close-up. The character occupies approximately 12% of screen height instead of 35%. This is a project choice to test readability and movement, not a universal correct zoom level.

- **Z** switches between 1× play view and 2× inspection view.
- **H** hides/shows the HUD.
- **R** resets the character to the clearing.
- The HUD displays actual movement state/speed and a live position on the minimap. It does not imply a combat or stamina system.

Integer scaling may leave borders when the window does not fit the design resolution evenly. It keeps pixel widths consistent. These settings apply to the preview window at runtime; the original main scene and global project settings are preserved.

## Front/back running

The current front/back runs are original native pixel poses built from the approved bases in `assets/sprites/wanderer_64/source/front-run-poses.lua`. The face/hair and central torso/backpack are reused without deformation, with whole-pixel vertical movement. Separate left/right trouser layers keep chunky legs and rigid 7×4 boots. The sleeve/hand layer follows an opposing, stepped swing; hands keep their skin color and dimensions.

Six poses retain the 80/55/125/80/55/125 ms cycle. Contact, compression and lifted-foot poses alternate physical sides. Editable files are `source/run_down_native.aseprite` and `source/run_up_native.aseprite`; the main run master and exported strips contain the same revision. The older generated front/back concept PNGs remain historical references and are no longer build inputs for those directions.

Check the animation both enlarged and at 1× gameplay scale. Automated consistency checks do not establish artistic quality: verify the stride, arm opposition, foot contact, silhouette and loop in motion.

## Rebuild

From the repository root, with Aseprite and Godot on PATH:

```sh
aseprite --batch --script-param root=assets/tilesets/wildroot --script assets/tilesets/wildroot/source/build-woodland.lua
aseprite --batch --script-param root=assets/sprites/wanderer_64 --script assets/sprites/wanderer_64/source/build-run.lua
godot --headless --editor --path . --import
godot --headless --path . --script res://tools/build_wanderer_map.gd
```

These commands regenerate assets and overwrite the preview map. Preserve manual Aseprite/map edits separately before rebuilding. Godot TileMapLayer cells and props remain editable in the saved preview scene.

## Research used

- [Godot: multiple resolutions](https://docs.godotengine.org/en/stable/tutorials/rendering/multiple_resolutions.html): design resolution, viewport rendering and integer scaling.
- [Godot: Window](https://docs.godotengine.org/en/stable/classes/class_window.html): runtime content scale settings.
- [SLYNYRD: Top Down Character Sprites](https://www.slynyrd.com/blog/2019/10/21/pixelblog-22-top-down-character-sprites): tile-relative sprite sizing, depth, consistent bases and checking motion before detail.
- [SLYNYRD: Intro to Animation](https://www.slynyrd.com/blog/2018/8/19/pixelblog-8-intro-to-animation): cycle and key-pose study.

These references informed scale and motion principles. Their artwork was not copied or included in generation inputs.
