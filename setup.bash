#!/usr/bin/env bash

CONFIGS_REPO=git@github.com:andre487/dotfiles.git
CONFIGS_DIR=.dorfiles

OHMYZSH_DIR=.oh-my-zsh
FZF_DIR=.fzf

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
if [[ ! -d "$OHMYZSH_DIR" ]]; then
    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi

# Install FZF
if [[ ! -d "$FZF_DIR" ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "$FZF_DIR"
    ~/"$FZF_DIR"/install
fi

# The fuck
set +e
which thefuck &> /dev/null
if [[ $? != 0 ]]; then
    wget -O - https://raw.githubusercontent.com/nvbn/thefuck/master/install.sh | sh - && $0
fi
set -e
