#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

param(
    [string]$Version
)

if (-not $Version) {
    if ($env:VERSION) {
        $Version = $env:VERSION
    } else {
        Write-Error 'VERSION environment variable or --Version parameter is required'
        exit 1
    }
}

$Root = (Resolve-Path "$PSScriptRoot/..")
Set-Location $Root

& "$PSScriptRoot/check.ps1"
& "$PSScriptRoot/build.ps1"
& "$PSScriptRoot/package.ps1"
& "$PSScriptRoot/sbom.ps1"

if (git rev-parse "v$Version" 2>$null) {
    Write-Error "Tag v$Version already exists"
    exit 1
}

git tag -a "v$Version" -m "Release $Version"
Write-Host "Created tag v$Version. Push with: git push --follow-tags"
