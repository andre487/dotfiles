if [[ -z "$ZSH_LAUNCHED" ]]; then
    export ZSH_LAUNCHED=1
    exec "$(which zsh)"
fi
