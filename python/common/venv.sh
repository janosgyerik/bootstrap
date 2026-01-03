#!/usr/bin/env bash

set -euo pipefail

venv=$(dirname "$BASH_SOURCE")/venv
if test -d "$venv"; then
    . "$venv"/bin/activate
else
    {
        echo "venv does not exist: $venv"
        echo "Create it with: python3 -m venv \"$venv\""
        echo "Or run ./scripts/setup.sh"
        exit 1
    } >&2
fi
