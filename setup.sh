#!/bin/bash

# Function to safely move and link a dotfile
move_and_link() {
    local source="$1"
    local target="$2"

    # If the source is a directory, create it in dotfiles
    if [ -d "$source" ]; then
        if [ ! -d "$target" ]; then
            mkdir -p "$target"
        fi
        # Move contents if directory exists and isn't empty
        if [ -d "$source" ] && [ "$(ls -A $source)" ]; then
            cp -r "$source"/* "$target/"
        fi
    else
        # For regular files
        if [ -f "$source" ]; then
            cp "$source" "$target"
        fi
    fi

    # Remove the original if it's not a symlink
    if [ ! -L "$source" ]; then
        rm -rf "$source"
    fi

    # Create symbolic link
    ln -sf "$target" "$source"
}

# Create necessary directories
mkdir -p ~/dotfiles/{vim,tmux,git}

# Move and link essential dotfiles
move_and_link ~/.zshrc ~/dotfiles/zshrc
move_and_link ~/.zshenv ~/dotfiles/zshenv
move_and_link ~/.zprofile ~/dotfiles/zprofile
move_and_link ~/.vimrc ~/dotfiles/vim/vimrc
move_and_link ~/.vim ~/dotfiles/vim/vim
move_and_link ~/.tmux.conf ~/dotfiles/tmux/tmux.conf
move_and_link ~/.tmuxinator ~/dotfiles/tmux/tmuxinator

# Git configuration
if [ -f ~/dotfiles/git/gitconfig ]; then
    move_and_link ~/.gitconfig ~/dotfiles/git/gitconfig
fi

# Global gitignore
if [ -f ~/dotfiles/git/gitignore_global ]; then
    move_and_link ~/.gitignore_global ~/dotfiles/git/gitignore_global
fi

echo "Dotfiles have been moved and linked successfully!"
echo "Please review the changes and commit them to your repository."