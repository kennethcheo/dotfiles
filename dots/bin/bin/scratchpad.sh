#!/bin/bash

pids=$(xdotool search --class ${1})
for pid in $pids; do
    bspc node $pid --flag hidden -f
done
