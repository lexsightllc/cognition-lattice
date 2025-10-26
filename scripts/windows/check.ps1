#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Root = (Resolve-Path "$PSScriptRoot/..")
Set-Location $Root

& "$PSScriptRoot/fmt.ps1" -Check
& "$PSScriptRoot/lint.ps1"
& "$PSScriptRoot/typecheck.ps1"
& "$PSScriptRoot/test.ps1"
& "$PSScriptRoot/coverage.ps1"
& "$PSScriptRoot/security-scan.ps1"
