#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Root = (Resolve-Path "$PSScriptRoot/..")
Set-Location $Root

$OutputDir = Join-Path $Root 'docs/api'
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

$pythonPath = Join-Path $Root 'src'
if ($env:PYTHONPATH) {
    $env:PYTHONPATH = "$pythonPath" + [System.IO.Path]::PathSeparator + $env:PYTHONPATH
} else {
    $env:PYTHONPATH = "$pythonPath"
}

python -m pdoc --html --output-dir $OutputDir cognition_lattice
