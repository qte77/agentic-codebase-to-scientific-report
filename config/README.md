<!-- markdownlint-disable MD024 no-duplicate-heading -->
# Configuration Guide

This directory contains configuration files for the Scientific Report Generator. Each file serves a specific purpose in customizing the report generation process.

## File Overview

- **sources.md** - Repository sources to analyze
- **targets.md** - Reference documents for formatting and style
- **comments_analysis.md** - User overrides for repository analysis
- **comments_synthesis.md** - User overrides for section synthesis

## sources.md Configuration

This file configures which repositories to analyze for scientific report generation.

### How to Use

Add the target repository URL and configuration details. The repo-analyzer will use this to determine what to analyze.

### Format

```markdown
## Repository Source

**Primary Target:**

Repository: https://github.com/user/repository-name
Description: Brief description of the project
Branch: main
Key Features: 

- Feature 1
- Feature 2
- Feature 3

## Additional Repositories (Optional)

**Secondary Sources:**

Repository: https://github.com/organization/related-project
Description: Related project for comparative analysis
Branch: develop

Repository: ./local-project-path
Description: Local project directory
Branch: main
```

### Configuration Instructions

1. Replace the example URLs with actual repository links
2. Use full GitHub URLs for remote repositories
3. Use relative paths (./path) for local repositories
4. Include brief descriptions to help guide analysis focus
5. Specify branch if not using default (main/master)

## targets.md Configuration

This file contains links to example reports, papers, or documents that should be used as formatting and style references.

### How to Use

Add links to reports or documents that should serve as templates for formatting, structure, and style. The section-synthesizer will use these as reference examples.

### Format

```markdown
## Target Report Examples

### Academic Papers

- https://arxiv.org/pdf/2301.12345.pdf - Example technical report structure
- https://example-university.edu/papers/sample-thesis.pdf - Academic formatting reference

### Technical Documentation

- https://github.com/organization/repo/blob/main/docs/technical-report.md - Markdown formatting example
- ./examples/sample-technical-report.pdf - Local reference document

### Industry Reports

- https://company.com/whitepapers/architecture-report.pdf - Industry standard formatting
- ./references/evaluation-framework-paper.pdf - Evaluation methodology example

## Style References

### Citation Format Examples

- https://ieee-style-guide.example.com - IEEE citation standards
- ./references/apa-style-examples.pdf - APA formatting reference

### Figure and Table Examples

- https://example.com/academic-figures-guide.pdf - Academic figure formatting
- ./examples/table-formatting-examples.md - Table style reference
```

### Usage Instructions

1. Add URLs or local file paths that represent the desired output quality and format
2. Include brief descriptions of what aspect each reference demonstrates
3. Use relative paths (./path/file.pdf) for local files in the project
4. Use absolute URLs for remote references

**Note:** Currently the targets.md file has these examples in HTML comments. Move them to the main content area when configuring.

## comments_analysis.md Configuration

This file allows users to provide additional analysis guidelines that override the default settings in the repo-analyzer agent.

### How to Use

Add specific requirements or modifications here that should override the default analysis behavior. These will be applied with highest priority during repository analysis.

### Example User Overrides

**Current examples in comments_analysis.md (move these to main content):**

```markdown
## Custom Analysis Focus

- Focus heavily on security architecture patterns
- Prioritize performance optimization techniques
- Emphasize scalability and deployment strategies
- Include detailed API design analysis

## Specific Technical Areas

- Deep dive into machine learning model architectures
- Analyze data pipeline and ETL processes
- Focus on microservices communication patterns
- Examine testing and CI/CD implementation

## Academic Emphasis

- Prioritize research contributions over implementation details
- Focus on experimental validation and results
- Emphasize theoretical foundations and related work
- Include detailed methodology descriptions

## Repository-Specific Instructions

- Ignore deprecated modules in /legacy directory
- Focus analysis on /core and /plugins directories
- Include analysis of configuration files in /config
- Prioritize documentation in /docs over inline comments
```

### Analysis Constraints Examples

```markdown
## Scope Limitations

- Exclude analysis of third-party libraries
- Focus only on main application logic
- Skip standard boilerplate and setup code
- Prioritize novel algorithmic implementations

## Content Extraction Priorities

- High priority: Custom algorithms and data structures
- Medium priority: Integration patterns and workflows
- Low priority: Standard framework usage and configurations
```

**Note:** The comments_analysis.md file currently contains these examples. When configuring, move the relevant examples to the main content area or leave the file empty to use defaults.

## comments_synthesis.md Configuration

This file allows users to provide additional synthesis guidelines that override the default settings in the section-synthesizer agent.

### How to Use

Add specific requirements or modifications here that should override the default synthesis behavior. These will be applied with highest priority during section generation.

### Example User Overrides

**Current examples in comments_synthesis.md (move these to main content):**

```markdown
## Custom Writing Style

- Use first person perspective for results sections
- Include more informal tone in implementation examples
- Emphasize practical applications over theoretical background

## Specific Content Requirements

- Focus heavily on security considerations in implementation
- Include detailed performance benchmarks in results
- Add troubleshooting sections to technical implementations

## Custom Citation Style

- Use IEEE citation format instead of APA
- Include DOI links for all academic references
- Add accessed dates for all web resources

## Section-Specific Overrides

### Introduction Modifications

- Reduce literature review to 2 pages maximum
- Focus on industry applications rather than academic research
- Include executive summary at the beginning

### Implementation Focus

- Prioritize code examples over architectural diagrams
- Include step-by-step deployment instructions
- Add configuration file examples

## Quality Requirements

- All technical claims must include supporting evidence
- Code examples must be tested and functional
- Figures must include detailed captions explaining relevance
```

**Note:** The comments_synthesis.md file currently contains these examples. When configuring, move the relevant examples to the main content area or leave the file empty to use defaults.

## Notes

- Leave any configuration file empty to use default settings from the respective agent
- All configuration files support markdown formatting
- The agents will prioritize user-provided configurations over defaults
- Configuration files are processed in the order: defaults → examples → user overrides
