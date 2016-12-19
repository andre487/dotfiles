#!/usr/bin/env bash

CONFIGS_REPO=https://github.com/andre487/dotfiles.git
CONFIGS_DIR=.dotfiles

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
    file_path="$HOME/$file"
    if [[ -L "$file_path" ]]; then
        rm "$file_path"
    fi

    set +e
    ln -s "$CONFIGS_DIR/$file" "$file_path"
    set -e
    echo "Set up $file"
done

# Install FZF
FZF_DIR=.fzf

set +e
which fzf &> /dev/null
if [[ $? != 0 ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "$FZF_DIR"
    ~/"$FZF_DIR"/install --key-bindings --completion --no-update-rc
fi
set -e

# Install Oh my ZSH
OHMYZSH_DIR=.oh-my-zsh

if [[ ! -d "$OHMYZSH_DIR" ]]; then
    set +e
    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
    set -e
fi
