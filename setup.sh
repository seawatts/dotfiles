#!/bin/bash
# setup.sh — bootstrap this dotfiles repo on a fresh Mac.
# Idempotent: safe to re-run.

set -e
DOTFILES="${DOTFILES:-$HOME/dotfiles}"

# ----------------------------------------------------------------------------
# 1. Homebrew
# ----------------------------------------------------------------------------
if ! command -v brew >/dev/null 2>&1; then
    echo "==> Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# ----------------------------------------------------------------------------
# 2. Brewfile dependencies
# ----------------------------------------------------------------------------
if [ -f "$DOTFILES/Brewfile" ]; then
    echo "==> Installing Brewfile packages..."
    brew bundle --file="$DOTFILES/Brewfile"
fi

# ----------------------------------------------------------------------------
# 3. Oh My Zsh
# ----------------------------------------------------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "==> Installing Oh My Zsh..."
    RUNZSH=no KEEP_ZSHRC=yes CHSH=no \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# ----------------------------------------------------------------------------
# 4. OMZ custom plugins (pnpm, bun) referenced by zshrc `plugins=(...)`
# ----------------------------------------------------------------------------
OMZ_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$OMZ_CUSTOM/plugins"

clone_plugin() {
    local name="$1"
    local url="$2"
    local dest="$OMZ_CUSTOM/plugins/$name"
    if [ ! -d "$dest" ]; then
        echo "==> Installing OMZ plugin: $name"
        git clone "$url" "$dest"
    fi
}
clone_plugin pnpm https://github.com/ntnyq/omz-plugin-pnpm.git
clone_plugin bun  https://github.com/ntnyq/omz-plugin-bun.git

# ----------------------------------------------------------------------------
# 5. Symlinks: ~/.* -> $DOTFILES/*
# ----------------------------------------------------------------------------
link() {
    local target="$1"  # path inside dotfiles
    local link="$2"    # path in home
    # Back up any non-symlink that's in the way (one-time per machine)
    if [ -e "$link" ] && [ ! -L "$link" ]; then
        local ts; ts="$(date +%Y%m%d-%H%M%S)"
        echo "    backing up $link -> $link.bak.$ts"
        mv "$link" "$link.bak.$ts"
    fi
    ln -sfn "$target" "$link"
}

echo "==> Linking dotfiles..."
link "$DOTFILES/zshrc"             "$HOME/.zshrc"
link "$DOTFILES/zshenv"            "$HOME/.zshenv"
link "$DOTFILES/zprofile"          "$HOME/.zprofile"
link "$DOTFILES/vim/vimrc"         "$HOME/.vimrc"
link "$DOTFILES/vim/vim"           "$HOME/.vim"
link "$DOTFILES/tmux/tmux.conf"    "$HOME/.tmux.conf"
[ -d "$DOTFILES/tmux/tmuxinator" ] && link "$DOTFILES/tmux/tmuxinator" "$HOME/.tmuxinator"
[ -f "$DOTFILES/git/gitconfig" ]        && link "$DOTFILES/git/gitconfig"        "$HOME/.gitconfig"
[ -f "$DOTFILES/git/gitignore_global" ] && link "$DOTFILES/git/gitignore_global" "$HOME/.gitignore_global"

# ----------------------------------------------------------------------------
# 6. Vim plugins (Vundle is a submodule under vim/vim/bundle/Vundle.vim)
# ----------------------------------------------------------------------------
if [ -d "$DOTFILES/.git" ]; then
    git -C "$DOTFILES" submodule update --init --recursive
fi
if command -v vim >/dev/null 2>&1 && [ -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    vim +PluginInstall +qall || true
fi

echo
echo "Done. Open a new terminal or run: source ~/.zshrc"
