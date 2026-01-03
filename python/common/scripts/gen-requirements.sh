#!/usr/bin/env bash

set -euo pipefail

requirements=requirements.txt

{
    echo '# Install required python packages using pip:'
    echo '# pip install -r requirements.txt'
    ./pip.sh freeze
} | tee "$requirements"

print_and_run() {
    echo
    echo "+ $*"
    "$@"
}

print_and_run git status -sb "$requirements"

print_and_run git diff "$requirements"
