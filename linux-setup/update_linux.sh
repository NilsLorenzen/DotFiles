#!/usr/bin/env bash
set -euo pipefail
echo "Das Linux Update Script wurde gestartet"

#sudo -v

echo "Aktualisiere apt Repositories und Pakete"
sudo apt update
sudo apt upgrade -y

# aktualisiere oh-my-zsh falls verfügbar
if command -v omz &>/dev/null; then
  echo "Aktualisiere oh-my-zsh"
  omz update || true
fi

# =============================================================================================
echo "Aktualisiere Config-Files (Symlinks aktualisieren)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
TS="$(date +%s)"

safe_link() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "Symlink korrekt: $dst"
    return 0
  fi
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "Sichere $dst -> ${dst}.backup.$TS"
    mv "$dst" "${dst}.backup.$TS"
  else
    rm -f "$dst"
  fi
  ln -s "$src" "$dst"
  echo "Angelegt: $dst -> $src"
}

safe_link "$REPO_ROOT/linux-setup/zshrc-linux" "$HOME/.zshrc"
safe_link "$REPO_ROOT/linux-setup/p10k.zsh-linux" "$HOME/.p10k.zsh"
mkdir -p "$HOME/.oh-my-zsh/custom"
safe_link "$REPO_ROOT/global-setup/aliases.zsh" "$HOME/.oh-my-zsh/custom/aliases.zsh"
safe_link "$REPO_ROOT/global-setup/gitconfig" "$HOME/.gitconfig"

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
safe_link "$REPO_ROOT/global-setup/ssh-config" "$HOME/.ssh/config"
chmod 600 "$HOME/.ssh/config"

echo "Das Linux Update Script ist abgeschlossen"
