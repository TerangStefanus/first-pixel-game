# MetroCity motion reference

- Author: **JIK-A-4**
- Pack: [MetroCity – Free Top Down Character Pack](https://jik-a-4.itch.io/metrocity-free-topdown-character-pack)
- License stated on the author's page: **CC0-1.0 Universal**.
- [CC0 legal text](https://creativecommons.org/publicdomain/zero/1.0/)
- Retrieved: 2026-10-17.
- Included source: `official-models-preview.gif`, the author's published 360×360, 18-frame preview.
- [Original preview URL](https://img.itch.zone/aW1hZ2UvMjQzMzUwMS8xNDQwOTE4OC5naWY=/original/AkmUQ2.gif)

The full RAR pack is not included. The official GIF is an integer 10× enlargement: reducing it with nearest-neighbor sampling gives the original 36×36 pose grid. Frames 1–6 show front running, 7–12 show profile running, and 13–18 show back running. Original timing is 110ms per frame. Frames 1/4 are matching passing poses; the opposed strides are in 2/3 and 5/6.

## Derivation used in Wanderer

`pose-masks.json` and `pose-masks.lua` preserve observed clothing, hand, trouser and boot silhouettes for inspection from front frames 1–6 and back frames 13–18. Symbols: O = shirt outline, T = shirt, H = visible hand/skin, P/Q = trouser fill/shadow, B/K = boot fill/shadow. Empty cells exclude the background. Source head pixels are not used.

`source/front-run-poses.lua` fits torso/trouser/boot silhouettes to Wanderer's approved short body and restores its own face/hair/scarf/chest/backpack. Directly scaling the small reference hand masks caused clipped/tiny hands in the rejected prototype. The current `source/front-run-arms.lua` instead contains explicitly painted hero-size sleeves, bent elbows and complete 3×3 palms. Rear sleeves sit behind the trunk; bent forward arms sit above it; the approved head is a separate top layer. Both hands remain visible throughout the cycle. The torso/leg pose silhouettes are **adapted from CC0 artwork**, not claimed as wholly original drawings. The approved head translates vertically by [0,-1,-1,0,-1,-1] pixels, as measured in the reference. Each new pose is 90ms (540ms full cycle); the accepted side runs keep their previous timing. The combined four-direction GIF uses a uniform 90ms comparison clock; individual direction GIFs and Godot contain their actual direction-specific timing.

Hair and identity layers, source masks and rendered poses remain editable and inspectable. No image generation was used for this front/back revision. Earlier side/base assets retain their existing provenance.

Secondary reading: [SLYNYRD, Pixelblog 55](https://www.slynyrd.com/blog/2025/3/24/pixelblog-55-top-down-character-animation), for checking consistency across directions. Its artwork is not included or copied. [Sora by DaniloMattos](https://opengameart.org/content/simple-animated-character), another CC0 example, was inspected but not incorporated.
