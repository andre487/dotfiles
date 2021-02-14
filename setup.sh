#!/usr/bin/env bash
set -e -o pipefail
cd ~

configs_repo=https://github.com/andre487/dotfiles.git
configs_dir=.dotfiles

# Checkout configs
if [[ -d "$configs_dir" ]]; then
    cd "$configs_dir"
    cur_branch="$(git branch | grep '*' | sed -E 's/[* ]+//g')"
    git stash
    git pull --rebase origin "$cur_branch"
    git stash apply || true
    cd - > /dev/null
else
    git clone "$configs_repo" "$configs_dir"
fi

# Create config files
config_files=($(find "$configs_dir" -maxdepth 1 -type f -name "\.*" -exec basename {} \;))
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
set +e
which fzf &> /dev/null
if [[ $? != 0 ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "$fzf_dir"
    "$HOME/$fzf_dir/install" --key-bindings --completion --no-update-rc
fi
set -e

# Install Oh my ZSH
ohmyzsh_dir=.oh-my-zsh
if [[ ! -d "$ohmyzsh_dir" ]]; then
    set +e
    export KEEP_ZSHRC=yes
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
    set -e
fi

# Install Vim plugins
vim +PluginInstall +qall
