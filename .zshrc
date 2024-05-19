#
# Some custom vars
#
_zshrc_platform="$(uname)"
_zshrc_arch="$(uname -m)"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="false"

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
# Autoloading functions
# https://zsh.sourceforge.io/Doc/Release/Functions.html
#
if [[ ! -d ~/.zfunc ]]; then
    mkdir -m755 ~/.zfunc
fi
fpath=(~/.zfunc $fpath)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    encode64
    fzf
    gitfast
    grunt
    gulp
    invoke
    iterm2
    redis-cli
    urltools
    zsh-interactive-cd
    zsh-navigation-tools
)

case "$_zshrc_platform" in
    Darwin)
        plugins+=(macos)
        ;;
    Linux)
        plugins+=(ubuntu)
        ;;
esac

if [[ -n "$TMUX" ]]; then
    plugins+=(last-working-dir)
fi

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

#
# FZF
#
if ! which fzf &>/dev/null && [[ -f "$HOME/.fzf.zsh" ]]; then
    source "$HOME/.fzf.zsh"
elif which fzf-history-widget &>/dev/null; then
    bindkey '^R' fzf-history-widget
fi

#
# Settings
#
export LANG=en_US.UTF-8
export LC_ALL="$LANG"

export EDITOR="vim"
export BC_ENV_ARGS='-lq'
export LESS="$LESS --IGNORE-CASE --RAW-CONTROL-CHARS --squeeze-blank-lines +Gg" # +Gg - highlight all searches

#
# PATH
#
export PATH="/usr/local/sbin:/usr/local/bin:$HOME/node_modules/.bin:$HOME/.dotfiles/bin:$HOME/go/bin:$PATH:$HOME/bin:$HOME/.local/bin:/Applications/IntelliJ IDEA.app/Contents/MacOS:/Applications/CLion.app/Contents/MacOS"

#
# Functions
#
tt-fix-ssh-agent() {
    if ! which tmux &>/dev/null || [[ -z "$TMUX"  ]]; then
        echo 'Not in TMUX session'
        return 0
    fi
    eval $(tmux show-env -s | grep '^SSH_')
    ssh-add -l
}

#
# Aliases
#
alias nots='ya tool nots'
alias p=pnpm

#
# Homebrew
#
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

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
# Some crutches
#
# Fix Puppeteer ARM installation issue: https://github.com/puppeteer/puppeteer/issues/7740
if [[ "$_zshrc_platform" == Darwin ]] && [[ "$_zshrc_arch" == arm64 ]]; then
    export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=1
    export PUPPETEER_EXECUTABLE_PATH="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    export CHROME_PATH="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
fi

#
# Extra services
#
if which skotty &>/dev/null; then
    eval "$(skotty ssh env)"
fi

if which arc &>/dev/null; then
    if [[ ! -f "$HOME/.zfunc/_arc" ]]; then
        arc completion zsh >"$HOME/.zfunc/_arc"
        source "$HOME/.zfunc/_arc"
        compinit
    fi
fi

# The next line updates PATH for Yandex Cloud CLI.
if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi

# The next line enables shell command completion for yc.
if [ -f "$HOME/yandex-cloud/completion.zsh.inc" ]; then source "$HOME/yandex-cloud/completion.zsh.inc"; fi

#
# Cleanup
#
unset -m "_zshrc_*"
