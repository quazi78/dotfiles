#!/usr/bin/env bash

dir="$HOME/.config/rofi"
theme='catppuccin-mocha'

## Run
rofi \
    -modi drun \
    -show drun \
    -theme ${dir}/${theme}.rasi
