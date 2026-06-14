---
title: Contributing
description: Developer workflow, commands, testing, and the documentation authority map
category: contributing
version: 0.1.0
created: 2026-06-14
updated: 2026-06-14
---

Technical standards for humans and AI agents. For AI behavioral rules and pipeline
orchestration see `AGENTS.md`; for the project overview see the
[README](README.md); to run the pipeline see
[Running the Pipeline](docs/howtos/running-the-pipeline.md).

## Quick commands

| Command | Purpose |
|---------|---------|
| `make help` | List all recipes |
| `make all` | Full pipeline (ingest → analyze → synthesize → validate → PDF) |
| `make lint` | Markdown + shell lint |
| `make test` | Validate the `analysis.yaml` schema contract + agent-spec path conventions |

## Development environment

The pipeline needs Claude Code CLI (+ auth + API key), Make, Node/npx
(`repomix`, `markdownlint-cli2`), Python 3 / pipx (`check-jsonschema`), Docker
(PlantUML), and Pandoc/XeLaTeX. `graphify` is optional. Full setup and per-tool
detail: [Running the Pipeline](docs/howtos/running-the-pipeline.md).

## Testing

`make test` runs two read-only guards and is wired into CI:

- the `analysis.yaml` schema contract (`schema/analysis.schema.json`) against the
  fixtures under `tests/fixtures/` (valid must pass, invalid must be rejected);
- the agent-spec path conventions (`scripts/test/check-spec-paths.sh`).

Add a fixture under `tests/fixtures/valid/` or `tests/fixtures/invalid/` to cover a
new contract case. Keep shell scripts shellcheck-clean (`make lint_sh`).

## Documentation Hierarchy

Each domain has **one** authoritative document. Everything else links to it; no
information is duplicated. README is navigation only.

| Domain | Authoritative source | Authority |
|--------|----------------------|-----------|
| Requirements & user goals | [docs/UserStory.md](docs/UserStory.md) | PRIMARY |
| Technical design, pipeline & report model | [docs/architecture.md](docs/architecture.md) | AUTHORITY |
| How to run the pipeline | [docs/howtos/running-the-pipeline.md](docs/howtos/running-the-pipeline.md) | AUTHORITY |
| Roadmap & backlog | [docs/roadmap.md](docs/roadmap.md) | AUTHORITY |
| AI orchestration & governance | `AGENTS.md` (+ `.claude/rules/`, `.claude/agents/`) | AUTHORITY |
| Producer/consumer data contract | `schema/analysis.schema.json` | AUTHORITY (machine) |
| Configuration inputs | [config/README.md](config/README.md) | AUTHORITY |
| Contributor workflow & standards | `CONTRIBUTING.md` (this file) | AUTHORITY |
| Version history | [CHANGELOG.md](CHANGELOG.md) | AUTHORITY |

Anti-redundancy rules:

1. **Single source of truth** — each fact lives in exactly one authoritative document.
2. **Reference, don't duplicate** — other documents link to it; they never copy it.
3. **Update at the source** — when a fact changes, update the authoritative document
   and remove any copies that have drifted.

## Commit & PR workflow

- **Conventional Commits** — `type(scope): subject` (see `.gitmessage`; enable with
  `git config commit.template .gitmessage`).
- **Branch → topical commits → PR** — one concern per commit; never push to `main`.
- **Squash-only merges** — `main` accepts squash merges only, with a hand-written
  subject/body.
- **Signed commits required** — `main` enforces a signed-commit ruleset; merges land
  a GitHub-signed squash commit.
- **Green CI gate** — gitleaks, `make lint_sh`, `make test`, the Makefile dry-run,
  markdown + link lint, and CodeFactor must pass before merge.

## Pre-commit checklist

- [ ] `make lint` and `make test` pass.
- [ ] New facts went to their authoritative document (no duplication).
- [ ] `CHANGELOG.md` `[Unreleased]` updated for any notable change.
- [ ] Commit message follows Conventional Commits.
