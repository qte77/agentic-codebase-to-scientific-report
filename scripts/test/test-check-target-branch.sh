#!/bin/sh
# TDD harness for scripts/ingest/check-target-branch.sh (#36).
#
# Builds throwaway git repos (no commits needed: an unborn branch still names
# HEAD) and asserts the guard passes only when the clone is on the configured
# branch, and fails loudly on a mismatch, a detached HEAD, or a non-git path.
set -eu

GUARD=${1:?usage: test-check-target-branch.sh GUARD_SCRIPT}
# Scratch repos live under the gitignored .tmp/ of this checkout.
mkdir -p .tmp
TMP=$(mktemp -d .tmp/target-branch.XXXXXX)
TMP=$(cd "$TMP" && pwd)
trap 'rm -rf "$TMP"' EXIT
rc=0

expect() { # expect pass|fail DESCRIPTION REPO BRANCH
	if sh "$GUARD" "$3" "$4" >/dev/null 2>&1; then got=pass; else got=fail; fi
	if [ "$got" = "$1" ]; then
		echo "ok  : $1 $2"
	else
		echo "FAIL: expected $1, got $got: $2" >&2
		rc=1
	fi
}

git init -q -b main "$TMP/repo"
expect pass "clone on the configured branch" "$TMP/repo" main
expect fail "clone on another branch" "$TMP/repo" release
git -C "$TMP/repo" symbolic-ref HEAD refs/heads/feat/x
expect fail "configured main, clone on feat/x" "$TMP/repo" main
expect pass "branch name with a slash" "$TMP/repo" feat/x
mkdir "$TMP/plain"
expect fail "target is not a git clone" "$TMP/plain" main
expect fail "target does not exist" "$TMP/missing" main

if [ "$rc" -ne 0 ]; then
	echo "FAIL: target-branch guard" >&2
	exit 1
fi
echo "PASS: target-branch guard"
