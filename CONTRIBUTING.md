# Contributing to Cognition Lattice

Thank you for your interest in contributing! This guide outlines the ground rules for participating in the project.

## Getting Started

1. Clone the repository and run `scripts/bootstrap` to install toolchains, dependencies, and Git hooks.
2. Activate your virtual environment (`.venv`) if you created one during bootstrap.
3. Run `scripts/dev` for a local developer stack or `scripts/check` before submitting changes.

## Development Workflow

- Create feature branches from `main`.
- Follow [Conventional Commits](https://www.conventionalcommits.org/) for commit messages.
- Keep pull requests focused and include tests for new behavior.

## Quality Gates

- `scripts/lint` must pass (Ruff, Black, and isort).
- `scripts/typecheck` must pass (mypy).
- `scripts/test` and `scripts/e2e` should succeed locally.
- Update documentation (`README.md`, `docs/`, ADRs) when the architecture changes.

## Reporting Issues

Use GitHub issues for bug reports or feature requests. Include reproduction steps, expected vs. actual behavior, and environment details.

## Security

Email security disclosures to security@cognition-lattice.dev instead of filing a public issue.
