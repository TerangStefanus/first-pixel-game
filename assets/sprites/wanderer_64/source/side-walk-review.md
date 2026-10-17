# Lateral walk review

The first version passed frame-size and uniqueness checks but did not form a convincing side-walk cycle. This review adds visual pose checks and consistency checks.

## Problems found in v1

- Side poses jumped from a wide stance to a high knee, producing a marching/hopping impression.
- Contact and passing poses did not clearly alternate the near and far leg.
- Independently generated heads and torsos changed shape between frames.
- The export centered every pose by the full silhouette. Moving an arm or foot changed that bounding box, causing the body to shift horizontally.
- Four frames left too little room for the intended low, restrained stepping motion.

## Repair

- Six right-facing poses with alternating brown near leg and dark far leg, low foot clearance and smaller arm movement.
- A shared scale and head anchor replace per-frame full-silhouette centering.
- The approved idle-right head pixels (rows 0–34) are reused exactly in all right-walk frames.
- Every left-walk frame is an exact mirror of its right counterpart; idle-left uses the same mirrored approved base.
- Side timing is 135 ms/frame (about 7.41 FPS). Down/up retain their existing pixels and 125 ms/frame timing.
- The Aseprite master has 24 frames and 8 independent tags. The complete sheet is 448×256; lateral strips are 384×64.

## Reference studied

[Mana Seed Character Base](https://seliel-the-shaper.itch.io/character-base), official free demo 2.0 downloaded from the author's page. Its guide describes a six-frame walk with uniform 135 ms timing. The author also distinguishes walking from running through different poses and timing.

The download is kept locally outside this repository. No Mana Seed art, recolored sprites, frame crops or traced silhouettes are included in the game or supplied to image_gen. The revised artwork is generated from our own character, with final pixel assembly in Aseprite. The author's [license](https://selieltheshaper.weebly.com/user-license.html) restricts redistribution and use alongside generated content.

The matching Godot validation checks 64×64 frame regions, all four directions, idle facing retention, exact side mirroring, identical head pixels and lateral timing. Those checks complement visual review; they do not establish that a gait is artistically finished.

## Proportion correction after v2

The user correctly identified that v2 changed the jacket and lengthened the apparent legs, despite fixing the head and total sprite height. Locking only the head was insufficient.

The current revision no longer uses `sides-concept-v2.png` to build lateral frames. It starts with the approved `base/idle_right.png` and preserves rows 0–45 exactly (head, jacket, backpack and hands). Only rows 46–53, the original eight-pixel leg region, are articulated with small horizontal foot displacements and at most one pixel of lift. Every frame has the same top (12) and grounded bottom (53) as the approved base. No sprite stretching is used. Arm movement is intentionally held fixed in this revision to preserve the approved upper-body silhouette.

`previews/base_vs_walk.gif` shows the approved idle on the left and the corrected walk on the right. The generated v2 concept and prompt remain only as an iteration record; the native repair script no longer reads that concept. Godot validation now compares the whole upper body against the approved idle and checks that no leg pixels extend below its baseline.

## Leg alternation correction

The compact six-frame attempt still used different leg/boot widths, hid the far foot during crossing, and moved the raised boot independently from the knee. The user correctly identified the apparent color swap and shrinking foot.

The current eight-frame, 100 ms lateral cycle uses one articulated leg trajectory offset by four frames for the other leg. Both thighs and shins have equal fixed 3.25 px lengths, solved from the hip and ankle positions. Both feet retain the same rigid 7×4 px boot mask in all poses. The near leg stays brown and the far leg stays dark; layer order stays anatomically consistent. Forward reach alternates between the brown foot (frame 1) and dark foot (frame 5), with equal 8 px foot separation. Each passing pose bends the knee and lifts the whole boot by up to 2 px. The approved upper body remains identical and the grounded baseline remains row 53.

Reference: [Toon Boom Walk Analysis](https://learn.toonboom.com/modules/walk-cycle-animation/topic/walk-analysis1) explains opposite contact poses with equally spaced feet and a bent advancing leg during passing. The reference informed motion principles only; artwork is edited directly in Aseprite.

The current export has 28 master frames and 8 tags, 512×64 lateral strips and a 576×256 complete sheet. Down/up retain their four frames and 125 ms timing. `walk_left_gait.aseprite` and `walk_right_gait.aseprite` are layered copies of the current lateral source files.

## Trouser volume correction

The user accepted the eight-frame motion but rejected the thin legs. The centerline geometry was being rendered with only about a three-pixel silhouette and one-pixel brown interior, which lost the original chunky trouser style.

This revision changes only the trousers' cross-section: the outer radius increases from 1.45 to 2.65 px and the brown interior radius from 0.6 to 1.55 px (roughly five-pixel silhouette, three-pixel interior). Hip, knee and ankle trajectories, boot pixels and positions, leg identity, layer order, frame count and timing remain identical to the accepted gait. The approved upper body and six-color palette remain intact. Native Aseprite layered copies are named `walk_left_chunky.aseprite` and `walk_right_chunky.aseprite`.
