#!/usr/bin/env bash
set -euo pipefail
echo "Das Mac Install Script wurde gestartet"

sudo -v

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
TS="$(date +%s)"

# Symlink Funktion
link_file() {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")"

  if [ -L "$dst" ]; then
    # bereits Symlink -> prüfen ob korrekt
    if [ "$(readlink "$dst")" = "$src" ]; then
      echo "Symlink exists and is correct: $dst -> $src"
      return 0
    else
      echo "Removing stale symlink: $dst"
      rm -f "$dst"
    fi
  fi

  if [ -e "$dst" ]; then
    echo "Backing up existing file: $dst -> ${dst}.backup.$TS"
    mv "$dst" "${dst}.backup.$TS"
  fi

  ln -s "$src" "$dst"
  echo "Linked: $dst -> $src"
}

# Überprüfen, ob Homebrew installiert ist
if ! command -v brew &> /dev/null; then
  echo "Homebrew ist nicht installiert. Starte Installation..."
  
  # Homebrew installieren
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew ist bereits installiert."
fi

# Homebrew aktualisieren
echo "Aktualisiere Homebrew..."
brew update
brew upgrade

echo "Install Iterm2"
brew install --cask iterm2

echo "Install git"
brew install git

echo "Install zsh"
brew install zsh

echo "Install Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installiere Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh ist bereits installiert."
fi

echo "Install Font for ITerm2"
brew install --cask font-mononoki-nerd-font

echo "Install ZSH Plugins"
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting

echo "Install Google Brave Browser"
brew install --cask brave-browser

echo "Install Mozilla Firefox Browser"
brew install --cask firefox

echo "Install Scroll Reverser"
brew install --cask scroll-reverser

echo "Install Visual Studio Code"
brew install --cask visual-studio-code

echo "Install GitHub Desktop"
brew install --cask github

echo "Install Wireshark"
brew install --cask wireshark

echo "Install Docker"
brew install --cask docker

echo "Install Ansible"
brew install ansible

echo "Install Spotify"
brew install --cask spotify

echo "Install bitwarden"
brew install --cask bitwarden

echo "Install Postman"
brew install --cask postman

echo "Install VLC Player"
brew install --cask vlc

echo "Install OBS Screencapture"
brew install --cask obs

echo "Install Whatsapp"
brew install --cask whatsapp

echo "Install Discord"
brew install --cask discord

echo "Install Teamspeak 5 Beta"
brew install --cask teamspeak-client@beta

echo "Install Plex Player"
brew install --cask plex

echo "Install Bambu Studio Slicer for 3D Printers"
brew install --cask bambu-studio

echo "Install Adobe Creative Cloud"
brew install --cask adobe-creative-cloud

echo "Install Surfshark VPN Client"
brew install --cask surfshark

echo "Install Wifiman for Speedtest and local VPN"
brew install --cask wifiman

echo "Install iGlance Ressource Monitor for traymenu - https://github.com/iglance/iGlance"
brew install --cask iglance

echo "Install DisplayLink for Docking Stations"
brew install --cask displaylink

echo "Install PowerLevel10k for zsh"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Install node.js"
brew install node

echo "Install dotnet 8"
brew install dotnet@8

# =============================================================================================
echo "Kopiere Config-Files (erstelle Symlinks)"
# benutze absolute Pfade aus dem Repo
link_file "$REPO_ROOT/mac-setup/zshrc-mac" "$HOME/.zshrc"
link_file "$REPO_ROOT/mac-setup/p10k.zsh-mac" "$HOME/.p10k.zsh"
link_file "$REPO_ROOT/global-setup/aliases.zsh" "$HOME/.oh-my-zsh/custom/aliases.zsh"
link_file "$REPO_ROOT/global-setup/gitconfig" "$HOME/.gitconfig"
link_file "$REPO_ROOT/global-setup/gitignore" "$HOME/.gitignore"

# SSH config
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
link_file "$REPO_ROOT/global-setup/ssh-config" "$HOME/.ssh/config"
chmod 600 "$HOME/.ssh/config"

# passwords placeholder
mkdir -p "$HOME/passwords"
touch "$HOME/passwords/nlo"
chmod 600 "$HOME/passwords/nlo"

# =============================================================================================
echo "Das Mac Install Script ist abgeschlossen"
echo "manuelle Todos:"
echo "- iTerm2 config Datei einspielen"
echo "- Scroll Reverser einstellen: vertikal und horizontal umkehren + trackpad umkehren"
echo "- $HOME/passwords/nlo füllen"
echo "- $HOME/.ssh/ mit SSH-Keys füllen"
