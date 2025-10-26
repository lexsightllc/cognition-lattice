#!/usr/bin/env pwsh
# SPDX-License-Identifier: MPL-2.0
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Root = (Resolve-Path "$PSScriptRoot/..")
$Venv = Join-Path $Root '.venv'
$Python = $env:PYTHON
if (-not $Python) { $Python = 'python' }

if (-not (Test-Path $Venv)) {
    Write-Host "[bootstrap] creating virtual environment at $Venv"
    & $Python -m venv $Venv
}

$Activate = Join-Path $Venv 'Scripts/Activate.ps1'
. $Activate

python -m pip install --upgrade pip
python -m pip install -r (Join-Path $Root 'requirements.txt')
python -m pip install pre-commit

if (Get-Command npm -ErrorAction SilentlyContinue) {
    Push-Location $Root
    npm install
    Pop-Location
} else {
    Write-Warning 'npm not found; skipping commitlint installation'
}

pre-commit install
pre-commit install --hook-type commit-msg

Write-Host "Bootstrap complete. Activate with: $Venv\Scripts\Activate.ps1"
