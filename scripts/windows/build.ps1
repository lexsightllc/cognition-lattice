#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Root = (Resolve-Path "$PSScriptRoot/..")
Set-Location $Root

param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Args
)

$pythonPath = Join-Path $Root 'src'
if ($env:PYTHONPATH) {
    $env:PYTHONPATH = "$pythonPath" + [System.IO.Path]::PathSeparator + $env:PYTHONPATH
} else {
    $env:PYTHONPATH = "$pythonPath"
}

python -m build --wheel --sdist @Args
