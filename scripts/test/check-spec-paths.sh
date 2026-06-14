#!/bin/sh
# Convention guard for agent specs (TDD regression guard).
#
# Asserts every agent spec under DIR keeps to the pipeline's canonical paths, so a
# spec can never drift from what the schema, synthesizer and pandoc expect:
#   - assets live under results/assets/ (never a bare assets/ path); and
#   - the bibliography is results/sections/references.bib (never results/bibliography.bib,
#     nor a 09-bibliography.md section that conflicts with pandoc's 01..08 + .bib order).
# Read-only greps over *.md; no code execution. Exits non-zero on any violation.
set -eu

DIR=${1:?usage: check-spec-paths.sh AGENT_SPEC_DIR}
rc=0

# A bare assets/ path: "assets/" not already prefixed by results/ (i.e. not
# preceded by a slash or word char). Matches "path: assets/x", "  assets/"; does
# NOT match "results/assets/x".
if grep -rnE --include='*.md' '(^|[^/[:alnum:]])assets/' "$DIR"; then
	echo "FAIL: bare 'assets/' path(s) above — every asset path must use the results/assets/ prefix" >&2
	rc=1
fi

# Non-canonical bibliography output.
if grep -rnE --include='*.md' 'bibliography\.bib|09-bibliography' "$DIR"; then
	echo "FAIL: non-canonical bibliography path(s) above — use results/sections/references.bib" >&2
	rc=1
fi

if [ "$rc" -ne 0 ]; then
	echo "FAIL: agent spec path conventions" >&2
	exit 1
fi
echo "PASS: agent spec path conventions ($DIR)"
