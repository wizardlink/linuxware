#!/bin/sh

# This script is to disable ntsync in case
# it brings up problems.

export ENABLE_LAYER_MESA_ANTI_LAG=1

obs-gamecapture mangohud gamemoderun "$@"
