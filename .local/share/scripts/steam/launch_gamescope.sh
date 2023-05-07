#!/bin/sh
export AMD_VULKAN_ICD="RADV"
export DXVK_ASYNC=1
export DXVK_STATE_CACHE=1
export MANGOHUD=1
export RADV_PERFTEST="gpl"

gamescope -w 1280 -h 720 -W 1920 -H 1080 -f -- gamemoderun "$@"
