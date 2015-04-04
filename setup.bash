#!/usr/bin/env bash

CONFIGS_REPO=git@github.yandex-team.ru:andre487/configs.git
CONFIGS_DIR=.configs

OHMYZSH_DIR=.oh-my-zsh

set -e

cd ~

# Checkout configs
if [[ -d "$CONFIGS_DIR" ]]; then
    cd "$CONFIGS_DIR"
    git stash clear
    git stash
    git pull
    git stash apply 2> /dev/null || true
    cd - > /dev/null
else
    git clone "$CONFIGS_REPO" "$CONFIGS_DIR"
fi

# Create config files
for file in `find "$CONFIGS_DIR" -maxdepth 1 -type f -name "\.*" -exec basename {} \;`; do
    [[ -f "$file" ]] && rm "$file"
    ln -s "$CONFIGS_DIR/$file"
    echo "Set up $file"
done

# Install Oh my ZSH
[[ ! -d "$OHMYZSH_DIR" ]] && curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
