---
title: Running the Pipeline
description: Prerequisites, execution methods, and phase controls for generating a report
category: usage-guide
version: 0.1.0
created: 2026-06-14
updated: 2026-06-14
---

# Running the Pipeline

See [Architecture](../architecture.md) for what each phase does.

## Prerequisites

| Tool | Used by | Notes |
|---|---|---|
| **Claude Code CLI** + auth + API key | Phases 1–3 | `make setup_claude_code`; `make all` spends tokens — never run headless |
| **Make** | orchestration | all targets |
| **Node / npx** | Phase 0, lint | `repomix` (ingest), `markdownlint-cli2` (lint) |
| **Python 3 / pipx** | `make test` | runs `check-jsonschema` for the schema contract |
| **Docker** | diagrams | PlantUML container (`make setup_plantuml`) |
| **Pandoc + XeLaTeX** | Phase 4 | `make setup_pdf_converter ARGS=pandoc` |
| **graphify** (optional) | Phase 0 | knowledge graph; skip with `SKIP_GRAPHIFY=1` |

## Setup

```bash
make setup_claude_code     # Install Claude Code CLI
make create_struct         # Initialize results/ directory structure
```

Then configure the target repository and report references in `config/` — see
`config/README.md`.

## Execution methods

| Method | Command | Use case |
|---|---|---|
| Full pipeline | `make all` | Recommended; ingest → analyze → synthesize → validate → PDF |
| Individual phases | `make analyze` / `make synthesize` / `make validate` | Resume or iterate on one phase |
| PDF only | `make pandoc_run` | Re-assemble after editing sections |
| Agentic workflow | `claude -p "Read and execute the workflow described in AGENTS.md"` | Adaptive orchestration with error handling |

## Phase controls

Skip phases with environment variables, e.g. a dry run without the knowledge graph:

```bash
make all SKIP_GRAPHIFY=1
```

`SKIP_ANALYZE`, `SKIP_SYNTHESIZE`, and `SKIP_VALIDATE` behave the same way.

## Verifying a change

```bash
make lint                  # Markdown + shell lint
make test                  # analysis.yaml schema contract + agent-spec path conventions
```
