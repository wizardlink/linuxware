#!/bin/sh

FILE_PATH="/mnt/internal/personal/screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png"

grim -t png -o DP-2 $FILE_PATH
wl-copy <$FILE_PATH
