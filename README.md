# Dotfiles

My personal dotfiles configuration for macOS.

## What's Included

- **Zsh Configuration** - Optimized with lazy loading for fast startup
- **Vim Configuration** - Using Vundle for plugin management
- **Git Configuration** - Basic git setup
- **Tmux Configuration** - Terminal multiplexer setup

## Features

### Zsh Optimizations
- **Lazy Loading** - Tools load only when needed (NVM, Go, Mise, Bun, Pyenv, Zoxide)
- **Fast Startup** - ~0.35s shell startup time
- **Git Completion** - Optimized git tab completion
- **Oh My Zsh** - With minimal plugins for performance

### Lazy-Loaded Tools
- `nvm` - Node Version Manager
- `go` - Go environment
- `mise` - Tool version manager
- `bun` - JavaScript runtime
- `pyenv` - Python version manager
- `zoxide` - Smart directory jumping
- `rbenv` - Ruby version manager

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/seawatts/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. Run the setup script (installs Homebrew, the `Brewfile` deps, Oh My Zsh,
   OMZ custom plugins, symlinks dotfiles, and pulls Vim plugins):
   ```bash
   ./setup.sh
   ```

3. Open a new terminal, or run:
   ```bash
   source ~/.zshrc
   ```

The script is idempotent — re-running it is safe and will only fill in what's
missing.

## What's in the Brewfile

CLI tools the zsh config relies on (`zoxide`, `fnm`, `jq`, `gh`, `git-lfs`,
`tmux`, `vim`), language version managers (`rbenv`, `pyenv`, `nvm`), JS
runtimes (`bun`, `pnpm`), Infisical CLI, and OrbStack. Edit `Brewfile` and
re-run `brew bundle --file=~/dotfiles/Brewfile` to apply changes.

## Requirements

- macOS (tested on macOS 14+)
- Zsh
- Oh My Zsh
- Vim with Vundle
- Homebrew (for various tools)

## Tools Used

- **Shell**: Zsh with Oh My Zsh
- **Editor**: Vim with Vundle
- **Terminal**: iTerm2 or Terminal.app
- **Package Manager**: Homebrew
- **Version Managers**: NVM, Pyenv, Rbenv, Mise
- **Directory Navigation**: Zoxide

## Performance

- **Shell Startup**: ~0.35 seconds
- **Git Completion**: Optimized to exclude remote branches
- **Lazy Loading**: All heavy tools load only when needed

## Contributing

Feel free to submit issues and enhancement requests!

## License

MIT License - feel free to use these dotfiles as a starting point for your own configuration.