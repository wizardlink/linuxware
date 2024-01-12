#!/bin/sh

FILE_PATH="/mnt/internal/personal/screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png"

grim -t png -g "$(slurp -w 0 -b '#6E738D77')" $FILE_PATH
wl-copy <$FILE_PATH
