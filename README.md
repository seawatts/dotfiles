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
   git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. Run the setup script:
   ```bash
   ./setup.sh
   ```

3. Restart your terminal or run:
   ```bash
   source ~/.zshrc
   ```

## Manual Installation

If you prefer to install manually:

1. Create symlinks:
   ```bash
   ln -s ~/dotfiles/zshrc ~/.zshrc
   ln -s ~/dotfiles/zprofile ~/.zprofile
   ln -s ~/dotfiles/zshenv ~/.zshenv
   ```

2. Install Vim plugins:
   ```bash
   vim +PluginInstall +qall
   ```

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