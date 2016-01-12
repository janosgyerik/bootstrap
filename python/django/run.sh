#!/bin/sh

cd $(dirname "$0")

#./manage.sh runserver "$@" --settings myproj.local_settings
./manage.sh runserver "$@"
