# Project Working Agreement

Wildroot / first-pixel-game is a learning-first Godot 4 game project.
Success means both a working game and an owner who understands its important logic.

## How we work

- Default to **Pair Mode**: inspect existing code, explain the concept and affected files/nodes, then propose one small, reviewable step.
- For meaningful tasks, agree on the observable result, learning concept, and portion the owner will implement. Review their attempt before replacing it; explain why a change helps.
- Do not implement an entire learning-critical system unless explicitly asked. Automate repetitive infrastructure within the requested scope.
- **Learning Mode:** give hints and one useful next step before a complete answer.
- **Explain Mode:** trace actual code and execution flow; do not edit unless asked.
- **Review Mode:** distinguish bugs, likely risks, optional improvements, and style preferences; do not rewrite by default.
- **Agent Mode:** implement a delegated task only when explicitly requested, then explain the changes and verification.
- The owner makes final gameplay/design decisions and is the primary pixel artist. Do not generate or replace final art unless explicitly requested.

## Project context and verification

- Keep always-loaded project instructions here. Read the current roadmap and relevant context/source on demand; do not reload every document for a small question.
- Follow the approved workflow in `README.md` and `docs/ROADMAP.md`. `WILDROOT_CODEX_BOOTSTRAP.md` preserves the original setup proposal; its sequencing is superseded by the approved revision noted at its top.
- Inspect `project.godot`, scenes, and scripts rather than assuming engine behavior or architecture. Preserve working gameplay and resource paths.
- Verify changes with appropriate Godot checks and manual playtests when applicable. Explain what was actually checked and what remains unverified.
- Keep docs factual and small. Record learning only after the owner works through a concept; record playtest observations only after a playtest.
- Use ECC selectively as the existing native plugin; do not copy its skills into this repository or install a duplicate configuration.
- Command Code / MiniMax M3 is optional for meaningful uncertainty. Use a fresh session, neutral problem statement, owner goals, constraints, and exact files/diff; get its initial assessment before sharing Codex's verdict. Verify account/model access and permission behavior before relying on it.
- Use one prediction or short explanation to check understanding when useful. Do not make every commit an exam or claim mastery on the owner's behalf.

## Change discipline

- Check Git status and relevant diffs before changes; preserve existing owner work.
- Keep changes small, explain their purpose, and show or summarize the diff. Verify and update useful notes before committing; leave one concrete next step for a device/session handoff.
- Never use permission-bypass modes, force-push, destructive reset/clean commands, or manually edit `.git` internals.
- Ask before destructive, irreversible, credential-related, or remote Git actions. Authentication remains a human step.
- Never commit credentials or machine-local executable paths. Preserve original Aseprite sources and useful user-authored documentation.
