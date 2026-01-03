#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"

#./manage.sh runserver "$@" --settings myproj.local_settings
./manage.sh runserver "$@"
