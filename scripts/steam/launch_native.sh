#!/bin/sh

# https://docs.mesa3d.org/envvars.html
export AMD_VULKAN_ICD="RADV"

mangohud gamemoderun "$@"
