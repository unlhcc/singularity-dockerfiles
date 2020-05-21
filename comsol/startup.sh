#!/usr/bin/env bash
set -e

export _JAVA_OPTIONS="-Duser.home=$WORK"
if [ -n "$1" ]; then "$@"; else /usr/bin/env bash; fi
