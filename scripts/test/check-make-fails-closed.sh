#!/bin/sh
# Regression guard: `make test` must fail closed (#35).
#
# The Makefile runs each recipe as ONE shell script (.ONESHELL), so without `-e`
# make only sees the exit status of the recipe's LAST command and an earlier
# failure (missing check-jsonschema, a genuine schema violation) is masked.
# This re-runs `make test` with the invalid fixtures passed as the valid set, so
# the schema check MUST fail; TEST_INNER=1 skips this guard in the inner run,
# leaving a passing command last — exactly the shape that used to mask it.
set -eu

INVALID_DIR=${1:?usage: check-make-fails-closed.sh INVALID_FIXTURES_DIR}

if make -s test TEST_INNER=1 TEST_VALID_DIR="$INVALID_DIR" >/dev/null 2>&1; then
	echo "FAIL: make test exited 0 although its schema check failed (failure masked)" >&2
	exit 1
fi
echo "PASS: make test fails closed when an earlier recipe command fails"
