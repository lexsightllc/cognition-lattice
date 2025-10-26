#!/usr/bin/env pwsh
# SPDX-License-Identifier: MPL-2.0
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Root = (Resolve-Path "$PSScriptRoot/..")
$ComposeFile = Join-Path $Root 'docker-compose.yml'

if (Get-Command 'docker' -ErrorAction SilentlyContinue) {
    if (docker compose version 2>$null) {
        docker compose -f $ComposeFile up $args
    } elseif (Get-Command 'docker-compose' -ErrorAction SilentlyContinue) {
        docker-compose -f $ComposeFile up $args
    } else {
        throw 'docker compose is not available.'
    }
} else {
    throw 'docker is not installed.'
}
