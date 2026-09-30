#Requires -Version 7.0
[CmdletBinding()]
param(
    [string]$GodotPath,
    [ValidateRange(5, 600)][int]$TimeoutSeconds = 60,
    [ValidateRange(1, 10000)][int]$SmokeIterations = 120
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path $PSScriptRoot -Parent
$localRoot = Join-Path $PSScriptRoot 'local'
$logRoot = Join-Path $localRoot 'verification'

function Invoke-GodotCheck {
    param([string]$Label, [string[]]$CheckArguments)
    $startInfo = [System.Diagnostics.ProcessStartInfo]::new()
    $startInfo.FileName = $script:GodotPath
    $startInfo.WorkingDirectory = $repoRoot
    $startInfo.UseShellExecute = $false
    $startInfo.CreateNoWindow = $true
    $startInfo.RedirectStandardOutput = $true
    $startInfo.RedirectStandardError = $true
    foreach ($argument in (@('--headless', '--path', $repoRoot, '--log-file', (Join-Path $logRoot "$Label.engine.log")) + $CheckArguments)) {
        $startInfo.ArgumentList.Add($argument)
    }
    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo = $startInfo
    try {
        Write-Host "Checking $Label..."
        if (-not $process.Start()) { throw "Could not start Godot for $Label." }
        $stdoutTask = $process.StandardOutput.ReadToEndAsync()
        $stderrTask = $process.StandardError.ReadToEndAsync()
        $timedOut = -not $process.WaitForExit($TimeoutSeconds * 1000)
        if ($timedOut) {
            $process.Kill($true)
            $process.WaitForExit()
        }
        $output = $stdoutTask.GetAwaiter().GetResult() + "`n" + $stderrTask.GetAwaiter().GetResult()
        $outputPath = Join-Path $logRoot "$Label.output.log"
        [System.IO.File]::WriteAllText($outputPath, $output)
        if ($timedOut) { throw "$Label timed out after $TimeoutSeconds seconds. See $outputPath" }
        if ($process.ExitCode -ne 0 -or $output -match '(?m)^\s*(?:SCRIPT ERROR|ERROR):') {
            Write-Host $output
            throw "$Label failed (exit $($process.ExitCode)). See $outputPath"
        }
        Write-Host "PASS: $Label"
    }
    finally { $process.Dispose() }
}

try {
    if (-not (Test-Path -LiteralPath (Join-Path $repoRoot 'project.godot') -PathType Leaf)) {
        throw "project.godot not found in $repoRoot"
    }
    if (-not $GodotPath) { $GodotPath = $env:GODOT_BIN }
    $pathsFile = Join-Path $localRoot 'paths.json'
    if (-not $GodotPath -and (Test-Path -LiteralPath $pathsFile)) {
        $GodotPath = (Get-Content -LiteralPath $pathsFile -Raw | ConvertFrom-Json).GodotPath
    }
    if (-not $GodotPath) {
        foreach ($commandName in @('godot', 'godot4')) {
            $command = Get-Command $commandName -CommandType Application -ErrorAction SilentlyContinue
            if ($command) { $GodotPath = $command.Source; break }
        }
    }
    if (-not $GodotPath -or -not (Test-Path -LiteralPath $GodotPath -PathType Leaf)) {
        throw 'Godot executable not found. Pass -GodotPath, set GODOT_BIN, or configure tools/local/paths.json.'
    }
    $GodotPath = (Resolve-Path -LiteralPath $GodotPath).Path
    New-Item -ItemType Directory -Path $logRoot -Force | Out-Null
    Write-Host "Godot: $GodotPath"
    Write-Host 'Import can update generated caches and asset metadata; inspect git status afterward.'
    Invoke-GodotCheck 'import' @('--import')
    $scripts = @(Get-ChildItem -LiteralPath (Join-Path $repoRoot 'scripts') -Filter '*.gd' -Recurse -File)
    $scriptNumber = 0
    foreach ($gdScript in $scripts) {
        $scriptNumber++
        $resourcePath = 'res://' + [System.IO.Path]::GetRelativePath($repoRoot, $gdScript.FullName).Replace('\', '/')
        Invoke-GodotCheck "parse-$scriptNumber" @('--check-only', '--script', $resourcePath)
    }
    Invoke-GodotCheck 'startup' @('--quit-after', "$SmokeIterations")
    Write-Host "PASS: import, $($scripts.Count) script parse check(s), and startup for $SmokeIterations engine iterations."
    Write-Host 'Keyboard input, visual behavior, and game feel still require a human playtest.'
    exit 0
}
catch {
    Write-Error $_ -ErrorAction Continue
    exit 1
}
