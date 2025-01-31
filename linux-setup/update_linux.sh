#!/bin/zsh
echo "Das Linux Update Script wurde gestartet"

echo "Aktualisiere apt repos"
sudo apt update

echo "installiere aktualisierte apt packages"
sudo apt upgrade

# =============================================================================================

echo "Aktualisiere Config-Files"
cp -v zshrc-linux ~/.zshrc
cp -v p10k.zsh-linux ~/.p10k.zsh
cp -v ../global-setup/aliases.zsh ~/.oh-my-zsh/custom/aliases.zsh
cp -v ../global-setup/gitconfig ~/.gitconfig
cp -v ../global-setup/ssh-config ~/.ssh/config

# =============================================================================================

echo "Das Linux Update Script ist abgeschlossen"
