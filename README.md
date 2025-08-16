# Agentic Scientific Report Generator

> Stop Guessing. Start Documenting. - Automated framework for generating comprehensive scientific reports from GitHub repositories using AI-driven analysis and academic writing standards.

## Purpose

Transform any GitHub repository into a structured academic report following scientific publication standards. The system extracts technical architecture, implementation details, and novel contributions to produce publication-ready documentation.

## Usage

### Configuration

Edit the configuration files in `config/`:

1. **`sources.md`** - Specify your target GitHub repository
2. **`targets.md`** - Define report format and academic requirements  
3. **`comments_analysis.md`** - Set analysis constraints and priorities
4. **`comments_synthesis.md`** - Configure writing style and formatting

### Execution Methods

#### Automated Pipeline (Recommended)

Uses Claude Code CLI for streamlined execution:

```bash
# Complete report generation
make all
```

#### Make-based Execution  

Granular control via Makefile targets:

```bash
make analyze      # Repository analysis phase
make synthesize   # Section generation phase
make validate     # Quality validation phase
```

#### Manual Execution

Direct Claude Code task execution:

```bash
claude task --agent general-purpose --file .claude/agents/repo-analyzer.md
claude task --agent general-purpose --file .claude/agents/section-synthesizer.md
claude task --agent general-purpose --file .claude/agents/validator.md
```

## Automated Features

- **Repository Analysis**: Automated extraction of architecture, dependencies, and documentation
- **Section Generation**: AI-driven creation of 9 structured academic sections
- **Asset Processing**: PlantUML diagram conversion and image optimization
- **Citation Management**: Automated bibliography generation and formatting
- **Quality Validation**: Cross-section consistency and academic standard verification
- **Progress Tracking**: Real-time status updates during pipeline execution

## Expected Outcomes

### Generated Report Sections

1. **Title & Abstract** - Project overview and contributions summary
2. **Introduction** - Background, literature review, and comparative analysis
3. **Project Introduction** - Current state and technical context
4. **Desired State** - Goals, vision, and success criteria
5. **Planning & Solution** - Architecture, technology stack, and design decisions
6. **Implementation** - Core functionality, algorithms, and code examples
7. **Control of Success** - Acceptance criteria and validation metrics
8. **Results** - Outcomes, evaluation data, and gap analysis
9. **Summary & Outlook** - Conclusions and future roadmap
10. **Bibliography** - Academic citations and technical references

### Output Format

- **Academic Standard**: IEEE/ACM publication formatting
- **Markdown Sections**: Individual files ready for pandoc conversion
- **PDF Generation**: Professional scientific report layout
- **Asset Integration**: Optimized diagrams and figures

## Project Structure

```bash
├── .claude/agents/          # Claude Code task definitions
│   ├── repo-analyzer.md     # Repository analysis task
│   ├── section-synthesizer.md  # Section generation task
│   └── validator.md         # Quality validation task
├── config/                  # Configuration files
│   ├── sources.md          # Target repository specification
│   ├── targets.md          # Report requirements
│   ├── comments_analysis.md    # Analysis guidelines
│   └── comments_synthesis.md   # Writing standards
├── results/                 # Generated outputs
│   ├── sections/           # Individual report sections
│   ├── assets/             # Processed diagrams and images
│   └── data/               # Analysis and validation data
├── AGENTS.md               # Task agent documentation
└── Makefile                # Pipeline automation
```

## Requirements

- **Claude Code CLI** (`npm install -gs @anthropic-ai/claude-code`)
- **Make** (build automation)
- **Pandoc** (markdown to PDF conversion)
- **PlantUML** (diagram generation)

## Setup

```bash
make setup_claude_code     # Install Claude Code CLI
make create_struct         # Initialize directory structure
```

## TODO

- [ ] LaTex option
