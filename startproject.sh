#!/usr/bin/env bash
#
# SCRIPT: startproject.sh
# AUTHOR: janos <janos@kronos>
# DATE:   2018-03-30
#
# PLATFORM: Not platform dependent
#
# PURPOSE: Bootstrap project type with essential boilerplate
#

set -euo pipefail

scriptdir=$(dirname "$0")

usage() {
    local exitcode=0
    if [ $# != 0 ]; then
        echo "$@"
        exitcode=1
    fi
    echo "Usage: $0 [OPTION]... recipe [DIR]"
    echo
    echo "Bootstrap project type with essential boilerplate"
    echo
    echo Options:
    echo
    echo "  -h, --help         Print this help"
    echo
    exit $exitcode
}

parse_args() {
    local args=()
    while test $# != 0; do
        case "$1" in
        -h|--help) usage ;;
        -|-?*) usage "Unknown option: $1" ;;
        *) args+=("$1") ;;
        esac
        shift
    done

    set -- "${args[@]}"

    case $# in
        1)
            recipe=$1
            targetdir=.
            ;;
        2)
            recipe=$1
            targetdir=$2
            ;;
        *)
            usage "Invalid arguments: $@"
    esac
}

validate_recipe() {
    local subdir
    if ! test -d "$scriptdir/recipes/$recipe"; then
        echo "No such recipe: $recipe"
        echo "Available recipes:"
        for subdir in "$scriptdir/recipes"/*/; do
            subdir=${subdir%?}
            subdir=${subdir##*/}
            echo "- $subdir"
        done
        echo
    fi
}

prepare_targetdir() {
    mkdir -p "$targetdir"
}

run_recipe() {
    . "$scriptdir/recipes/$recipe"/recipe.sh
    run
}

parse_args "$@"
validate_recipe "$recipe"

set -x
prepare_targetdir
run_recipe
