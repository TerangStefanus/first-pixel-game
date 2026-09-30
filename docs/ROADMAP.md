# Roadmap

The owner approved the simpler workflow on 2026-09-30 (D-001 in `DECISIONS.md`). Tool provisioning does not gate learning. Pair Mode remains the default.

## NOW - Understand and play the current prototype

- Automated Windows baseline passed: import, script parsing, and 120-iteration startup. See `PROJECT_CONTEXT.md` for scope and limitations.
- Owner: run the game and try movement, diagonals, key release, and idle/walk transitions. Visual behavior and game feel still need a human playtest.
- Together: trace W through InputMap, `Input.get_vector()`, velocity, `move_and_slide()`, and animation selection.
- Agree on one observable change and the part the owner will write/build. Changing Inspector speed is a warm-up, not the whole learning iteration.
- If the plain background and following camera make motion hard to judge, observe Player position in the Remote Inspector; the owner can choose to add a simple scene landmark as an exercise.

## NEXT

- Complete one owner-authored code or scene change, review it, run it, and explain the changed path.
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

Current focus: the owner's first walkthrough after passing automated Windows checks. No gameplay implementation is delegated by this roadmap. Next human step: run the prototype, report what is visible, and choose the first small change together. This handoff covers workflow/verification work; GitHub publication and the Mac handoff are separate, unverified steps.
