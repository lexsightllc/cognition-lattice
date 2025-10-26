#!/usr/bin/env pwsh
# SPDX-License-Identifier: MPL-2.0
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Root = (Resolve-Path "$PSScriptRoot/..")
Set-Location $Root

$OutputDir = Join-Path $Root 'sbom'
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

cyclonedx-bom --requirements requirements.txt --output (Join-Path $OutputDir 'cognition-lattice-sbom.json') --format json
