#!/bin/sh

# I've removed all environment variables
# but there might be useful ones in the future.
# https://docs.mesa3d.org/envvars.html

export ENABLE_LAYER_MESA_ANTI_LAG=1
export PROTON_USE_NTSYNC=1

obs-gamecapture mangohud gamemoderun "$@"
