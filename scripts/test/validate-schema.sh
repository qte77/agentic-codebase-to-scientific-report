#!/bin/sh
# TDD harness for the analysis.yaml schema contract.
#
# Every fixture under VALID_DIR MUST validate; every fixture under INVALID_DIR
# MUST be rejected. Each invalid fixture encodes one realistic producer mistake
# that would otherwise surface only on a real `make all` (bad asset path, bad
# enum, missing nested-required field, schema-version drift), so the suite pins
# the contract's discriminating behaviour rather than merely "is it parseable".
#
# Uses check-jsonschema (pinned) which safe-parses the YAML instance natively and
# never executes its content. Prefers `pipx run` (isolated venv, sidesteps PEP 668);
# falls back to a check-jsonschema already on PATH (e.g. pip --user install).
set -eu

SCHEMA=${1:?usage: validate-schema.sh SCHEMA VALID_DIR INVALID_DIR VERSION}
VALID_DIR=${2:?missing valid fixtures dir}
INVALID_DIR=${3:?missing invalid fixtures dir}
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

rc=0
seen=0

# Every valid fixture MUST validate.
for f in "$VALID_DIR"/*.yaml; do
	[ -e "$f" ] || continue
	seen=$((seen + 1))
	if "$@" --schemafile "$SCHEMA" "$f" >/dev/null 2>&1; then
		echo "ok  : valid    accepted  $f"
	else
		echo "FAIL: valid    rejected  $f" >&2
		rc=1
	fi
done

# Every invalid fixture MUST be rejected.
for f in "$INVALID_DIR"/*.yaml; do
	[ -e "$f" ] || continue
	seen=$((seen + 1))
	if "$@" --schemafile "$SCHEMA" "$f" >/dev/null 2>&1; then
		echo "FAIL: invalid  accepted  $f" >&2
		rc=1
	else
		echo "ok  : invalid  rejected  $f"
	fi
done

if [ "$seen" -eq 0 ]; then
	echo "FAIL: no fixtures found under $VALID_DIR or $INVALID_DIR" >&2
	exit 1
fi
if [ "$rc" -ne 0 ]; then
	echo "FAIL: analysis.yaml schema contract ($seen fixtures checked)" >&2
	exit 1
fi
echo "PASS: analysis.yaml schema contract ($seen fixtures checked)"
