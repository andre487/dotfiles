#!/usr/bin/env bash
set -euo pipefail
cd ~

configs_repo=https://github.com/andre487/dotfiles.git
push_remote=git@github.com:andre487/dotfiles.git
configs_dir=.dotfiles

# Checkout configs
if [[ -d "$configs_dir" ]]; then
    cd "$configs_dir"
    cur_branch="$(git branch | grep '\*' | sed -E 's/[* ]+//g')"
    git stash clear
    git stash
    git pull --rebase origin "$cur_branch"
    git stash apply || true
    cd - > /dev/null
else
    git clone "$configs_repo" "$configs_dir"
    cd "$configs_dir"
    git remote add upstream "$push_remote"
fi

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
fzf_dir=.fzf
if ! which fzf &> /dev/null; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "$fzf_dir"
    "$HOME/$fzf_dir/install" --key-bindings --completion --no-update-rc
fi

# Install Oh my ZSH
ohmyzsh_dir=.oh-my-zsh
if [[ ! -d "$ohmyzsh_dir" ]]; then
    export KEEP_ZSHRC=yes
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
fi

# Install Vim plugins
vim +PluginInstall +qall 2> /dev/null
