#!/bin/sh
export AMD_VULKAN_ICD="RADV"
export DXVK_ASYNC=1
export MANGOHUD=1
export RADV_PERFTEST="gpl"

export WINEFSYNC=1

gamemoderun "$@"
