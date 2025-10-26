#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Root = (Resolve-Path "$PSScriptRoot/..")
Set-Location $Root

Remove-Item -Recurse -Force -ErrorAction SilentlyContinue `.pytest_cache`, `.mypy_cache`, `ruff_cache`, `dist`, `build`, `.build`, `htmlcov`

Get-ChildItem -Path @('src', 'tests') -Recurse -Directory -Filter '__pycache__' | ForEach-Object {
    Remove-Item -Recurse -Force $_.FullName
}
