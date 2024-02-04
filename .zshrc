# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="false"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=30
export DISABLE_UPDATE_PROMPT=true
export DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

#
# FZF
#
if [[ -f "$HOME/.fzf.zsh" ]]; then
    source "$HOME/.fzf.zsh"
fi

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    encode64
    fnm
    fzf
    gitfast
    golang
    grunt
    gulp
    invoke
    iterm2
    last-working-dir
    node
    npm
    pip
    pipenv
    poetry
    redis-cli
    urltools
    zsh-interactive-cd
    zsh-navigation-tools
)

case "$(uname)" in
    Darwin)
        plugins+=(macos)
        ;;
    Linux)
        plugins+=(ubuntu)
        ;;
esac


#
# User defined .zshrc
#
if [[ -f "$HOME/.zshrc.extra" ]]; then
    source "$HOME/.zshrc.extra"
fi

#
# Oh my ZSH activation
#
if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
    source "$ZSH/oh-my-zsh.sh"
else
    echo "Oh my zsh not found"
fi

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL="$LANG"

# Preferred editor for local and remote sessions
export EDITOR="vim"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias less="less -s -M +Gg"

#
# Settings
#
export BC_ENV_ARGS='-lq'

#
# PATH
#
export PATH="/usr/local/sbin:/usr/local/bin:$HOME/node_modules/.bin:$HOME/.dotfiles/bin:$PATH"

#
# Functions
#
fix_tmux_ssh_agent() {
    eval $(tmux show-env -s |grep '^SSH_')
    ssh-add -l
}

#
# Aliases
#
alias nots='ya tool nots'
alias p=pnpm

#
# NVM and FNM must be after any PATH modifications
#
if [[ -d "$HOME/.fnm" ]]; then
    export PATH="$HOME/.fnm:$PATH"
fi

if [[ -d "$HOME/.local/share/fnm" ]]; then
    export PATH="$HOME/.local/share/fnm:$PATH"
fi

if which fnm &>/dev/null; then
    eval "$(fnm env)"
fi

if [[ -z "$FNM_DIR" ]]; then
    export NVM_DIR="$HOME/.nvm"
    if [[ ! -d "$NVM_DIR" ]]; then
        export NVM_DIR="/usr/local/opt/nvm"
        if [[ ! -d "$NVM_DIR" ]]; then
            export NVM_DIR=
        fi
    fi

    if [[ -n "$NVM_DIR" ]] && [[ -s "$NVM_DIR/nvm.sh" ]]; then
        source "$NVM_DIR/nvm.sh"
        source "$NVM_DIR/bash_completion"
    fi
fi

#
# Extra services
#
if [[ -f "$HOME/.arc/completion.sh" ]]; then
    source "$HOME/.arc/completion.sh"
fi

if [[ -f "$HOME/.yql/shell_completion" ]]; then
    source "$HOME/.yql/shell_completion"
fi

if [[ -d ~/.zfunc ]]; then
    fpath=(~/.zfunc $fpath)
fi

# The next line updates PATH for Yandex Cloud CLI.
if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi

# The next line enables shell command completion for yc.
if [ -f "$HOME/yandex-cloud/completion.zsh.inc" ]; then source "$HOME/yandex-cloud/completion.zsh.inc"; fi
