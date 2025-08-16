# Section Synthesis Task

You are performing section synthesis for scientific report generation. Follow the guidelines in `config/targets.md` and `config/comments_synthesis.md`.

## Task Overview

Generate individual markdown sections for the scientific report based on repository analysis and academic standards.

## Input Configuration

Read the section specifications from `config/targets.md` which contains:

- Report format requirements and target audience
- Section structure and page length targets
- Academic formatting standards
- Novel contribution focus areas

## Synthesis Guidelines

Follow the writing and formatting requirements in `config/comments_synthesis.md`:

- Technical report/thesis format with relaxed tone  
- Proper markdown hierarchy and academic formatting
- Integration of source materials and code examples
- Cross-section consistency and unified terminology

## Section Generation Requirements

### Input Data Sources

- Repository analysis data from `results/sections/analysis.json`
- Asset manifest from `results/assets/manifest.json`
- Bibliography data from `results/sections/bibliography.json`
- Configuration from `config/` directory

### Section Specifications

**00-title-abstract.md** (~1 page)

- Title page with project metadata and abstract
- Keywords and definitions summary

**01-introduction.md** (~6 pages)

- Focus on critical background and literature review
- Extract definitions from existing config files and AGENTS.md
- Comparative overview: models, agentic agents, MAS, datasets, benchmarks
- Overview evaluation and project approach summary

**02-project-introduction.md** (~8 pages)

- Why, What, How framework
- Current state analysis
- Technology evaluation from sprint plans

**03-desired-state.md** (~8 pages)

- End goals and vision from sprint files, PRD.md, userstory.md
- Sources: Existing docs + literature review

**04-planning-solution.md** (~6 pages)

- Architecture (PlantUML diagrams)
- Technology Stack (sprint decisions)
- MAS Design, Models, Tools
- Dataset Integration Strategy
- Evaluation Framework Design

**05-implementation.md** (~12 pages)

- Core Framework Implementation
- Multi-Agent System & Tools
- Evaluation Pipeline & Metrics
- Integration & Testing Strategy
- Direct code examples from src/app/
- Architecture diagrams with academic formatting

**06-control-success.md** (~6 pages)

- Acceptance criteria from UserStory.md
- Success metrics and validation approaches

**07-results.md** (~10 pages)

- Sprint results + evaluation data
- Current status + future roadmap
- Sprint outcomes, gap analysis
- Concrete next steps from sprint plan

**08-summary-outlook.md** (~2 pages)

- Key contributions and novel approaches
- Future work and roadmap

**09-bibliography.md**

- Academic citations with proper formatting
- Title, link, author(s), date published, access date

**10-list-of-figures.md**

**11-list-of-tables.md**

## Output Requirements

Generate section files in `results/sections/` with:

- Proper academic formatting and structure
- Integration of figures and code examples
- Working cross-references and citations
- Page length targets as specified

## Quality Standards

- Technical accuracy and academic rigor
- Emphasis on novel contributions
- Proper integration of visual elements
- Ready for pandoc PDF conversion
