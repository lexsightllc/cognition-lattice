#!/usr/bin/env pwsh
# SPDX-License-Identifier: MPL-2.0
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Root = (Resolve-Path "$PSScriptRoot/..")
Set-Location $Root

bandit -r src

if ($env:PIP_AUDIT_SKIP -eq '1') {
    Write-Warning 'Skipping pip-audit because PIP_AUDIT_SKIP=1'
} else {
    pip-audit -r requirements.txt $args
}
