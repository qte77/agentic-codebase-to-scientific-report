# Agentic Scientific Report Generator

> Stop guessing, start documenting — turn a code repository into a structured,
> publication-ready scientific report using Claude subagents and academic writing
> standards.

[![License: Apache-2.0](https://img.shields.io/badge/License-Apache--2.0-blue.svg)](LICENSE)
[![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-blue.svg)](CHANGELOG.md)
[![CI](https://github.com/qte77/agentic-codebase-to-scientific-report/actions/workflows/ci.yaml/badge.svg)](https://github.com/qte77/agentic-codebase-to-scientific-report/actions/workflows/ci.yaml)

## What

- Points at a code repository and produces a structured, citation-backed
  scientific report draft — architecture, implementation, evaluation, and outlook
- Runs as Claude Code subagents in phases: ingest → analyze → synthesize →
  validate → assemble
- `repo-analyzer` extracts technical facts into a schema-validated
  `analysis.yaml` contract
- `section-synthesizer` turns that contract into pandoc-ready report sections
  and a `references.bib`
- `validator` cross-checks every section against the analysis and repo graph,
  scoring completeness, helpfulness, and truthfulness before assembly
- Assembles to `results/report.pdf` via pandoc/XeLaTeX with IEEE citations

## How

1. Configure your target repository and report references in `config/` — see
   [config/README.md](config/README.md).
2. Install the toolchain and run the pipeline:

```bash
make setup_claude_code     # Install the Claude Code CLI
make create_struct         # Initialize the results/ directories
make all                   # ingest → analyze → synthesize → validate → PDF
```

`make all` needs Claude CLI auth + an API key and spends tokens. Full
prerequisites and execution methods:
[Running the Pipeline](docs/howtos/running-the-pipeline.md).

## Why

Turning a codebase into a publication-quality technical report is normally
hours of expert manual work — reading the repo, reconstructing its
architecture, and formatting everything to academic standards by hand. Generic
repo-summarizer tools produce a flat prose blob with no structure, citations,
or accuracy check. This pipeline is different: purpose-built Claude subagents
extract a schema-validated analysis, synthesize it into cited academic
sections, and cross-check every claim against the source before assembly. More
in [docs/UserStory.md](docs/UserStory.md).

## Refs

- [docs/UserStory.md](docs/UserStory.md) — problem statement and target users
- [docs/architecture.md](docs/architecture.md) — pipeline and report model
- [docs/howtos/running-the-pipeline.md](docs/howtos/running-the-pipeline.md) —
  full run guide
- [docs/roadmap.md](docs/roadmap.md) — what shipped and what's next
- [AGENTS.md](AGENTS.md) — agent operating contract
- [CONTRIBUTING.md](CONTRIBUTING.md) — dev workflow, testing, commit conventions
- [CHANGELOG.md](CHANGELOG.md) — version history

## License

[Apache-2.0](LICENSE).
