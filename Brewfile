# Brewfile — install with: brew bundle --file=~/dotfiles/Brewfile
# Or via the setup.sh script, which runs `brew bundle` automatically.

# CLI tools the zshrc relies on
brew "zoxide"      # Smart directory jumper (`z` lazy-loader in zshrc)
brew "fnm"         # Node version manager with --use-on-cd
brew "jq"          # Used by the `json` alias
brew "gh"          # GitHub CLI (gitconfig credential helper)
brew "git"
brew "git-lfs"     # Referenced by gitconfig [filter "lfs"]
brew "tmux"
brew "vim"

# Optional language version managers (lazy-loaded in zshrc)
brew "rbenv"
brew "pyenv"
brew "nvm"

# JavaScript runtimes
brew "bun"
brew "pnpm"

# Infisical CLI (for the `i`, `ir`, `iu`, etc. aliases)
brew "infisical/get-cli/infisical"

# OrbStack (Docker shim) — referenced by zprofile
cask "orbstack"
