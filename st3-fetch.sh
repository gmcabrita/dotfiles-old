#!/usr/bin/env bash
set -e

cd "$(dirname "${BASH_SOURCE[@]}")";

rsync --include "*.sublime-settings" \
    --include "SublimeLinter/***" \
    --include "*/" \
    --exclude "*" \
    -avh --no-perms --prune-empty-dirs \
    ~/.config/sublime-text-3/Packages/User ./.config/sublime-text-3/Packages;
