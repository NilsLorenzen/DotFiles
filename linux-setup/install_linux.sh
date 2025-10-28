#!/usr/bin/env bash
set -euo pipefail
echo "Das Linux Install Script wurde gestartet"

#sudo -v

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
TS="$(date +%s)"

# Symlink Funktion
link_file() {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")"

  if [ -L "$dst" ]; then
    if [ "$(readlink "$dst")" = "$src" ]; then
      echo "Symlink korrekt: $dst -> $src"
      return 0
    else
      echo "Entferne verwaisten Symlink: $dst"
      rm -f "$dst"
    fi
  fi

  if [ -e "$dst" ]; then
    echo "Sichere vorhandene Datei: $dst -> ${dst}.backup.$TS"
    mv "$dst" "${dst}.backup.$TS"
  fi

  ln -s "$src" "$dst"
  echo "Angelegt: $dst -> $src"
}

echo "Aktualisiere apt Repositories und Pakete"
sudo apt update
sudo apt upgrade -y

echo "Installiere Basis-Pakete"
sudo apt install -y zsh git htop glances zip unzip mc curl software-properties-common

echo "Installiere Ansible (PPA)"
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt update
sudo apt install -y ansible

# Oh My Zsh installieren
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installiere Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true
else
  echo "Oh My Zsh ist bereits installiert."
fi

# Powerlevel10k Theme
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "${ZSH_CUSTOM}/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k"
else
  echo "powerlevel10k bereits vorhanden."
fi

# ZSH-Plugins
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
fi
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
fi

# =============================================================================================
echo "Erstelle/aktualisiere Symlinks für Configs"
link_file "$REPO_ROOT/linux-setup/zshrc-linux" "$HOME/.zshrc"
link_file "$REPO_ROOT/linux-setup/p10k.zsh-linux" "$HOME/.p10k.zsh"
mkdir -p "$HOME/.oh-my-zsh/custom"
link_file "$REPO_ROOT/global-setup/aliases.zsh" "$HOME/.oh-my-zsh/custom/aliases.zsh"
link_file "$REPO_ROOT/global-setup/gitconfig" "$HOME/.gitconfig"

# SSH config
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
link_file "$REPO_ROOT/global-setup/ssh-config" "$HOME/.ssh/config"
chmod 600 "$HOME/.ssh/config"

# passwords placeholder
mkdir -p "$HOME/passwords"
touch "$HOME/passwords/nlo"
chmod 600 "$HOME/passwords/nlo"
touch "$HOME/passwords/haustracker"
chmod 600 "$HOME/passwords/haustracker"

# =============================================================================================
echo "Das Linux Install Script ist abgeschlossen"
echo "manuelle Todos:"
echo "- $HOME/passwords/* füllen"
echo "- SSH-Keys in $HOME/.ssh/ ablegen"
