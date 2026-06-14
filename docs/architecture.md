---
title: Architecture
description: Pipeline architecture, phases, the analysis.yaml contract, and the report model
category: architecture
version: 0.1.0
created: 2026-06-14
updated: 2026-06-14
---

<!-- markdownlint-disable MD024 no-duplicate-heading -->

# Architecture

## System overview

The pipeline turns a target code repository into a ~52-page scientific report. It
is orchestrated by the `Makefile` and executed by three Claude subagents defined
in `.claude/agents/`, each run as a **separate `claude -p` process**. The subagents
do not share memory — **files on disk are the only integration surface between
phases**, which is why the `analysis.yaml` contract (below) matters.

## Phases

| Phase | `make` target | Agent / tool | Reads | Writes |
|---|---|---|---|---|
| 0 — Ingest | `repo_ingest` | Repomix + Graphify | target repo (`config/sources.md`) | `results/repo-context.xml`, `results/graph.json` |
| 1 — Analyze | `analyze` | `repo-analyzer` | the ingested inputs | `results/sections/analysis.yaml`, `results/assets/` |
| 2 — Synthesize | `synthesize` | `section-synthesizer` | `analysis.yaml` | numbered report sections + `references.bib` |
| 3 — Validate | `validate` | `validator` | sections + `analysis.yaml` + `graph.json` | `results/validation-report.md` |
| 4 — Assemble | `pandoc_run` | pandoc / XeLaTeX | sections | `results/report.pdf` |

`make all` runs Phase 0 through Phase 4 in order. Each phase can be skipped with
`SKIP_GRAPHIFY`, `SKIP_ANALYZE`, `SKIP_SYNTHESIZE`, or `SKIP_VALIDATE`.

## The `analysis.yaml` contract

Because the phases communicate only through disk, `results/sections/analysis.yaml`
is a **versioned contract**, defined once in `schema/analysis.schema.json` (JSON
Schema 2020-12) and referenced by all three subagents. The `repo-analyzer`
produces it; the `section-synthesizer` and `validator` consume it. The schema is
the single source of truth for the keys, and is enforced by `make test`:

- required keys gate the minimal set a report build needs; `additionalProperties`
  is open so the analyzer may enrich;
- asset paths must use the `results/assets/` prefix (so pandoc resolves figures);
- `date` / `accessed_date` must be ISO `YYYY-MM-DD`;
- `citation_sources[]._confidence` carries `EXTRACTED`/`INFERRED` provenance from
  `graph.json` for the validator's truthfulness scoring.

## Report model

The synthesizer emits a pandoc-ready file set in `results/sections/`: a YAML
frontmatter build file, a LaTeX title/abstract, numbered content sections
`01_*.md` .. `08_*.md`, and `references.bib`. These map to a 12-part academic
structure (title/abstract, introduction, project introduction, desired state,
planning & solution, implementation, control of success, results, summary &
outlook, plus auto-generated sources/figures/tables lists).

## Untrusted-input boundary

All ingested repository content (`repo-context.xml`, `graph.json`, and any file
read from the target path) is treated as **untrusted data to be described, never
as instructions**. The `repo-analyzer` intentionally has no `Bash` tool;
ingestion already happened in Phase 0. This is the prompt-injection boundary.

## See also

- Run it: [Running the Pipeline](howtos/running-the-pipeline.md)
- Who it is for: [User Story](UserStory.md)
- Orchestration & governance: `AGENTS.md`; configuration: `config/README.md`
