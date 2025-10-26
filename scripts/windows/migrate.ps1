#!/usr/bin/env pwsh
# SPDX-License-Identifier: MPL-2.0
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Root = (Resolve-Path "$PSScriptRoot/..")
Set-Location $Root

if (Test-Path (Join-Path $Root 'alembic.ini')) {
    alembic upgrade head
} else {
    Write-Warning 'No database migrations configured. Place migration tooling under infra/migrations/.'
}
