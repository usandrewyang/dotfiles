#!/usr/bin/env zsh
# Initialize a fresh macOS laptop with this dotfiles config.
# Idempotent: safe to re-run.
set -euo pipefail

DOTFILES_REPO="git@github.com:usandrewyang/dotfiles.git"
DOTFILES_DIR="$HOME/work/dotfiles"

log() { print -P "%F{cyan}==>%f $*"; }
warn() { print -P "%F{yellow}!! $*%f"; }

# 1. Xcode Command Line Tools
if ! xcode-select -p &>/dev/null; then
  log "Installing Xcode Command Line Tools (accept the GUI prompt)"
  xcode-select --install
  warn "Re-run this script after CLT install completes."
  exit 0
fi

# 2. Homebrew
if ! command -v brew &>/dev/null; then
  log "Installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Apple Silicon vs Intel brew prefix
if [[ -x /opt/homebrew/bin/brew ]]; then
  BREW_PREFIX=/opt/homebrew
else
  BREW_PREFIX=/usr/local
fi
eval "$("$BREW_PREFIX/bin/brew" shellenv zsh)"

# 3. Clone dotfiles
if [[ ! -d "$DOTFILES_DIR" ]]; then
  log "Cloning dotfiles to $DOTFILES_DIR"
  mkdir -p "$(dirname "$DOTFILES_DIR")"
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

# 4. Brew bundle
log "Installing brew packages from Brewfile"
brew bundle --file="$DOTFILES_DIR/Brewfile"

# 5. Oh My Zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  log "Installing Oh My Zsh"
  RUNZSH=no KEEP_ZSHRC=yes sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# 6. Symlink dotfiles
link() {
  local src=$1 dst=$2
  if [[ -L "$dst" ]]; then
    rm "$dst"
  elif [[ -e "$dst" ]]; then
    log "Backing up existing $dst -> $dst.bak"
    mv "$dst" "$dst.bak"
  fi
  ln -s "$src" "$dst"
  log "Linked $dst -> $src"
}

link "$DOTFILES_DIR/zshrc"      "$HOME/.zshrc"
link "$DOTFILES_DIR/zprofile"   "$HOME/.zprofile"
link "$DOTFILES_DIR/vim/vimrc"  "$HOME/.vimrc"
link "$DOTFILES_DIR/tmux.conf"  "$HOME/.tmux.conf"
link "$DOTFILES_DIR/gitconfig"  "$HOME/.gitconfig"

# ssh config
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
link "$DOTFILES_DIR/ssh/config" "$HOME/.ssh/config"

# iTerm2: load/save preferences from the repo-tracked plist
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$DOTFILES_DIR/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# 7. macOS system defaults
if [[ -x "$DOTFILES_DIR/macos-defaults.sh" ]]; then
  log "Applying macOS defaults"
  "$DOTFILES_DIR/macos-defaults.sh"
fi

log "Done. Open a new terminal to pick up the new shell config."
log "To capture currently-installed App Store apps: mas list"
