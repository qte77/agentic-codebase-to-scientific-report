# Agentic Codebase to Scientific Report Generator Pipeline

.SILENT:
.ONESHELL:
.PHONY: all analyze synthesize validate repo_ingest create_struct clean_struct setup_claude_code help
.DEFAULT_GOAL := help


# MARK: Config


# Target repo + branch are read from the Primary Target in config/sources.md.
TARGET_REPO := $(shell grep -m1 -E '^Repository:' config/sources.md | sed -E 's/^Repository:[[:space:]]*//')
TARGET_BRANCH := $(shell grep -m1 -E '^Branch:' config/sources.md | sed -E 's/^Branch:[[:space:]]*//')

# Repo ingestion tooling (override on the command line as needed).
GRAPHIFY ?= graphify
GRAPHIFY_BACKEND ?= claude


# MARK: Report


all: analyze synthesize validate  ## Perform full scientific report generation process

analyze: repo_ingest  ## Analyze the target repository (Phase 1)
	echo "Starting Repository Analysis..."
	{ cat results/repo-context.xml results/graph.json 2>/dev/null; cat .claude/agents/repo-analyzer.md; } | claude -p "execute"
	echo "Repository Analysis completed."

synthesize: analyze  ## Synthesize sections into report (Phase 2)
	echo "Starting Section Synthesis..."
	cat .claude/agents/section-synthesizer.md | claude -p "execute"
	echo "Section Synthesis completed."

validate: synthesize  ## Validate synthesized content against analysis (Phase 3)
	echo "Starting Content Validation..."
	cat .claude/agents/validator.md | claude -p "execute"
	echo "Content Validation completed."

repo_ingest: create_struct  ## Ingest target repo via Repomix + Graphify (Phase 0)
	echo "Ingesting target repo: $(TARGET_REPO) (branch $(TARGET_BRANCH)) ..."
	npx --yes repomix@latest "$(TARGET_REPO)" --compress --output results/repo-context.xml
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