# Agentic Codebase to Scientific Report Generator Pipeline
# Sequential execution with dependency management

.SILENT:
.ONESHELL:
.PHONY: all analyze synthesize validate create_struct clean_struct setup_claude_code help
.DEFAULT_GOAL := help

all: analyze synthesize validate  ## Perfom full process

analyze:  ## Analyze the target repo (Phase 1)
	# TODO
	echo "Not implemented"

synthesize:  ## Synthesize into report (Phase 2)
	# TODO
	echo "Not implemented"

validate:  ## Validate the synthezied content against analysis (Phase 3)
	# TODO
	echo "Not implemented"

create_struct:  ## Setup directory structure
	echo "Creating directory structure..."
	mkdir -p results/research results/gtm

clean_struct:  ## Clean directory structure
	echo "Cleaning generated outputs..."
	rm -rf results/research results/gtm

setup_claude_code:  ## Setup claude code CLI, node.js and npm have to be present
	echo "Setting up Claude Code CLI ..."
	npm install -gs @anthropic-ai/claude-code
	echo "Claude Code CLI version: $$(claude --version)"

help:  ## Displays this message with available recipes
	# TODO add stackoverflow source
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