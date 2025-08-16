<!-- markdownlint-disable MD033 no-inline-html -->
# Agentic Scientific Report Generator

> Stop Guessing. Start Documenting. Transform Code Into human-readable Knowledge. - Automated framework for generating comprehensive scientific reports from code repositories using AI-driven analysis and academic writing standards.

## Purpose

Transform any GitHub repository into a structured academic report following scientific publication standards. The system extracts technical architecture, implementation details, and novel contributions to produce publication-ready documentation.

## Usage

### Configuration

Edit the configuration files in `config/`:

1. **`sources.md`** - Specify your target GitHub repository
2. **`targets.md`** - Define report format and academic requirements  
3. **`comments_analysis.md`** - Set analysis constraints and priorities
4. **`comments_synthesis.md`** - Configure writing style and formatting

**For detailed configuration instructions, examples, and templates, see [`config/README.md`](config/README.md)**

### Execution Methods

| Method | Command | Description | Use Case |
|--------|---------|-------------|----------|
| **Automated complete Pipeline** | `make all` | Full 3-phase pipeline with dependencies | Recommended for most users |
| **Agentic non-interactive Workflow** | `claude -p "Read and execute the workflow described in AGENTS.md"` | Claude orchestrates sub-agents | Advanced workflow with error handling |
| **Individual Phases** | `make analyze && make synthesize && make validate` | Run specific phases independently | Resume from failure or selective processing |
| **Manual Tasks** | `cat .claude/agents/repo-analyzer.md \| claude -p "execute"`<br>`cat .claude/agents/section-synthesizer.md \| claude -p "execute"`<br>`cat .claude/agents/validator.md \| claude -p "execute"` | Direct agent execution | Debugging or custom workflows |
| **Setup & Utilities** | `make create_struct && make clean_struct && make setup_claude_code`<br>`make setup_plantuml && make setup_pdf_converter` | Environment preparation | Initial setup and maintenance |

**Prerequisites for all methods:**

- Repository URL configured in `config/sources.md`
- Claude Code CLI installed (`make setup_claude_code`)
- Output directories exist (`make create_struct`)

#### Method Comparison

**Automated complete Pipeline (`make all`):**

- Dependency management and sequential execution
- Automatic error handling and resume capability
- Progress tracking and status updates
- Best for: Production use and reliable automation

**Agentic non-interactive Workflow (`claude -p ...`):**

- Intelligent sub-agent coordination
- Dynamic error recovery and adaptation
- Context-aware decision making
- Best for: Complex repositories requiring adaptive analysis

**Individual Phases (`make analyze/synthesize/validate`):**

- Granular control and selective processing
- Easy debugging and development iteration
- Resource optimization for partial runs
- Best for: Development, testing, and troubleshooting

## Automated Features

- **Repository Analysis**: Automated extraction of architecture, dependencies, and documentation
- **Section Generation**: AI-driven creation of 9 structured academic sections
- **Asset Processing**: PlantUML diagram conversion and image optimization
- **Citation Management**: Automated bibliography generation and formatting
- **Quality Validation**: Cross-section consistency and academic standard verification
- **Progress Tracking**: Real-time status updates during pipeline execution

## Expected Outcomes

The system generates comprehensive scientific documentation with multiple deliverable formats:

### Primary Deliverables

**Academic Report Sections**  

- **Title & Abstract** - Project overview with novel contributions summary
- **Introduction** - Background, literature review, and comparative analysis  
- **Project Introduction** - Current state and technical context
- **Desired State** - Goals, vision, and success criteria
- **Planning & Solution** - Architecture, technology stack, and design decisions
- **Implementation** - Core functionality, algorithms, and code examples
- **Control of Success** - Acceptance criteria and validation metrics
- **Results** - Outcomes, evaluation data, and gap analysis
- **Summary & Outlook** - Conclusions and future roadmap
- **Bibliography** - Academic citations and technical references

**Technical Analysis**  

- Repository architecture mapping and pattern identification
- Technology stack assessment and dependency analysis
- Novel algorithm and implementation discovery
- Code quality and testing strategy evaluation

**Supporting Materials**  

- Optimized PlantUML diagrams and technical figures
- Academic citation database (BibTeX format)
- Asset manifest for figure and table references
- Quality validation reports with recommendations

### Output Formats

**Publication-Ready Documents:**  

- **Markdown Sections**: Individual files with YAML frontmatter
- **PDF Generation**: Professional scientific report layout via pandoc
- **Academic Standards**: IEEE/ACM formatting compliance
- **Asset Integration**: High-resolution diagrams and figures

**Business Value:**

- **Knowledge Transfer**: Transform tribal knowledge into structured documentation
- **Academic Publication**: Ready for conference and journal submission
- **Technical Documentation**: Comprehensive architecture and implementation guides
- **Research Foundation**: Structured analysis for further academic work

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
- [ ] Use Github API
- [ ] Optional asset-processor and bibliography-curator agents
