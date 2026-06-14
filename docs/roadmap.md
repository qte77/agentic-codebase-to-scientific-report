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
| qte77-family doc structure (LICENSE, docs/, CONTRIBUTING, CHANGELOG) | Done | #16–#22 |
| First real `make all` on a live target | Pending | needs Claude auth + API key; [plan](plans/first-end-to-end-run.md) |
| GitHub API access for remote repos | Planned | currently local/cloned paths |
| Optional `asset-processor` / `bibliography-curator` agents | Planned | in `.claude/agents/TODO/` |
| MkDocs site | Dropping | keep docs/ GitHub-rendered; [plan](plans/drop-mkdocs.md) (#23) |

## Backlog

Detailed plans for open items live under `docs/plans/`.

- **First end-to-end run** on the reference target, including the Graphify path
  (not only `SKIP_GRAPHIFY=1`) — see
  [plans/first-end-to-end-run.md](plans/first-end-to-end-run.md).
- **Promote the TODO agents** (`asset-processor`, `bibliography-curator`): their
  output paths are aligned, but they are not yet wired into `make all`.
- **Drop MkDocs**, keeping `docs/` GitHub-rendered — see
  [plans/drop-mkdocs.md](plans/drop-mkdocs.md).
