#!/usr/bin/env bash
set -euo pipefail
cd "$HOME"

configs_repo=https://github.com/andre487/dotfiles.git
push_remote=git@github.com:andre487/dotfiles.git
configs_dir="$HOME/.dotfiles"

# Get up-to-date repo data
if [[ -d "$configs_dir" ]]; then
    cd "$configs_dir"
    cur_branch="$(git branch | grep '\*' | sed -E 's/[* ]+//g')"
    git stash clear
    git stash
    git pull --rebase origin "$cur_branch"
    git stash apply || true
else
    git clone "$configs_repo" "$configs_dir"
    cd "$configs_dir"
    git remote add upstream "$push_remote"
fi
cd - >/dev/null

# Create config files
IFS=$'\n' read -r -d '' -a config_files < <(find "$configs_dir" -maxdepth 1 -type f -name "\.*" -exec basename {} \; && printf '\0')
for file in "${config_files[@]}"; do
    file_path="$HOME/$file"
    if [[ -L "$file_path" ]]; then
        rm "$file_path"
    fi
    ln -s "$configs_dir/$file" "$file_path" || true
    echo "Setup $file"
done

# Install FZF
fzf_dir="$HOME/.fzf"
if [[ ! -d "$fzf_dir" ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "$fzf_dir"
    if ! "$fzf_dir/install" --key-bindings --completion --no-update-rc; then
        echo "WARNING! Fzf is not installed properly"
        echo "Please run '$fzf_dir/install --key-bindings --completion --no-update-rc' and fix errors"
    fi
fi

# Install Oh my ZSH
ohmyzsh_dir="$HOME/.oh-my-zsh"
if [[ ! -d "$ohmyzsh_dir" ]]; then
    export KEEP_ZSHRC=yes
    if ! sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended; then
        echo "WARNING! Oh my ZSH is not installed"
        rm -rf "$ohmyzsh_dir"
    fi
fi

# Install Vim plugins
vim_setup_log=/tmp/vim-plugin-setup.log
if ! vim +PluginInstall +qall >/dev/null 2>"$vim_setup_log"; then
    echo "WARNING! Vim plugins setup error. See $vim_setup_log"
    echo "Run vim and :PluginInstall"
fi

# Install syntax highlight
platform_name="$(uname)"
if [[ "$platform_name" == Linux ]]; then
    echo "To install ZSH syntax highlight check package from here: https://clck.ru/Ufg9g"
else
    if [[ "$platform_name" == Darwin ]] && which brew >/dev/null; then
        brew install zsh-syntax-highlighting
    fi
fi
