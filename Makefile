# Agentic Codebase to Scientific Report Generator Pipeline

.SILENT:
.ONESHELL:
.PHONY: all analyze synthesize validate repo_ingest pandoc_run create_struct clean_struct setup_claude_code test lint lint_md lint_sh help
.DEFAULT_GOAL := help


# MARK: Config


# Target repo + branch are read from the Primary Target in config/sources.md.
TARGET_REPO := $(shell grep -m1 -E '^Repository:' config/sources.md | sed -E 's/^Repository:[[:space:]]*//')
TARGET_BRANCH := $(shell grep -m1 -E '^Branch:' config/sources.md | sed -E 's/^Branch:[[:space:]]*//')

# Repo ingestion tooling (override on the command line as needed).
GRAPHIFY ?= graphify
GRAPHIFY_BACKEND ?= claude
REPOMIX_VERSION ?= 1.14.1

# Schema-contract validation tool (Phase test); pinned, run via pipx.
CHECK_JSONSCHEMA_VERSION ?= 0.31.2

# PDF / pandoc conversion (scripts reused from Agents-eval).
PANDOC_SCRIPT := scripts/writeup/run-pandoc.sh
WRITEUP_DIR ?= results/sections
OUTPUT_PDF ?= results/report.pdf
CSL ?= scripts/writeup/citation-styles/ieee.csl

# PlantUML diagram rendering.
PLANTUML_SCRIPT := scripts/writeup/generate-plantuml-png.sh
# Pinned by digest (plantuml/plantuml:latest as of 2026-06-08); bump deliberately.
PLANTUML_CONTAINER := plantuml/plantuml@sha256:47870c1f76cfb3747bc7090bfe83013a4e3105b5a0bb1515e2baf5d3e2b3ee9d


# MARK: Report


all: analyze synthesize validate pandoc_run  ## Perform full scientific report generation process

analyze: repo_ingest  ## Analyze the target repository (Phase 1)
	if [ -n "$(SKIP_ANALYZE)" ]; then echo "SKIP_ANALYZE set; skipping analysis."; exit 0; fi
	echo "Starting Repository Analysis..."
	cat .claude/agents/repo-analyzer.md | claude -p "execute"
	echo "Repository Analysis completed."

synthesize: analyze  ## Synthesize sections into report (Phase 2)
	if [ -n "$(SKIP_SYNTHESIZE)" ]; then echo "SKIP_SYNTHESIZE set; skipping synthesis."; exit 0; fi
	echo "Starting Section Synthesis..."
	cat .claude/agents/section-synthesizer.md | claude -p "execute"
	echo "Section Synthesis completed."

validate: synthesize  ## Validate synthesized content against analysis (Phase 3)
	if [ -n "$(SKIP_VALIDATE)" ]; then echo "SKIP_VALIDATE set; skipping validation."; exit 0; fi
	echo "Starting Content Validation..."
	cat .claude/agents/validator.md | claude -p "execute"
	echo "Content Validation completed."

pandoc_run:  ## Convert validated sections to PDF via pandoc/XeLaTeX (Phase 4)
	echo "Converting sections in $(WRITEUP_DIR) to PDF ..."
	$(PANDOC_SCRIPT) "$(WRITEUP_DIR)/*.md" "$(OUTPUT_PDF)" "$(WRITEUP_DIR)/00_title_abstract.tex" "" "" "" "en-US" "true" "$(WRITEUP_DIR)/references.bib" "$(CSL)" "true" "true" "true"
	echo "PDF written to $(OUTPUT_PDF)."

repo_ingest: create_struct  ## Ingest target repo via Repomix + Graphify (Phase 0)
	echo "Ingesting target repo: $(TARGET_REPO) (branch $(TARGET_BRANCH)) ..."
	npx --yes repomix@$(REPOMIX_VERSION) "$(TARGET_REPO)" --compress --output results/repo-context.xml
	if [ -z "$(SKIP_GRAPHIFY)" ]; then
	    if command -v $(GRAPHIFY) >/dev/null 2>&1; then
	        echo "Building Graphify knowledge graph (backend: $(GRAPHIFY_BACKEND)) ..."
	        ( cd "$(TARGET_REPO)" && $(GRAPHIFY) extract . --backend $(GRAPHIFY_BACKEND) && $(GRAPHIFY) label . )
	        cp "$(TARGET_REPO)/graphify-out/graph.json" results/graph.json || echo "WARN: graph.json not produced"
	    else
	        echo "WARN: '$(GRAPHIFY)' not found (pip install graphifyy). Skipping knowledge graph."
	    fi
	else
	    echo "SKIP_GRAPHIFY set; skipping knowledge graph."
	fi
	echo "Ingestion completed."

create_struct:  ## Setup directory structure
	echo "Creating directory structure..."
	mkdir -p config results/sections results/assets/images results/assets/diagrams

clean_struct:  ## Clean directory structure
	echo "Cleaning generated outputs..."
	rm -rf results/


# MARK:agents, LLMs


setup_claude_code:  ## Setup claude code CLI, node.js and npm have to be present
	echo "Setting up Claude Code CLI ..."
	npm install -gs @anthropic-ai/claude-code
	echo "Claude Code CLI version: $$(claude --version)"


# MARK: PlantUML


setup_plantuml:  ## Setup PlantUML with docker, $(PLANTUML_SCRIPT) and $(PLANTUML_CONTAINER)
	echo "Setting up PlantUML docker ..."
	chmod +x $(PLANTUML_SCRIPT)
	docker pull $(PLANTUML_CONTAINER)
	echo "PlantUML docker version: $$(docker run --rm $(PLANTUML_CONTAINER) --version)"

run_puml_interactive:  ## Generate a themed diagram from a PlantUML file interactively.
	# https://github.com/plantuml/plantuml-server
	# plantuml/plantuml-server:tomcat
	docker run -d -p 8080:8080 "$(PLANTUML_CONTAINER)"

run_puml_single:  ## Generate a themed diagram from a PlantUML file.
	$(PLANTUML_SCRIPT) "$(INPUT_FILE)" "$(STYLE)" "$(OUTPUT_PATH)" \
		"$(CHECK_ONLY)" "$(PLANTUML_CONTAINER)"


# MARK: PDF converter


setup_pdf_converter:  ## Setup PDF converter tools: pandoc, wkhtmltopdf
	converter_choice=$(firstword $(strip $(ARGS)))
	converter_supported="Use 'pandoc' or 'wkhtmltopdf'."
	usage="--- Usage ---\nCombine files: cat file1.md file2.md file3.md > combined.md\nConvert files: "
	if [ -z "$${converter_choice}" ]; then
		echo "No PDF converter specified. $${converter_supported}"
		exit 1
	fi
	echo "Setting up PDF converter '$${converter_choice}' ..."
	sudo apt-get update -yqq
	if [ "$${converter_choice}" = "pandoc" ]; then
		sudo apt-get install -yqq pandoc
		sudo apt-get install -yqq texlive-latex-recommended texlive-fonts-recommended
		pandoc --version | head -n 1
		echo "$${usage} pandoc combined.md -o output.pdf"
	elif [ "$${converter_choice}" = "wkhtmltopdf" ]; then
		sudo apt-get install -yqq wkhtmltopdf
		echo "$${usage} markdown your_document.md & wkhtmltopdf - output.pdf"
	else
		echo "Error: Unsupported PDF converter choice '$${converter_choice}'. $${converter_supported}"
		exit 1
	fi


# MARK: Lint


lint: lint_md lint_sh  ## Run all linters (Markdown + shell)

lint_md:  ## Lint Markdown with markdownlint-cli2
	npx --yes markdownlint-cli2

lint_sh:  ## Lint shell scripts with shellcheck (errors only)
	shellcheck -S error scripts/writeup/*.sh scripts/test/*.sh


# MARK: Test


test:  ## Validate analysis.yaml schema + agent-spec path conventions (TDD)
	sh scripts/test/validate-schema.sh \
		schema/analysis.schema.json \
		tests/fixtures/valid \
		tests/fixtures/invalid \
		$(CHECK_JSONSCHEMA_VERSION)
	sh scripts/test/check-spec-paths.sh .claude/agents


# MARK: help


help:  ## Displays this message with available recipes
	echo "Usage: make [recipe]"
	echo "Recipes:"
	awk '/^[a-zA-Z0-9_-]+:.*?##/ {
		helpMessage = match($$0, /## (.*)/)
		if (helpMessage) {
			recipe = $$1
			sub(/:/, "", recipe)
			printf "  \033[36m%-20s\033[0m %s\n", recipe, substr($$0, RSTART + 3, RLENGTH)
		}
	}' $(MAKEFILE_LIST)