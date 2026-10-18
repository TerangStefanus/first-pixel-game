# Changelog

## 2026-10-18

### Added — native macOS critic workflow

- Add a native Command Code launcher matching the existing Windows review policy, with bounded subprocesses, exact model checks and failure/interrupt propagation.
- Add nine mocked wrapper tests and document Mac installation/authentication, a completed MiniMax M3 request, and two live denied write diagnostics.
- Preserve shared permissions, machine-local credentials/paths, Windows tooling and gameplay/art assets.

### Updated — integrated v2 design and Windows learning workflow

- Integrate `codex/bootstrap-setup` through a fast-forward, retaining Mac assets and reference files.
- Add the unmodified Bible v2 and complete A/B/C novel collection with reference-index/checksum updates.
- Record route trade-offs, source continuity differences, current implementation gaps and one proposed owner-led interaction task.
- Refresh project context and roadmap without implementing gameplay or changing character/map/UI art.

### Added — narrative and visual discussion sources

- Include the original Wildroot world bible and Jalur A novel DOCX files, three user-supplied concept images, the illustration embedded in the novel, and seven gameplay review screenshots.
- Add a reference index, source-file checksums and Windows continuation notes recording the rejected vertical run artwork.
- Keep discussion images outside Godot asset import; no gameplay or animation changes in this update.

### Fixed — reference-based vertical running

- Replace the front/back geometric limb rig with six-pose silhouettes adapted from JIK-A-4's CC0 MetroCity character reference.
- Fit alternating hand occlusion and folded/planted feet to Wanderer's short proportions; preserve its head, backpack and six-color palette.
- Use 90ms per front/back pose in Aseprite, GIF exports, JSON and Godot; retain accepted side runs, walking, woodland, camera and UI.
- Redraw sleeves/elbows/fists at native hero size with separate depth layers; add a rendered-palm regression check for the reported disappearing hands.
- Include the official motion preview, inspectable pose masks and provenance; update run timing validation.

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
