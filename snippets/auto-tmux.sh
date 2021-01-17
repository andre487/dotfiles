if [[ -z "$SHELL" ]]; then
    # export SHELL="$(which bash)"
    export SHELL="$(which zsh)"
fi

if [[ -z "$TMUX" ]]; then
    tmux attach || tmux new
fi
