#!/usr/bin/env pwsh
# SPDX-License-Identifier: MPL-2.0
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Args
)

$ImageName = $env:IMAGE_NAME
if (-not $ImageName) { $ImageName = 'cognition-lattice' }
$ImageTag = $env:IMAGE_TAG
if (-not $ImageTag) { $ImageTag = 'latest' }

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Error 'docker is required to build the container image'
    exit 1
}

docker build -t "$ImageName`:$ImageTag" @Args .
