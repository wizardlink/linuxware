#!/bin/sh

# This script is to pipe the game's RPC connection
# from wine and expose it to Linux processes.

~/.local/share/scripts/rpc-bridge/bridge.sh ~/.local/share/scripts/games/launch.sh "$@"
