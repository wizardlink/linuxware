#!/bin/sh
export AMD_VULKAN_ICD="RADV"
export DXVK_ASYNC=1
export MANGOHUD=1
export RADV_PERFTEST="gpl"

export WINEFSYNC=1
export WINEPREFIX=/home/wizardlink/Games/guild_wars_2/
export WINEARCH="win64"

gamemoderun wine64 /home/wizardlink/Games/guild_wars_2/drive_c/Program\ Files/Guild\ Wars\ 2/Gw2-64.exe -autologin
