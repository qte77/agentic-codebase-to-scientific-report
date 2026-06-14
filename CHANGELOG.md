<!-- markdownlint-disable MD024 no-duplicate-heading -->

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

**Types of changes**: `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, `Security`

## [Unreleased]

### Added

- Canonical `analysis.yaml` schema contract (`schema/analysis.schema.json`) with a
  TDD fixture suite and `make test`, enforcing the producer/consumer interface
  between the subagents (asset-path prefix, ISO dates, citation provenance enum).
- Agent-spec path-convention guard (`scripts/test/check-spec-paths.sh`) wired into
  `make test`.
- Apache-2.0 `LICENSE` and a Conventional Commits `.gitmessage` template.
- Documentation site under `docs/` (architecture, user story, roadmap, how-tos)
  with `mkdocs.yaml`.
- `CONTRIBUTING.md` with the Documentation Hierarchy authority map; `AGENT_LEARNINGS.md`
  and `AGENT_REQUESTS.md` (knowledge + escalation).
- CodeQL workflow analysing the GitHub Actions workflows, and issue templates.
- `docs/plans/` capturing plans for open tasks, referenced from the roadmap and issues.

### Changed

- Pinned Makefile runtime tool versions (`repomix`, PlantUML by digest,
  `check-jsonschema`).
- Pinned GitHub Actions to release SHAs; reduced default `GITHUB_TOKEN` scope.
- `analyze` no longer double-loads the ingested context into the prompt.
- Reduced `CLAUDE.md` to a clean `@AGENTS.md` shim.
- Restructured `AGENTS.md` into the agent governance + orchestration contract.
- Restructured `README.md` as an audience-segmented navigation hub, removing the
  duplicated execution/output sections (now owned by `docs/` and `AGENTS.md`).
- Consolidated Markdown linting to a single `.markdownlint.jsonc`, run recursively in
  CI so `make lint_md` matches CI.

### Removed

- Empty CSL stubs (`apa.csl`, `chicago-author-date.csl`); CI actionlint step.

### Fixed

- TODO-agent output paths aligned to `results/assets/` and
  `results/sections/references.bib`.
- Stale Makefile target references in `scripts/writeup/README.md`.

### Security

- Adopted the repo-baseline hardening: actions allowlist with
  `sha_pinning_required`, gitleaks secret scanning, secret-scanning push
  protection, and a signed-commit ruleset.
- CodeQL static analysis of the GitHub Actions workflows.
