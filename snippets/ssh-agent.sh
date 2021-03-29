if ! ssh-add -l &> /dev/null; then
    eval "$(ssh-agent)" &> /dev/null
    ssh-add "$HOME/.ssh/id_rsa" &> /dev/null
fi
