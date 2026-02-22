#!/bin/sh

# This script is just to disable wayland support
# in case I need Steam Overlay or Steam Input in that game.

PROTON_ENABLE_WAYLAND=0

~/.local/share/scripts/games/launch.sh "$@"
