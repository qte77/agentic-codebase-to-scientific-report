# Scientific Report Generator - Claude Code Task Agents

This document describes the Claude Code task agents for generating scientific reports from GitHub repositories.

## System Architecture

The Scientific Report Generator follows the agentic-market-research-and-gtm pattern using:

- **Makefile orchestration** for pipeline execution
- **Claude Code CLI** for individual task execution
- **Configuration-driven approach** via markdown files
- **Sequential task execution** with file-based data flow

## Execution Pipeline

```bash
Makefile → Claude Code Tasks → Output Files
    ↓            ↓                ↓
make all → claude task --file → results/
```

### Pipeline Flow

1. **make analyze** → runs `repo-analyzer.md` → generates analysis data
2. **make synthesize** → runs `section-synthesizer.md` → generates section files  
3. **make validate** → runs `validator.md` → generates validation report

## Claude Code Task Agents

### Repository Analyzer (`repo-analyzer.md`)

**Execution:** `claude task --agent general-purpose --file .claude/agents/repo-analyzer.md`

**Input:**

- Repository URL from `config/sources.md`
- Analysis guidelines from `config/comments_analysis.md`

**Output:**

- `results/sections/analysis.json` - Repository structure and technical data
- `results/assets/` - Extracted diagrams and documentation

**Purpose:** Extract comprehensive technical information from target GitHub repository

### Section Synthesizer (`section-synthesizer.md`)

**Execution:** `claude task --agent general-purpose --file .claude/agents/section-synthesizer.md`

**Input:**

- Analysis data from previous step
- Section specifications from `config/targets.md`
- Writing guidelines from `config/comments_synthesis.md`

**Output:**

- `results/sections/00-title-abstract.md` through `results/sections/09-bibliography.md`
- 9 individual markdown sections ready for pandoc conversion

**Purpose:** Generate academic report sections following scientific writing standards

### Content Validator (`validator.md`)

**Execution:** `claude task --agent general-purpose --file .claude/agents/validator.md`

**Input:**

- All section files from synthesis step
- Original analysis data for cross-validation

**Output:**

- `results/validation-report.md` - Quality assessment and recommendations

**Purpose:** Ensure technical accuracy, academic standards, and cross-section consistency

### Asset Processor (`asset-processor.md`)

**Execution:** `claude task --agent general-purpose --file .claude/agents/asset-processor.md`

**Input:**

- PlantUML source files from repository
- Image assets requiring optimization

**Output:**

- Optimized images in `results/assets/images/`
- Asset manifest for section references

**Purpose:** Process diagrams and images for academic publication standards

### Bibliography Curator (`bibliography-curator.md`)

**Execution:** `claude task --agent general-purpose --file .claude/agents/bibliography-curator.md`

**Input:**

- Repository documentation and references
- Academic citation requirements

**Output:**

- `results/sections/09-bibliography.md` - Formatted bibliography
- `bibliography.bib` - BibTeX file for pandoc

**Purpose:** Extract and format academic citations and references

## Configuration System

### Input Configuration (`config/`)

- **sources.md** - Target repository specifications
- **targets.md** - Report format and output requirements  
- **comments_analysis.md** - Repository analysis constraints
- **comments_synthesis.md** - Section writing guidelines

### Task Execution Pattern

Each Claude Code task:

1. Reads configuration from `config/` directory
2. Processes input data or files
3. Generates structured output in `results/` directory
4. Can be run independently or via Makefile

## Execution Methods

The system supports three execution methods following the agentic-market-research-and-gtm pattern:

### 1. Automated Pipeline (Recommended)

```bash
make all
```

Complete three-phase pipeline execution via Makefile orchestration.

### 2. Make-based Execution

```bash
# Individual phases
make analyze      # Repository analysis
make synthesize   # Section generation  
make validate     # Content validation

# Utilities
make setup_claude_code  # Install Claude Code CLI
make create_struct      # Setup directory structure
make clean_struct       # Clean outputs
```

### 3. Manual Claude CLI Execution

```bash
# Direct task execution
claude task --agent general-purpose --file .claude/agents/repo-analyzer.md
claude task --agent general-purpose --file .claude/agents/section-synthesizer.md
claude task --agent general-purpose --file .claude/agents/validator.md
claude task --agent general-purpose --file .claude/agents/asset-processor.md
claude task --agent general-purpose --file .claude/agents/bibliography-curator.md
```

## Output Structure

```bash
results/YYYY-MM-DD-title/
├── sections/
│   ├── 00-title-abstract.md
│   ├── 01-introduction.md
│   ├── ...
│   └── 09-bibliography.md
├── assets/
│   ├── images/
│   └── diagrams/
└── data/
    ├── analysis.json
    └── validation-report.md
```

## Integration with External Tools

- **Claude Code CLI** - Task execution engine
- **Pandoc** - Convert markdown sections to PDF
- **PlantUML** - Generate architecture diagrams  
- **Make** - Pipeline orchestration and dependency management
