#!/bin/sh
export AMD_VULKAN_ICD="RADV"
export DXVK_ASYNC=1
export DXVK_STATE_CACHE=1
export MANGOHUD=1
export RADV_PERFTEST="rt,gpl"
export VKD3D_CONFIG="dxr11"
export __GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1

gamemoderun "$@" -dx12
