#!/bin/sh

export MANGOHUD=1

# https://docs.mesa3d.org/envvars.html
export MESA_NO_DITHER=1         # Disables dither
export MESA_BACK_BUFFER=pixmap  # For X only

export DXVK_ASYNC=1

gamemoderun "$@"
