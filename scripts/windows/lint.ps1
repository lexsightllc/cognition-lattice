#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Root = (Resolve-Path "$PSScriptRoot/..")
Set-Location $Root

param(
    [switch]$Fix
)

$targets = @('src', 'tests', 'examples')
if ($Fix) {
    ruff check --fix $targets
} else {
    ruff check $targets
}
black --check $targets
isort --check-only $targets
