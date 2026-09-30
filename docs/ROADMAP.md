# Roadmap

The owner approved the simpler workflow on 2026-09-30 (D-001 in `DECISIONS.md`). Tool provisioning does not gate learning. Pair Mode remains the default.

## NOW - One small owner-authored gameplay iteration

- Automated Windows baseline passed: import, script parsing, and 120-iteration startup. See `PROJECT_CONTEXT.md` for scope and limitations.
- Owner reported basic WASD movement works and requested the next phase. Do not treat this as proof of other gameplay behavior or code understanding.
- Optional Windows critic onboarding passed: authenticated status, MiniMax M3 access, a completed source review, and blocked direct/shell writes to disposable fixtures. See `PROJECT_CONTEXT.md` for verification limits. No further tooling is needed for the next learning session.
- Next session: trace W through the current player script, then add one visible wall in the Godot editor with the owner creating its `StaticBody2D` and `CollisionShape2D`. Learn how the existing `move_and_slide()` reacts to collision. This is a proposed exercise; no gameplay change has been implemented.

## NEXT

- Complete one owner-authored code or scene change, review it, run it, and explain the changed path.
- Trace W through InputMap, `Input.get_vector()`, velocity, `move_and_slide()`, and animation selection; agree on one observable change and the part the owner will implement. Inspector speed changes are a warm-up.
- Finish a Git checkpoint and test the handoff on the Mac: same branch, same Godot version, local paths and authentication. macOS verification is pending.
- Update the NOW item and one next action when the iteration ends.

## OPTIONAL TOOLING - When it helps current work

- Command Code / MiniMax M3: use a stable user-managed Node/npm runtime, complete human login, check the model, and verify read-only behavior before relying on reviews.
- Keep one review entry point with a code/design choice and only the OS wrappers needed. Use fresh, neutrally framed reviews for consequential uncertainty, not every commit.
- Reuse native ECC only when a selected workflow adds useful discipline.
- Aseprite export automation follows a working manual export and agreed names/tags. The owner continues drawing.

## PARKED

- Godot MCP, Dev Hub, permanent role agents, telemetry, broad CI/test frameworks, and taste learning until a real need appears.
- New gameplay systems and asset reorganization until the owner chooses the goal.
- Additional docs until their first useful decision, playtest, or convention exists.

## Handoff

Current focus: the owner creates and playtests one visible collision obstacle with Codex guidance. Optional Windows critic onboarding is complete; basic WASD was confirmed by the owner. No new gameplay implementation has been delegated. GitHub publication and the Mac handoff remain separate, unverified steps.
