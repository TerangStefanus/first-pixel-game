# Decisions

## D-001 — Put the learning/play loop before optional tooling

Date: 2026-09-30. Type: workflow. Status: accepted by the owner after the Phase 1.5 review.

Start with an observable goal, one learning concept, and an owner-authored portion. Inspect, implement a small slice, verify, play, and record useful outcomes before a checkpoint. Codex handles context lookup, explanation, review, and bounded infrastructure work.

Command Code/MiniMax and selected ECC workflows support consequential uncertainty; they are not prerequisites for ordinary work. Keep instructions short, source facts in source files, and add docs when a real entry exists. Preserve the original bootstrap while superseding its mandatory phase ordering.

Alternative considered: finish the full tool stack before baseline understanding. Rejected because the prototype is already small enough to learn and iterate on, while secondary tooling adds setup and maintenance.

Revisit when repeated workflow friction, project size, or collaboration needs demonstrate a benefit from additional automation. Human gameplay decisions, learning-critical implementation, artwork, and playtest judgments remain with the owner.

## D-002 — Connect learning modules to a small work agenda

Date: 2026-09-30. Type: workflow/planning. Status: initial working plan prepared in response to the owner's request for design refinement and a module/sprint agenda; detailed gameplay rules remain provisional.

Use `ROADMAP.md` as the only active task board. Each module produces a playable behavior and teaches concepts needed for that behavior. Detail only the current module, keep one task active, and begin with a three-session review rhythm. Evaluate both observed behavior and the owner's explanation of their contribution; do not mark either complete without evidence.

The first target is a forest clearing with collision and berry interaction. Day changes and the wolf/rabbit/berry experiment follow. The original broader prototype remains a vision to reassess after these tests. The initial cadence and task sizes are estimates to revise after the first review, not delivery commitments.

No project-management application, permanent agents, or scheduled automation is needed. Revisit if this simple board becomes difficult to use or actual playtest evidence changes the module order.
