# Scientific Report Generator - Claude Code Agents

This project uses specialized subagents configured in `.claude/agents/` for scientific report generation tasks.

## Execution Instructions for Claude

### Phase 0: Repository Ingestion

Run `make repo_ingest` to pack the target repository (from `config/sources.md`)
with Repomix into `results/repo-context.xml` and build a Graphify knowledge graph
into `results/graph.json`. These are the inputs to Phase 1.

### Phase 1: Repository Analysis

Use the **repo-analyzer** subagent to extract technical architecture, implementation details, and documentation from the target code repository. This generates structured analysis data and asset inventory.

### Phase 2: Section Synthesis

Use the **section-synthesizer** subagent to generate academic report sections from the analysis data. This produces numbered markdown sections with YAML frontmatter ready for pandoc conversion.

### Phase 3: Content Validation

Use the **validator** subagent to ensure quality, accuracy, and academic compliance across all generated sections.

## Expected Pipeline Output

- `results/repo-context.xml` - Repomix bundle of the target repository
- `results/graph.json` - Graphify knowledge graph (optional)
- `results/sections/analysis.yaml` - Repository technical analysis
- `results/sections/00_frontmatter.md`, `00_title_abstract.tex`, `01_*.md` .. `08_*.md`, `references.bib` - Pandoc-ready report sections
- `results/validation-report.md` - Quality assessment with CHT scores
- `results/assets/` - Processed diagrams and documentation
- `results/report.pdf` - Final assembled scientific report

## Automation Features

Makefile orchestration available with `make analyze`, `make synthesize`, `make validate` for batch execution.

### Phase 4: PDF Assembly

Run `make pandoc_run` to assemble the validated sections into a publication-ready
PDF (`results/report.pdf`) via pandoc/XeLaTeX with IEEE citations. `make all` runs
Phase 0 through Phase 4 in order, producing comprehensive technical analysis,
structured sections, quality validation, and a final scientific report.
