# Optional independent critic

## macOS setup verified 2026-10-18

Node 24.12.0 and npm 11.6.2 were reused; Command Code 1.84.0 was installed from the official npm package. Authentication succeeded on this Mac, MiniMax M3 appeared in the installed model catalog, and a bounded real request read `scripts/player.gd` successfully. This confirms usable account access for that request, not unlimited quota or review accuracy. The existing Windows verification below remains historical and separate.

Use the native launcher from the repository root; PowerShell is not required:

```sh
./tools/command-code.sh status
./tools/command-code.sh version
./tools/command-code.sh interactive
```

`interactive` opens a human discussion session on MiniMax M3 in plan mode. If a trust prompt appears, confirm the actual project folder yourself. Skip `/import`, `/init`, and taste learning; the project already has its working agreement. If this device is logged out, run `./tools/command-code.sh login` and complete authorization yourself in the browser. The wrapper does not capture login input or add `--trust`.

For a fresh bounded second opinion:

```sh
./tools/command-code.sh review --kind code --request 'Read scripts/player.gd and scenes/player.tscn. Identify supported bugs only; do not edit files.'
./tools/command-code.sh review --kind design --request-file tools/local/design-question.txt
```

The design question should give the owner’s goal, constraints, current/proposed behavior and exact relevant files, without Codex’s verdict. Do not send every document for every question. Get the critic’s initial assessment before comparing it with Codex, then verify its claims against the actual source/playtest.

The native launcher reads `NodePath` from ignored `tools/local/paths.json` on macOS (or `COMMAND_CODE_NODE`, then Node on PATH), so it can work when nvm is not initialized in a noninteractive shell. The JS helper reads `CommandCodeEntry` from the same local file, supports `--entry` / `--node-path` overrides, and falls back to the installed global package. Godot/Aseprite path keys are preserved. Local paths and auth stay outside Git; existing runtime versions and shell profiles were not replaced.

Reviews mirror the Windows policy: repository-root working directory, authentication check, exact case-insensitive MiniMax M3 ID check without model fallback, fresh headless plan mode, no skill discovery/session persistence/auto-update, and prompts through stdin. Limits default to eight turns and 180 seconds **per subprocess**, adjustable via `--max-turns` and `--timeout-seconds`. Timeout exits 124 and interruption exits 130; other CLI failures/partial results retain their nonzero exit status. Human interactive sessions have no automated review timeout.

Nine mocked wrapper tests passed: sanitized status, prompt/flag forwarding including lowercase catalog IDs, missing authentication/model rejection, upstream/partial failure propagation, timeout, argument validation, and interruption cleanup. Run them with Node 22+:

```sh
node --test tools/tests/command-code.test.mjs
```

A separate live permission diagnostic recorded `tool_denied` for `write_file` (Edit deny rule) and `shell_command` redirection (plan mode), while both disposable ignored fixtures retained their original hashes. This covers these two operations on the tested Mac setup, not every tool path. As on Windows, no-session mode does not promise zero user-level logs/cache. No gameplay/art files were modified by the checks.

Install/CLI references checked against [official quickstart](https://commandcode.ai/docs/quickstart), [headless docs](https://commandcode.ai/docs/headless), and the installed 1.84.0 `--help`. The existing shared `.commandcode/settings.json` remains the permission policy.

## Windows setup history

Windows setup verified on 2026-09-30: Node 24.21.0, npm 11.19.0, Command Code 1.72.4. The official Node ZIP passed its published SHA256 check. Installations live outside the repository; no permanent system PATH changes were made.

**Current state (2026-09-30):** authenticated; MiniMax M3 listed and a live source review completed. A bounded permission diagnostic recorded denial of direct file writing and shell redirection; both disposable files remained unchanged. The sandboxed review could not reach the API; the authorized normal-context retry succeeded. These checks cover this Windows configuration and the tested operations.

## Human onboarding (PowerShell 7)

From the repository root:

```powershell
./tools/command-code.ps1 -Mode Login
```

Complete authorization yourself in the browser. Do not paste credentials into chat or project files. Then open the CLI to confirm trust in this actual repository:

```powershell
./tools/command-code.ps1 -Mode Interactive
```

If prompted, confirm the correct project directory. Skip migration and taste learning; do not run `/import` or `/init`. Exit the interactive session with `/exit` after checking the project, then run:

```powershell
./tools/command-code.ps1 -Mode Status
./tools/command-code.ps1 -Mode Models
```

Confirm `MiniMaxAI/MiniMax-M3` is listed. A successful real request is still needed to prove usable account access. Verify permission behavior with harmless disposable fixtures before describing the critic as operationally read-only. No bypass flags should be used to make a failed check pass.

## Request a review

```powershell
./tools/command-code.ps1 -Mode Review -Kind code -Request 'Review scripts/player.gd for correctness. Read its player scene and InputMap. Identify concrete issues only; do not edit files.'
./tools/command-code.ps1 -Mode Review -Kind design -RequestFile './tools/local/design-question.txt'
```

Use a neutral question, owner goals, constraints, and exact relevant files/diff. An uncommitted change must be identified as such. Get the critic's initial assessment before sharing Codex's verdict. Do not ask for a routine review of every small change.

The wrapper runs from the repository root, checks authentication and the exact model, sends the prompt through stdin, and starts a fresh headless plan-mode review. It disables session persistence, skill discovery, and background auto-update for that invocation; project taste learning is also disabled. It never adds `--trust`, resumes previous reviews, chooses a fallback model, or enables permission bypass.

Default limit: 8 model turns and 180 seconds per subprocess, adjustable with `-MaxTurns` and `-TimeoutSeconds`. Authentication and model checks are separate subprocesses, so total wall time can exceed a single timeout. Final review text goes to stdout and CLI diagnostics to stderr. Nonzero results remain failures/partial results, not completed reviews.

Shared `.commandcode/settings.json` supplies the permission policy. Live checks denied `write_file` via the `Edit` rule and shell redirection via plan mode. This does not prove every possible tool path is blocked. Disabling session persistence also does not guarantee the CLI writes no user-level logs/cache.

## Local paths and macOS

`tools/local/paths.json` is ignored. Preserve any existing Godot/Aseprite keys and add `NodePath` and `CommandCodeEntry`. The latter points to the installed package's `dist/index.mjs`, not a shell shim. `-NodePath` and `-CommandCodeEntry` can override these for an invocation; Node on PATH is a fallback when NodePath is absent.

The PowerShell 7 wrapper may be used on a Mac where PowerShell already exists, after configuring its local paths, and the PowerShell wrapper has only been tested on Windows. The native Mac wrapper documented above is now installed and verified; use it instead of installing PowerShell for this task. Do not sync machine-local paths or auth files through GitHub.

Tests performed: real CLI version/status/model list; completed MiniMax M3 source review; two live denied write attempts with unchanged ignored fixtures and clean Git state; review stops before inference when unauthenticated; simulated prompt/flag handling, missing-model rejection, upstream error propagation, and timeout termination. The simulated tests do not exercise model behavior or live permissions. Local diagnostic artifacts remain under ignored `tools/local/permission-check/`.
