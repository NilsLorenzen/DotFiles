#!/bin/zsh
echo "Das Mac Update Script wurde gestartet"

sudo -v

# Homebrew für Cask aktualisieren
echo "Aktualisiere Homebrew"
brew update

echo "Aktualisiere Homebrew Apps"
brew upgrade

echo "Säubere Homebrew"
brew cleanup

echo "Aktualisiere oh-my-zsh"
omz update

# =============================================================================================

echo "Aktualisiere Config-Files"
cp -v zshrc-mac ~/.zshrc
cp -v p10k.zsh-mac ~/.p10k.zsh
cp -v ../global-setup/aliases.zsh ~/.oh-my-zsh/custom/aliases.zsh
cp -v ../global-setup/gitconfig ~/.gitconfig
cp -v ../global-setup/ssh-config ~/.ssh/config

# =============================================================================================

echo "Das Mac Update Script ist abgeschlossen"
