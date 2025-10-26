#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Root = (Resolve-Path "$PSScriptRoot/..")
Set-Location $Root

$env:PYTHONPATH = "$Root/src;$env:PYTHONPATH"

mypy src tests
