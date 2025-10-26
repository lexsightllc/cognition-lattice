<!-- SPDX-License-Identifier: MPL-2.0 -->
# Cognition Lattice

Cognition Lattice is a modular agent orchestration platform that fuses intent ingestion, validation, execution, and observability into a single cohesive runtime. Agents are dynamically discovered, validated against strict schemas, and coordinated through resilient messaging primitives so that new behaviors can be added safely without redeploying the core.

## Platform Capabilities

- **Dynamic Orchestration** – `AgentCore` hot-reloads agents from the package and fans work out through async meshes when manifests describe cooperative workflows.
- **Message-Driven Execution** – Brokers (Redis, Kafka, RabbitMQ, or in-memory) provide reliable queues for intents, responses, and heartbeats.
- **Observability & Safety** – Prometheus metrics, structured logging, and schema validation protect against regressions while security sandboxing keeps experimental code contained.
- **Extensible Memory & Models** – Pluggable memory stores and model registries allow agents to share context and load ML assets on demand.

## Repository Layout

```
├── CHANGELOG.md
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── Dockerfile
├── LICENSE
├── Makefile
├── README.md
├── assets/
├── ci/
├── configs/
│   ├── manifests/
│   └── schemas/
├── data/
├── docs/
│   ├── adr/
│   ├── api/
│   └── vision.md
├── examples/
├── infra/
│   └── migrations/
├── project.yaml
├── requirements.in
├── requirements.txt
├── scripts/
│   ├── *.sh
│   └── windows/*.ps1
├── sbom/
├── src/
│   └── cognition_lattice/
└── tests/
    ├── unit/
    ├── integration/
    └── e2e/
```

The Python package lives under `src/cognition_lattice`. Configuration files move to `configs/`, long-lived assets sit in `assets/` or `data/`, and infrastructure experiments belong in `infra/`.

## Developer Tasks

| Task | Command | Description |
| --- | --- | --- |
| Bootstrap toolchain | `scripts/bootstrap` | Create a virtualenv, install dependencies, and set up Git hooks. |
| Run dev stack | `scripts/dev [--build]` | Launch Docker services (agent core, gateway, Redis) with Docker Compose. |
| Lint | `scripts/lint [--fix]` | Execute Ruff, Black, and isort (optionally auto-fix with `--fix`). |
| Format | `scripts/fmt [--check]` | Apply or check canonical formatting across Python sources and tests. |
| Type check | `scripts/typecheck` | Run mypy with `src/` on the Python path. |
| Tests | `scripts/test` | Execute unit + integration suites. |
| End-to-end | `scripts/e2e` | Run user-behavior regression scenarios. |
| Coverage | `scripts/coverage` | Collect coverage with term summary and XML report. |
| Build artifacts | `scripts/build` | Produce Python wheels and source distribution via `python -m build`. |
| Package container | `scripts/package` | Build a Docker image (`IMAGE_NAME`/`IMAGE_TAG` configurable). |
| Security scan | `scripts/security-scan` | Run Bandit SAST and `pip-audit` for dependency CVEs. |
| SBOM | `scripts/sbom` | Emit a CycloneDX SBOM to `sbom/cognition-lattice-sbom.json`. |
| Docs | `scripts/gen-docs` | Generate API reference docs into `docs/api/` using pdoc. |
| Update deps | `scripts/update-deps` | Refresh pinned requirements with `pip-compile` (requires `pip-tools`). |
| Release | `scripts/release` | Run checks, build artifacts, generate SBOM, and tag `v$VERSION`. |
| Migrate | `scripts/migrate` | Run database migrations if an Alembic config is present. |
| Clean | `scripts/clean` | Remove build caches and Python bytecode. |
| Quality gate | `scripts/check` | Aggregate formatting, lint, type, test, coverage, and security scans. |

PowerShell mirrors for the entire toolbelt live under `scripts/windows/` so Windows developers have parity with the Bash shims.

## Getting Started

```bash
make bootstrap
source .venv/bin/activate
make check  # run the full quality gate
```

> **Note:** `scripts/bootstrap` installs commitlint via `npm` when available. Install Node.js (see `.tool-versions`) to enable commit message linting locally.

To run the local stack:

```bash
make dev ARGS="--build"
```

## Testing Strategy

- **Unit tests** (`tests/unit`) mirror package modules and use deterministic fixtures located in `tests/fixtures`.
- **Integration tests** (`tests/integration`) exercise messaging, metrics, and multi-agent workflows against test brokers.
- **E2E scenarios** (`tests/e2e`) simulate end-user behaviors with Given/When/Then annotations and real broker loops.

Each suite can be invoked individually via the scripts or `make` targets documented above.

## Configuration & Environment

Environment variables are documented in `.env.example`; never commit secrets. Configuration manifests and schemas live under `configs/` and are referenced by runtime modules through deterministic absolute paths. SBOMs, CI metadata, and CODEOWNERS enforce supply-chain safety.

## Documentation & Decisions

- Architectural decisions are recorded in `docs/adr/` (see ADR-0001 for the structure standardization).
- The long-term vision statement is captured in `docs/vision.md`.
- API documentation can be regenerated with `scripts/gen-docs`.

## Continuous Integration

GitHub Actions (`.github/workflows/ci.yml`) runs `make check`, caches Python dependencies, publishes coverage, and attaches SBOM artifacts. Conventional Commit messages are enforced via pre-commit hooks and CODEOWNERS gate sensitive paths.
## License

This project is licensed under the [Mozilla Public License 2.0](LICENSE). Any modifications made to MPL-covered files must be shared under the same license, while larger works that merely combine Cognition Lattice with other proprietary components may remain under their own terms.

For distribution packages, include the accompanying [NOTICE](NOTICE) file so that third-party attributions travel with the code.

## Credits

Cognition Lattice is maintained by Augusto 'Guto' Ochoa Ughini and the broader contributor community. Please review NOTICE for third-party acknowledgements and retain upstream attributions when redistributing.


---

*Symbiotic Intelligence Operating System — evolving autonomous agents for mission-critical workflows.*
