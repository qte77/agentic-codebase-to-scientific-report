#!/bin/sh
# Validate the analysis.yaml schema contract (TDD harness).
#
# Asserts both directions of the contract:
#   1. the valid fixture MUST validate against the schema (exit 0);
#   2. the invalid fixture MUST be rejected (non-zero) — guards against a schema
#      that silently accepts malformed analysis.yaml.
#
# Uses check-jsonschema (pinned) which safe-parses the YAML instance natively and
# never executes its content. Prefers `pipx run` (isolated venv, sidesteps PEP 668);
# falls back to a check-jsonschema already on PATH (e.g. pip --user install).
set -eu

SCHEMA=${1:?usage: validate-schema.sh SCHEMA VALID_FIXTURE INVALID_FIXTURE VERSION}
VALID=${2:?missing valid fixture path}
INVALID=${3:?missing invalid fixture path}
VERSION=${4:?missing check-jsonschema version}

# Select the runner once, then reuse it via "$@".
if command -v pipx >/dev/null 2>&1; then
	set -- pipx run --spec "check-jsonschema==$VERSION" check-jsonschema
elif command -v check-jsonschema >/dev/null 2>&1; then
	set -- check-jsonschema
else
	echo "error: need 'pipx' or 'check-jsonschema' on PATH (pin: check-jsonschema==$VERSION)" >&2
	echo "hint: 'pip install --user check-jsonschema==$VERSION' or install pipx" >&2
	exit 127
fi

# 1. Valid fixture MUST validate.
if ! "$@" --schemafile "$SCHEMA" "$VALID"; then
	echo "FAIL: valid fixture did not validate: $VALID" >&2
	exit 1
fi
echo "ok: valid fixture validates against $SCHEMA"

# 2. Invalid fixture MUST be rejected.
if "$@" --schemafile "$SCHEMA" "$INVALID" >/dev/null 2>&1; then
	echo "FAIL: invalid fixture unexpectedly validated: $INVALID" >&2
	exit 1
fi
echo "ok: invalid fixture correctly rejected: $INVALID"

echo "PASS: analysis.yaml schema contract verified"
