# SPDX-License-Identifier: MPL-2.0
SHELL := /bin/bash
ROOT_DIR := $(shell pwd)

.PHONY: bootstrap dev lint fmt typecheck test e2e coverage build package release update-deps security-scan sbom gen-docs migrate clean check

bootstrap:
	./scripts/bootstrap

dev:
	./scripts/dev

lint:
	./scripts/lint $(ARGS)

fmt:
	./scripts/fmt $(ARGS)

typecheck:
	./scripts/typecheck

test:
	./scripts/test $(ARGS)

e2e:
	./scripts/e2e $(ARGS)

coverage:
	./scripts/coverage $(ARGS)

build:
	./scripts/build $(ARGS)

package:
	./scripts/package $(ARGS)

release:
	./scripts/release

update-deps:
	./scripts/update-deps

security-scan:
	./scripts/security-scan

sbom:
	./scripts/sbom

gen-docs:
	./scripts/gen-docs

migrate:
	./scripts/migrate

clean:
	./scripts/clean

check:
	./scripts/check
