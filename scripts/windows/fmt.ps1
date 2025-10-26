#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Root = (Resolve-Path "$PSScriptRoot/..")
Set-Location $Root

param(
    [switch]$Check
)

$targets = @('src', 'tests', 'examples')
if ($Check) {
    ruff format --check $targets
    black --check $targets
    isort --check-only $targets
} else {
    ruff format $targets
    ruff check --fix $targets
    isort $targets
    black $targets
}
