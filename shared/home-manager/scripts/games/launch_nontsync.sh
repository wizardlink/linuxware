#!/bin/sh

# This script is to disable ntsync in case
# it brings up problems.

PROTON_NO_ESYNC=0
PROTON_NO_FSYNC=0
PROTON_USE_NTSYNC=0

~/.local/share/scripts/games/launch.sh "$@"
