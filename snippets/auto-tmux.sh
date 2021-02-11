export SHELL="$(which zsh)"

if [[ -z "$TMUX" ]]; then
    tmux attach || tmux new
fi
