#!/usr/bin/env pwsh
# SPDX-License-Identifier: MPL-2.0
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
