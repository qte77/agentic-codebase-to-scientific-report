---
title: Roadmap
description: Delivered milestones, planned work, and deferred items
category: roadmap
version: 0.1.0
created: 2026-06-14
updated: 2026-06-14
---

Architecture decisions live in [Architecture](architecture.md); this page tracks
status and backlog.

## Status

| Item | Status | Notes |
|---|---|---|
| End-to-end pipeline (ingest → analyze → synthesize → validate → PDF) | Done | `make all` |
| Repo ingestion (Repomix + Graphify) | Done | Graphify path optional |
| LaTeX/PDF assembly (XeLaTeX via pandoc) | Done | IEEE citations |
| `analysis.yaml` schema contract + `make test` | Done | producer/consumer interface |
| Security baseline (pinned actions, gitleaks, signed commits) | Done | |
| qte77-family doc structure (LICENSE, docs/, CONTRIBUTING, CHANGELOG) | In progress | this effort |
| First real `make all` on a live target | Pending | needs Claude auth + API key |
| GitHub API access for remote repos | Planned | currently local/cloned paths |
| Optional `asset-processor` / `bibliography-curator` agents | Planned | in `.claude/agents/TODO/` |
| Live MkDocs site (GitHub Pages deploy) | Deferred | needs Pages enabled |

## Backlog

- **First end-to-end run** on the reference target, including the Graphify path
  (not only `SKIP_GRAPHIFY=1`). Requires Claude CLI auth + an API key (spends
  tokens); never run headless.
- **Promote the TODO agents** (`asset-processor`, `bibliography-curator`): their
  output paths are already aligned to the pipeline conventions, but they are not
  yet wired into `make all`.
- **CodeQL** workflow analysis for the GitHub Actions workflows.
- **Live documentation site**: add the MkDocs Pages deploy workflow and enable
  GitHub Pages.
