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

# fnm is initialized at the very end of this file (see "fnm").



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
# Mise - activated eagerly at the end of this file (see "Mise - eager activation")

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

# Pi
export PATH="/Users/seawatts/.local/share/fnm/node-versions/v22.21.1/installation/bin:$PATH"

# Added by Devin
export PATH="/Users/seawatts/.codeium/windsurf/bin:$PATH"

# Personal secrets (API keys) are NOT kept in this repo. Put them in
# ~/.config/zsh/secrets.zsh (mode 600, untracked) and export them there.
[ -f "$HOME/.config/zsh/secrets.zsh" ] && source "$HOME/.config/zsh/secrets.zsh"
# export ANTHROPIC_BASE_URL="https://openrouter.ai/api"   # no /v1 for Claude Code
# export ANTHROPIC_AUTH_TOKEN="$OPENROUTER_API_KEY"
# export ANTHROPIC_API_KEY=""                              # must be empty string, not unset
# Mise - eager activation. Keep this last: `mise activate` prepends per-project
# mise.toml PATH entries, so anything exported below would shadow them.
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh --shims)"
  eval "$(mise activate zsh)"
elif [ -f "$HOME/.local/bin/mise" ]; then
  export PATH="$HOME/.local/bin:$PATH"
  eval "$("$HOME/.local/bin/mise" activate zsh --shims)"
  eval "$("$HOME/.local/bin/mise" activate zsh)"
fi

# NemoClaw PATH setup
export PATH="/Users/seawatts/.local/bin:$PATH"
# end NemoClaw PATH setup

# fnm (Node version manager) — eager because of --use-on-cd.
# Keep this LAST: several directories exported above also contain a node/npm
# (e.g. the globally-installed npm CLIs under fnm's v22 tree), and prepending
# them after this point would shadow the per-directory Node version that
# .nvmrc / .node-version selects.
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd)"
fi
