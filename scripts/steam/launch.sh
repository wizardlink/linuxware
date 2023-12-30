#!/bin/sh
export MANGOHUD=1

# https://docs.mesa3d.org/envvars.html
export AMD_VULKAN_ICD="RADV"

export DXVK_ASYNC=1

export ENABLE_VKBASALT=1

gamemoderun "$@"
