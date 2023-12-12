#!/bin/sh
export MANGOHUD=1

# https://docs.mesa3d.org/envvars.html
export AMD_VULKAN_ICD="RADV"
export RADV_PERFTEST="sam"

export PROTON_NO_FSYNC=1

export DXVK_ASYNC=1

gamemoderun "$@"
