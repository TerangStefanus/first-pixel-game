# Optional independent critic

Windows setup verified on 2026-09-30: Node 24.21.0, npm 11.19.0, Command Code 1.72.4. The official Node ZIP passed its published SHA256 check. Installations live outside the repository; no permanent system PATH changes were made.

**Current state:** CLI version works; status reports unauthenticated. Wrapper tests passed using a simulated CLI. Live MiniMax access, a completed review, and runtime permission enforcement have not been verified.

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

Shared `.commandcode/settings.json` supplies the permission policy. Wrapper flags and policy intent do not prove that every tool path is blocked; live verification remains pending. Disabling session persistence also does not guarantee the CLI writes no user-level logs/cache.

## Local paths and macOS

`tools/local/paths.json` is ignored. Preserve any existing Godot/Aseprite keys and add `NodePath` and `CommandCodeEntry`. The latter points to the installed package's `dist/index.mjs`, not a shell shim. `-NodePath` and `-CommandCodeEntry` can override these for an invocation; Node on PATH is a fallback when NodePath is absent.

The PowerShell 7 wrapper may be used on a Mac where PowerShell already exists, after configuring its local paths, but has only been tested on Windows. A Mac does not need PowerShell just to use Command Code: its native `command-code` CLI supports login, status, and reviews. Verify installation/flags there and add a thin native wrapper only when needed. Do not sync machine-local paths or auth files through GitHub.

Tests performed: real CLI version/status; review stops before inference when unauthenticated; simulated prompt/flag handling, missing-model rejection, upstream error propagation, and timeout termination. The simulated tests do not exercise model behavior or live permissions.
