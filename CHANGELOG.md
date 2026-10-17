# Changelog

## 2026-10-17

### Woodland and character revamp

- Replace the mixed-style testing environment with new Wildroot woodland props and original quiet 32px ground tiles using a palette related to the character.
- Use native 110–128px trees and smaller bushes, rocks and flowers, with ground-aligned collision and depth sorting.
- Change the preview camera from 3× to 1×; add integer viewport scaling and optional 2× inspection with Z.
- Add a live movement/speed HUD, position minimap and H-to-hide control.
- Redraw front/back runs natively from the approved bases with consistent heads/backpacks, chunky legs, rigid boots and opposing hand swings.
- Document research, scale decisions, generation prompt, editable sources and rebuild commands.


### Added

- A 56×36-tile grass/dirt testing map with connected loop/crossing paths, collision landmarks and borders, camera limits and an R-to-reset shortcut.

- Wanderer 64×64 character pack with a six-color palette, four standing directions, walking and running animations, native Aseprite sources and export scripts.
- Godot character scene with direction-preserving idle, walking and Shift-to-run controls.
- Separate walk/run preview scenes and a CC0 Ninja Adventure animated flower sample with source attribution.
- Headless checks for animation metadata, movement transitions, side-walk consistency and animated tiles.

### Updated

- Running poses with opposing light/dark arm swings, retained limb identities and short character proportions.
- README and asset documentation with controls, timing, provenance and rebuild instructions.

The character pack is demonstrated in the preview scenes. It has not replaced the player in the existing main scene.
