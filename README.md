# Agentic Scientific Report Generator

> Stop guessing, start documenting — turn a code repository into a structured,
> publication-ready scientific report using Claude subagents and academic writing
> standards.

## Purpose

Point the pipeline at a repository and get a structured, citation-backed report
draft: architecture, implementation, evaluation, and outlook, assembled to a
consistent academic format and quality-scored before assembly.

## Documentation

- **Users / researchers** — [What it produces and who it is for](docs/UserStory.md)
  · [Run the pipeline](docs/howtos/running-the-pipeline.md)
- **Developers** — [Contributing](CONTRIBUTING.md) ·
  [Architecture](docs/architecture.md) · [Roadmap](docs/roadmap.md) ·
  [Changelog](CHANGELOG.md)
- **AI agents** — [AGENTS.md](AGENTS.md) (operating contract) ·
  [Learnings](AGENT_LEARNINGS.md) · [Requests](AGENT_REQUESTS.md)

## Quick start

1. Configure your target repository and report references in `config/` — see
   [config/README.md](config/README.md).
2. Install the toolchain and run the pipeline:

```bash
make setup_claude_code     # Install the Claude Code CLI
make create_struct         # Initialize the results/ directories
make all                   # ingest → analyze → synthesize → validate → PDF
```

`make all` needs Claude CLI auth + an API key and spends tokens. Full prerequisites
and execution methods are in
[Running the Pipeline](docs/howtos/running-the-pipeline.md).

## Project structure

```bash
├── .claude/agents/          # Subagent definitions (repo-analyzer, section-synthesizer, validator)
├── config/                  # Pipeline inputs (sources, targets, analysis/synthesis overrides)
├── docs/                    # MkDocs reference site (architecture, user story, roadmap, how-tos)
├── schema/                  # Canonical analysis.yaml JSON Schema contract
├── scripts/
│   ├── writeup/             # Reused pandoc/PlantUML PDF tooling
│   └── test/                # Schema + agent-spec path validation (make test)
├── tests/fixtures/          # valid/ + invalid/ schema fixtures (TDD)
├── results/                 # Generated outputs (gitignored): analysis.yaml, sections, report.pdf
├── AGENTS.md                # Agent operating contract
├── CONTRIBUTING.md          # Developer workflow + documentation hierarchy
├── CHANGELOG.md             # Version history
├── mkdocs.yaml              # Documentation site config
└── Makefile                 # Pipeline automation
```

## Development

See [CONTRIBUTING.md](CONTRIBUTING.md) for the full workflow. Common checks:

```bash
make lint                  # Markdown + shell lint
make test                  # Validate the analysis.yaml schema contract + agent-spec paths
```

## License

[Apache-2.0](LICENSE).
