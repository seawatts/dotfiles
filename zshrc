# =============================================================================
# Oh My Zsh Configuration
# =============================================================================
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="kolo"
DEFAULT_USER="seawatts"
DISABLE_AUTO_TITLE="true"

# Optimize git plugin by disabling prompt status
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins - only essential ones
plugins=(git pnpm bun)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# # Initialize completion (with caching)
autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

# =============================================================================
# Environment Variables
# =============================================================================
# Editor
export EDITOR='vim'

# Powerline
export POWERLINE_CONFIG_COMMAND=powerline-config

# AWS
export AWS_DEFAULT_REGION=us-east-1
export AWS_PROFILE=boundaryml-dev

# Google Cloud SDK — pin to a supported Python (system 3.9 is deprecated)
if [ -x /opt/homebrew/bin/python3.14 ]; then
  export CLOUDSDK_PYTHON=/opt/homebrew/bin/python3.14
fi

# =============================================================================
# PATH Configuration - Combined for better performance
# =============================================================================
# Combine all PATH modifications into one export
typeset -U path  # Make PATH entries unique
path=(
  $HOME/bin
  /usr/local/bin
  /opt/homebrew/opt/openjdk/bin
  $HOME/.rbenv/shims
  $HOME/.rbenv/bin
  $HOME/.local/bin
  /opt/homebrew/share/google-cloud-sdk/bin
  $PNPM_HOME
  $path
)

# =============================================================================
# Tool Initializations - Lazy loaded where possible
# =============================================================================
# Lazy-loader function names can collide with aliases set by OMZ plugins
# or earlier sources of this file. Unalias defensively before (re)defining.
unalias z rbenv nvm bun go mise pyenv 2>/dev/null

# Zoxide - Lazy loaded
z() {
  unfunction "$0"
  if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
    $0 "$@"
  else
    echo "zoxide not installed" >&2
    return 1
  fi
}

# Ruby - lazy load rbenv
rbenv() {
  unfunction "$0"
  eval "$(rbenv init - zsh)"
  $0 "$@"
}

# Node Version Manager (NVM) - Lazy loaded
nvm() {
  unfunction "$0"
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  $0 "$@"
}

# fnm (Node version manager used by openrouter-web) — eager because of --use-on-cd
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd)"
fi



# =============================================================================
# Aliases
# =============================================================================
# Zsh
alias r='source ~/.zshrc'
alias zz='cursor ~/dotfiles/zshrc'

# Git
alias gs='git status'
alias gcd='git checkout develop'
alias gcm='git checkout main'
alias gmd="git merge develop"

# Faster git switching
alias gsw='git switch'
alias gswc='git switch -c'
alias gco='git checkout'
alias gcb='git checkout -b'

# Smart branch switching - prioritizes recent branches
git-branch-recent() {
  if [ -z "$1" ]; then
    echo "Recent branches:"
    git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short) %(committerdate:relative)'
  else
    git switch "$1" 2>/dev/null || git checkout "$1"
  fi
}
alias gbr='git-branch-recent'

# Common
alias json="pbpaste | jq '.'"

# Bun
alias bt='bun typecheck'
alias bd='bun dev'
alias bi='bun install'

# PNPM
alias pi='pnpm install'
alias pt='pnpm typecheck'
alias pb='pnpm build'

# Infisical
alias i='infisical'
alias ir='infisical run --recursive -- '
alias irp='infisical --env prod run --recursive -- '
alias irt='infisical --env test run --recursive -- '
alias is='infisical secrets --recursive'
alias isp='infisical secrets --env prod --recursive'
alias ist='infisical secrets --env test --recursive'
alias iu='infisical user switch'

# Zoxide - aliases for lazy-loaded zoxide
alias j='z'



# bun completions - Lazy loaded
bun() {
  unfunction "$0"
  [ -s "/Users/seawatts/.bun/_bun" ] && source "/Users/seawatts/.bun/_bun"
  $0 "$@"
}

# pnpm
export PNPM_HOME="/Users/seawatts/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# opencode
export PATH=/Users/seawatts/.opencode/bin:$PATH

# Go - Lazy loaded
go() {
  unfunction "$0"
  export PATH=$PATH:$(command go env GOPATH)/bin
  $0 "$@"
}
# Mise - Lazy loaded
mise() {
  unfunction "$0"
  if command -v mise &> /dev/null; then
    eval "$(mise activate zsh --shims)"
    eval "$(mise activate zsh)"
  elif [ -f ~/.local/bin/mise ]; then
    export PATH="$HOME/.local/bin:$PATH"
    eval "$(~/.local/bin/mise activate zsh --shims)"
    eval "$(~/.local/bin/mise activate zsh)"
  fi
  $0 "$@"
}

# alias claude="/Users/seawatts/.claude/local/claude"  # disabled 2026-04-30 — broken by claude-code auto-updater; using Homebrew install instead

# Pyenv - Lazy loaded
pyenv() {
  unfunction "$0"
  eval "$(pyenv init -)"
  $0 "$@"
}

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# OpenClaw Completion
[ -f "$HOME/.openclaw/completions/openclaw.zsh" ] && source "$HOME/.openclaw/completions/openclaw.zsh"
export PATH=$PATH:$HOME/.maestro/bin

# Zero CLI
export PATH="$HOME/.zero/bin:$PATH"
