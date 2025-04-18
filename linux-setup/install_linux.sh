#!/bin.bash
echo "Das Linux Install Script wurde gestartet"

sudo apt update
sudo apt upgrade


sudo apt install zsh git htop glances zip unzip mc -y

sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y

echo "Install Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installiere Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh ist bereits installiert."
fi

echo "Install ZSH Plugins"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# =============================================================================================

echo "Kopiere Config-Files"
cp -v zshrc-linux ~/.zshrc
cp -v p10k.zsh-linux ~/.p10k.zsh
cp -v ../global-setup/aliases.zsh ~/.oh-my-zsh/custom/aliases.zsh
cp -v ../global-setup/gitconfig ~/.gitconfig
mkdir ~/.ssh
cp -v ../global-setup/ssh-config ~/.ssh/config
mkdir ~/passwords
touch "$HOME/passwords/nlo"

# =============================================================================================

echo "Das Linux Install Script ist abgeschlossen"
echo "manuelle Todos:"
echo "- $HOME/passwords/nlo füllen"
echo "- $HOME/.ssh/ mit SSH-Keys füllen"
