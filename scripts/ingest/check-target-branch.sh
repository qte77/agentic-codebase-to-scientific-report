#!/bin/sh
# Guard for Phase 0 (#36): the target clone must be on the branch named in
# config/sources.md, or repo_ingest would silently pack whatever is checked out.
#
# Read-only: it never switches the clone's branch (that clone may be someone's
# working copy); it fails loudly with the command to fix it instead.
set -eu

REPO=${1:?usage: check-target-branch.sh TARGET_REPO TARGET_BRANCH}
BRANCH=${2:?missing TARGET_BRANCH (set Branch: in config/sources.md)}

# Reason: git -C resolves an enclosing repo, so a plain subdirectory of some other
# clone would pass a work-tree check; require REPO to be the clone's own toplevel.
toplevel=$(git -C "$REPO" rev-parse --show-toplevel 2>/dev/null || true)
if [ -z "$toplevel" ] || [ "$toplevel" != "$(cd "$REPO" && pwd -P)" ]; then
	echo "error: target '$REPO' is not a git clone; cannot verify branch '$BRANCH'" >&2
	exit 1
fi

current=$(git -C "$REPO" symbolic-ref --short -q HEAD || true)
if [ "$current" != "$BRANCH" ]; then
	echo "error: target '$REPO' is on '${current:-detached HEAD}', but config/sources.md names branch '$BRANCH'" >&2
	echo "hint: git -C '$REPO' switch '$BRANCH' (or update Branch: in config/sources.md)" >&2
	exit 1
fi
echo "Target branch OK: $REPO is on '$BRANCH'."
