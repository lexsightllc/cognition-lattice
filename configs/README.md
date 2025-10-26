<!-- SPDX-License-Identifier: MPL-2.0 -->
# Configuration Directory

This folder contains declarative assets that describe Cognition Lattice deployments.

- `manifests/` holds agent workflow descriptors consumed by `AgentMesh`.
- `schemas/` contains JSON Schemas for inbound intents used by validation guards.

Additional configuration files should follow the same pattern: prefer JSON, YAML, or TOML formats, keep secrets out of version control, and document each file's ownership in `project.yaml`.
