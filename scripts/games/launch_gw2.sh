#!/bin/sh
export MANGOHUD=1

# https://docs.mesa3d.org/envvars.html
export AMD_VULKAN_ICD="RADV"
export RADV_PERFTEST="sam"

export WINEFSYNC=1
export WINEPREFIX=/home/wizardlink/Games/guild_wars_2/
export WINEARCH="win64"

export DXVKV_ASYNC=1
export DXVK_CONFIG_FILE=/home/wizardlink/.config/dxvk.conf

gamemoderun wine64 /home/wizardlink/Games/guild_wars_2/drive_c/Program\ Files/Guild\ Wars\ 2/Gw2-64.exe -autologin
