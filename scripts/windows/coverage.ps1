#!/usr/bin/env pwsh
# SPDX-License-Identifier: MPL-2.0
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Root = (Resolve-Path "$PSScriptRoot/..")
Set-Location $Root

$env:PYTHONPATH = "$Root/src;$env:PYTHONPATH"

pytest --cov=cognition_lattice --cov-report=term-missing --cov-report=xml $args
