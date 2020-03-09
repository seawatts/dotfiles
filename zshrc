# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
#COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"
#DEFAULT_USER="seawatts"

# ----------------
# Plugins
# ----------------
plugins=(
  autojump
  git
  # zsh-autosuggestions
 )

# ----------------
# Speed things up instructions
# https://blog.jonlu.ca/posts/speeding-up-zsh
# ----------------

# Initialize
# Speeds up load time
DISABLE_UPDATE_PROMPT=true
fpath=(~/.zsh/completion $fpath)

# https://gist.github.com/ctechols/ca1035271ad134841284
#https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2308206
setopt extendedglob
# Perform compinit only once a day.
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
  touch ~/.zcompdump
else
  compinit -C
fi

unset extendedglob

# ----------------
# Sandbox all things nvm, rbenv, pyenv etc
# https://github.com/benvan/sandboxd
# ----------------
source ~/src/github.com/benvan/sandboxd/sandboxd

# ----------------
# Editor
# ----------------
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# ----------------
# Git
# ----------------
alias gs='git status'
alias gcd='git checkout develop'
alias gcm='git checkout master'

# ----------------
# Powerlevel9k
# ----------------
## Powerlevel9k Settings
POWERLEVEL9K_HISTORY_BACKGROUND='green'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="%F{red} \Uf1d0 %f %F{yellow
}❯ "
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

# ----------------
# Theme
# ----------------
ZSH_THEME="kolo"

# ----------------
# tmux
# ----------------
alias tk='tmux kill-session -t'
alias mux='tmuxinator'

# ----------------
# yarn
# ----------------
# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# ----------------
# Common Commands
# ----------------
alias json="pbpaste | jq '.'"
alias z="code ~/.zshrc"
alias r="source ~/.zshrc"

# ----------------
# rbenv
# ----------------
# export PATH="$HOME/.rbenv/bin:$PATH"

# ----------------
# Python
# ----------------
# export PYTHONPATH=/Users/seawatts/.pyenv/versions/3.7.0/lib/python3.7/site-packages

# ----------------
# user
# ---------------
export PATH="$PATH":~/bin

PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"

source $ZSH/oh-my-zsh.sh

