#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Root = (Resolve-Path "$PSScriptRoot/..")
Set-Location $Root

if (-not (Get-Command pip-compile -ErrorAction SilentlyContinue)) {
    Write-Error "pip-compile is required. Install it with 'python -m pip install pip-tools'."
    exit 1
}

pip-compile --resolver=backtracking --upgrade --output-file requirements.txt requirements.in
