#Requires -Version 7.0
[CmdletBinding()]
param(
    [ValidateSet('Status', 'Version', 'Login', 'Interactive', 'Models', 'Review')]
    [string]$Mode = 'Status',
    [ValidateSet('code', 'design')][string]$Kind = 'code',
    [string]$Request,
    [string]$RequestFile,
    [string]$NodePath,
    [string]$CommandCodeEntry,
    [ValidateRange(1, 30)][int]$MaxTurns = 8,
    [ValidateRange(5, 600)][int]$TimeoutSeconds = 180
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path $PSScriptRoot -Parent
$model = 'MiniMaxAI/MiniMax-M3'

function Invoke-CriticProcess {
    param([string[]]$CliArguments, [string]$InputText = '')
    $info = [System.Diagnostics.ProcessStartInfo]::new()
    $info.FileName = $NodePath
    $info.WorkingDirectory = $repoRoot
    $info.UseShellExecute = $false
    $info.CreateNoWindow = $true
    $info.RedirectStandardInput = $true
    $info.RedirectStandardOutput = $true
    $info.RedirectStandardError = $true
    $info.Environment['PATH'] = (Split-Path $NodePath -Parent) + [IO.Path]::PathSeparator + $env:PATH
    foreach ($argument in (@($CommandCodeEntry, '--no-auto-update') + $CliArguments)) {
        $info.ArgumentList.Add($argument)
    }
    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo = $info
    try {
        if (-not $process.Start()) { throw 'Could not start Command Code.' }
        $stdout = $process.StandardOutput.ReadToEndAsync()
        $stderr = $process.StandardError.ReadToEndAsync()
        if ($InputText) { $process.StandardInput.Write($InputText) }
        $process.StandardInput.Close()
        if (-not $process.WaitForExit($TimeoutSeconds * 1000)) {
            $process.Kill($true)
            $process.WaitForExit()
            throw "Command Code exceeded $TimeoutSeconds seconds and was stopped."
        }
        return [pscustomobject]@{
            ExitCode = $process.ExitCode
            Output = $stdout.GetAwaiter().GetResult()
            ErrorText = $stderr.GetAwaiter().GetResult()
        }
    }
    finally { $process.Dispose() }
}

function Write-CriticResult {
    param($Result)
    if ($Result.Output) { [Console]::Out.Write($Result.Output) }
    if ($Result.ErrorText) { [Console]::Error.Write($Result.ErrorText) }
}

try {
    $pathsFile = Join-Path $PSScriptRoot 'local/paths.json'
    $localPaths = if (Test-Path -LiteralPath $pathsFile) { Get-Content -LiteralPath $pathsFile -Raw | ConvertFrom-Json } else { $null }
    if (-not $NodePath -and $localPaths) { $NodePath = $localPaths.NodePath }
    if (-not $NodePath) { $NodePath = (Get-Command node -CommandType Application -ErrorAction Stop).Source }
    if (-not $CommandCodeEntry -and $localPaths) { $CommandCodeEntry = $localPaths.CommandCodeEntry }
    if (-not $CommandCodeEntry) {
        throw 'Configure NodePath and CommandCodeEntry (the installed dist/index.mjs) in ignored tools/local/paths.json.'
    }
    foreach ($executableFile in @($NodePath, $CommandCodeEntry)) {
        if (-not (Test-Path -LiteralPath $executableFile -PathType Leaf)) { throw "Executable/entry point not found: $executableFile" }
    }
    $NodePath = (Resolve-Path -LiteralPath $NodePath).Path
    $CommandCodeEntry = (Resolve-Path -LiteralPath $CommandCodeEntry).Path

    if ($Mode -in @('Login', 'Interactive')) {
        # Human-driven terminal/browser interaction; never capture login input.
        $savedPath = $env:PATH
        Push-Location $repoRoot
        try {
            $env:PATH = (Split-Path $NodePath -Parent) + [IO.Path]::PathSeparator + $savedPath
            if ($Mode -eq 'Login') {
                & $NodePath $CommandCodeEntry --no-auto-update login
            }
            else {
                & $NodePath $CommandCodeEntry --no-auto-update --skip-onboarding --no-skills --permission-mode plan --model $model
            }
            $interactiveExit = $LASTEXITCODE
        }
        finally { $env:PATH = $savedPath; Pop-Location }
        exit $interactiveExit
    }
    if ($Mode -eq 'Version') {
        $result = Invoke-CriticProcess @('--version')
        Write-CriticResult $result
        exit $result.ExitCode
    }
    $statusResult = Invoke-CriticProcess @('status', '--json')
    $status = $statusResult.Output | ConvertFrom-Json -ErrorAction Stop
    if ($Mode -eq 'Status') {
        [pscustomobject]@{ authenticated = ($status.authenticated -eq $true); version = $status.version } | ConvertTo-Json
        exit $statusResult.ExitCode
    }
    if ($statusResult.ExitCode -ne 0 -or $status.authenticated -ne $true) {
        [Console]::Error.WriteLine('Not authenticated. Run ./tools/command-code.ps1 -Mode Login yourself, then -Mode Interactive to confirm project trust. Do not use /import.')
        exit 3
    }
    $modelsResult = Invoke-CriticProcess @('--list-models')
    if ($Mode -eq 'Models') {
        Write-CriticResult $modelsResult
        exit $modelsResult.ExitCode
    }
    if ($modelsResult.ExitCode -ne 0) {
        Write-CriticResult $modelsResult
        exit $modelsResult.ExitCode
    }
    if ($modelsResult.Output -notmatch '(?<![A-Za-z0-9_/-])MiniMaxAI/MiniMax-M3(?![A-Za-z0-9_/-])') {
        throw "Required model $model was not found in the available model list. No fallback model was selected."
    }
    if ($Request -and $RequestFile) { throw 'Use either -Request or -RequestFile.' }
    if ($RequestFile) { $Request = Get-Content -LiteralPath $RequestFile -Raw }
    if ([string]::IsNullOrWhiteSpace($Request)) { throw 'Review needs -Request or -RequestFile with a neutral question and exact scope.' }
    $promptName = if ($Kind -eq 'design') { 'game-design-critic.md' } else { 'code-critic.md' }
    $prompt = Get-Content -LiteralPath (Join-Path $PSScriptRoot "command-code/prompts/$promptName") -Raw
    $inputText = $prompt + "`n`nOwner request (fresh independent review):`n" + $Request
    $result = Invoke-CriticProcess @('-p', '--model', $model, '--permission-mode', 'plan', '--skip-onboarding', '--no-skills', '--no-session', '--max-turns', "$MaxTurns", '--output-format', 'text') $inputText
    Write-CriticResult $result
    exit $result.ExitCode
}
catch {
    [Console]::Error.WriteLine($_.Exception.Message)
    exit 1
}
