# Scientific Report Generator - Claude Code Agents

This project uses specialized subagents configured in `.claude/agents/` for scientific report generation tasks.

## Execution Instructions for Claude

### Phase 1: Repository Analysis

Use the **repo-analyzer** subagent to extract technical architecture, implementation details, and documentation from the target code repository. This generates structured analysis data and asset inventory.

### Phase 2: Section Synthesis

Use the **section-synthesizer** subagent to generate academic report sections from the analysis data. This produces numbered markdown sections with YAML frontmatter ready for pandoc conversion.

### Phase 3: Content Validation

Use the **validator** subagent to ensure quality, accuracy, and academic compliance across all generated sections.

## Expected Pipeline Output

- `results/sections/analysis.yaml` - Repository technical analysis
- `results/sections/NN-section-name.md` - Academic report sections  
- `results/validation-report.md` - Quality assessment
- `results/assets/` - Processed diagrams and documentation

## Automation Features

Makefile orchestration available with `make analyze`, `make synthesize`, `make validate` for batch execution.

### Phase 4: Pipeline Summary Generation

The system produces publication-ready academic reports with comprehensive technical analysis, structured sections, and quality validation suitable for scientific documentation and knowledge transfer.
