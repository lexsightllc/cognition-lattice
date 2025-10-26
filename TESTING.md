# Testing Guide

The Cognition Lattice test suite is organized to ensure fast feedback while still validating complex runtime behaviors.

## Test Layers

1. **Unit** (`tests/unit/`) – Validate individual modules, agent contracts, sandbox enforcement, and resource management logic with deterministic fixtures.
2. **Integration** (`tests/integration/`) – Exercise broker recovery, gateway APIs, metrics exposure, and workflow harmonizers against in-memory transports.
3. **End-to-End** (`tests/e2e/`) – Simulate user-centric journeys (Given/When/Then) that traverse gateways, brokers, and agents end-to-end.

Fixtures for orchestrated scenarios live under `tests/fixtures/` and should be shared instead of re-creating ad hoc data.

## Running the Suite

Install dependencies and bootstrap tooling:

```bash
scripts/bootstrap
source .venv/bin/activate
```

Run individual suites:

```bash
scripts/test          # unit + integration
scripts/e2e           # end-to-end
scripts/coverage      # coverage with XML + terminal report
```

CI mirrors these commands via `scripts/check`, so keeping the script outputs green guarantees a clean merge.

## Production Validation

For staging or load testing:

1. Launch the stack with `scripts/dev --build` (or the equivalent `docker compose` command).
2. Drive traffic using k6, Locust, or Playwright against the FastAPI gateway while generating intents.
3. Inject chaos (restart broker, delete an agent module) and verify that AgentCore hot-reloads and resumes processing.
4. Capture Prometheus metrics (`/metrics` endpoint) and structured logs to confirm SLOs.

Document any additional scenarios in `docs/adr/` or `tests/fixtures/` so they become repeatable.
