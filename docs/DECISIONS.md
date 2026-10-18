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

## D-003 — Add preparation for gameplay, narrative, and product communication

Date: 2026-10-07. Type: learning/workflow. Status: requested by the owner; session details are an initial working plan, not approved story or marketing decisions.

Add P0 sessions to the existing roadmap for player experience, narrative through actions/consequences, and communicating the game to potential players. Gameplay and story both matter to the owner, and art direction follows their developing style. Prepare one small situation that can connect to the forest experiment; record hypotheses honestly and revise after playing.

Begin with a short P0-01 discussion, then allow drawing/coding and the remaining preparation sessions to alternate. Preparation does not require a finished screenplay, store page, release scope, or sales forecast. Preserve one active agenda rather than building a separate planning system.

## D-004 — Develop story chapters together with playable learning targets

Date: 2026-10-08. Type: learning/workflow. Status: chapter-based guidance and owner-led execution requested by the owner; chapter contents and plot remain proposals.

Keep one short overall narrative direction, then detail only the active chapter in `ROADMAP.md`. Each chapter connects a story purpose, player actions/consequences, minimum playable outcome, required systems/art, learning concepts, owner contribution, and observed completion evidence. Chapters can use multiple existing modules; retain module IDs rather than creating a second task board.

Codex organizes dependencies and next steps, advises, teaches, and reviews. The owner chooses story/gameplay direction, attempts meaningful implementation, draws art, and evaluates play. When stuck, increase help from a hint to a small example or an explained joint fix. Do not silently implement a learning-critical system. Revise future chapters based on actual play and learning progress; no full screenplay or orchestration infrastructure is required before beginning.

## D-005 — Integrate current references and cross-device workflow

Date: 2026-10-18. Type: source integration / workflow. Status: the owner supplied Bible v2 and the A/B/C collection for understanding and authorized merging the Windows branch. The review and next task proposal are not additional gameplay/canon approvals.

Merge `codex/bootstrap-setup` into main while preserving Mac assets and user references. Keep one active task board in `ROADMAP.md` and the owner-led learning agreement. Bible v2 is the latest integrated working design; the earlier GDD/v1 are preserved as history. A/B/C are alternative narrative prototypes with acknowledged continuity differences, not final production scripts. The genre choice B reported by Bible v2 does not select ending B.

Preserve source status markers and distinguish implementation, proposed work, technical verification and the owner's visual acceptance. The latest vertical run remains rejected. The next interaction/learning task is a proposal to agree with the owner before implementation; this merge does not resume character generation or authorize building the full game.

Revisit narrative canon and scope after the first small gameplay loop is played. Do not infer that a document review or passing validation proves gameplay enjoyment, visual quality or owner mastery.
