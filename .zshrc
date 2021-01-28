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
# export UPDATE_ZSH_DAYS=13

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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(svn pip)

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
alias git="LANG=C git"

#
# Settings
#
export BC_ENV_ARGS='-lq'

#
# Path
#
export PATH="/usr/local/sbin:/usr/local/bin:./node_modules/.bin:$HOME/node_modules/.bin:$PATH"

#
# Extra services
#
if [[ -f "$HOME/.fzf.zsh" ]]; then
    source "$HOME/.fzf.zsh"
fi

if [[ -f '/usr/local/share/zsh-completions' ]]; then
    export fpath=(/usr/local/share/zsh-completions $fpath)
fi

if [[ -d ~/.zfunc ]]; then
    fpath=(~/.zfunc $fpath)
fi

#
# User defined .zshrc
#
if [[ -f "$HOME/.zshrc.extra" ]]; then
    source "$HOME/.zshrc.extra"
fi

#
# NVM must be after any PATH modifications
#
export NVM_DIR="$HOME/.nvm"
if [[ ! -d "$NVM_DIR" ]]; then
    export NVM_DIR="/usr/local/opt/nvm"
fi

if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    source "$NVM_DIR/nvm.sh"
fi

if [[ -f "$HOME/.yql/shell_completion" ]]; then
    source "$HOME/.yql/shell_completion"
fi

# The next line updates PATH for Yandex Cloud CLI.
if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi

# The next line enables shell command completion for yc.
if [ -f "$HOME/yandex-cloud/completion.zsh.inc" ]; then source "$HOME/yandex-cloud/completion.zsh.inc"; fi

#
# Define methods
#
disable_git_tracking() {
    git_dir="$(git rev-parse --git-dir 2> /dev/null || true)"
    if [[ -n "$git_dir" ]]; then
        echo "Disable git tracking for $git_dir"
        git config --add oh-my-zsh.hide-status 1
        git config --add oh-my-zsh.hide-dirty 1
    else
        echo "Current dir is not a git repository"
    fi
}

cleanup_git_branches() {
    git br | grep -v '*' | grep -v dev | grep -v master | xargs -L1 git br -D
}

cleanup_arc_branches() {
    arc branch | grep -v '*' | grep -v trunk | xargs -L1 arc branch -D
}

setup_home_git() {
    git config --local user.name "Andrey Prokopyuk"
    git config --local user.email "andrey.prokopyuk@gmail.com"
}

if [[ "$OSTYPE" == "darwin"* ]]; then
    export -f disable_git_tracking > /dev/null
    export -f cleanup_git_branches > /dev/null
    export -f setup_home_git > /dev/null

    export PYCURL_SSL_LIBRARY=openssl
    export LDFLAGS=-L/usr/local/opt/openssl/lib
    export CPPFLAGS=-I/usr/local/opt/openssl/include
fi
