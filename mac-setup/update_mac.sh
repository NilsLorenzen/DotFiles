#!/usr/bin/env bash
set -euo pipefail
echo "Das Mac Update Script wurde gestartet"

sudo -v

# Homebrew aktualisieren
echo "Aktualisiere Homebrew"
brew update

echo "Aktualisiere Homebrew Apps"
brew upgrade

echo "Säubere Homebrew"
brew cleanup

echo "Aktualisiere oh-my-zsh"
omz update

# =============================================================================================
echo "Aktualisiere Config-Files (Symlinks aktualisieren)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
TS="$(date +%s)"

# Symlink Funktion
safe_link() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "Symlink already correct: $dst"
    return
  fi
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "Backing up $dst -> ${dst}.backup.$TS"
    mv "$dst" "${dst}.backup.$TS"
  else
    rm -f "$dst"
  fi
  ln -s "$src" "$dst"
  echo "Linked: $dst -> $src"
}

safe_link "$REPO_ROOT/mac-setup/zshrc-mac" "$HOME/.zshrc"
safe_link "$REPO_ROOT/mac-setup/p10k.zsh-mac" "$HOME/.p10k.zsh"
safe_link "$REPO_ROOT/global-setup/aliases.zsh" "$HOME/.oh-my-zsh/custom/aliases.zsh"
safe_link "$REPO_ROOT/global-setup/gitconfig" "$HOME/.gitconfig"
safe_link "$REPO_ROOT/global-setup/gitignore" "$HOME/.gitignore"

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
safe_link "$REPO_ROOT/global-setup/ssh-config" "$HOME/.ssh/config"
chmod 600 "$HOME/.ssh/config"

# =============================================================================================
echo "Das Mac Update Script ist abgeschlossen"
