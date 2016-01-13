#!/bin/sh -e
#
# SCRIPT: create.sh
# AUTHOR: janos <janos@kronos>
# DATE:   2016-01-13
# REV:    1.0.D (Valid are A, B, D, T and P)
#               (For Alpha, Beta, Dev, Test and Production)
#
# PLATFORM: Not platform dependent
#
# PURPOSE: Create single-module Maven project
#

usage() {
    test $# = 0 || echo "$@"
    echo "Usage: $0 [OPTION]... [ARG]... DIR"
    echo
    echo Create single-module Maven project
    echo
    echo Options:
    echo "  -g, --groupId GROUP_ID          default = $groupId"
    echo "  -a, --artifactId ARTIFACT_ID    default = $artifactId"
    echo
    echo "  -h, --help                      Print this help"
    echo
    exit 1
}

args=
#flag=off
template_groupId=com.janosgyerik.myproj
template_artifactId=myproj
groupId=$template_groupId
artifactId=$template_artifactId
while test $# != 0; do
    case $1 in
    -h|--help) usage ;;
#    -f|--flag) flag=on ;;
#    --no-flag) flag=off ;;
    -g|--groupId) shift; groupId=$1 ;;
    -a|--artifactId) shift; artifactId=$1 ;;
#    --) shift; while test $# != 0; do args="$args \"$1\""; shift; done; break ;;
    -|-?*) usage "Unknown option: $1" ;;
    *) args="$args \"$1\"" ;;  # script that takes multiple arguments
    esac
    shift
done

eval "set -- $args"  # save arguments in $@. Use "$@" in for loops, not $@ 

test $# -gt 0 || usage

target_dir=$1
if ! test -d "$target_dir"; then
    echo fatal: target directory does not exist: $target_dir
    exit 1
fi

template_dir=$(dirname "$0")

(cd $template_dir; git archive master) | tar xv -C "$target_dir"

groupId_path=${groupId//.//}
mkdir -pv "$target_dir"/src/{main,test}/java/$groupId_path/$artifactId

sed -e "s/$template_groupId/$groupId/g" -e "s/$template_artifactId/$artifactId/g" "$template_dir/pom.xml" > "$target_dir/pom.xml"
