#!/bin/sh

FILE_PATH="/mnt/internal/personal/screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png"

grim -t png -o eDP-1 $FILE_PATH
wl-copy <$FILE_PATH
