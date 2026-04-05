#!/bin/sh

# This script is just to disable wayland support
# in case I need Steam Overlay or Steam Input in that game.

export ENABLE_LAYER_MESA_ANTI_LAG=1
export PROTON_ENABLE_WAYLAND=1
export PROTON_USE_NTSYNC=1
export WAYLANDDRV_PRIMARY_MONITOR=DP-2

obs-gamecapture mangohud gamemoderun "$@"
