# ⚙️ DotFiles von @NilsLorenzen 

Dieses Repository enthält meine persönlichen Konfigurationsdateien (Dotfiles) und Install-/Update-Skripte für macOS, Linux und perspektivisch auch Windows.
Ziel ist meine, Systeme schnell mit einer einheitlichen Shell-, Terminal- und Tool-Umgebung einzurichten.

## Inhalt
- global-setup/ — gemeinsame Konfigurationsdateien (Aliases, gitconfig, SSH-Config)
- mac-setup/ — macOS Install- und Update-Skripte, p10k/zsh-Configs, iTerm-Profil
- linux-setup/ — Linux Install- und Update-Skripte, p10k/zsh-Configs
- windows-setup/ — Platzhalter (aktuell leer)

## Voraussetzungen
- Git
- Für Linux werden aktuell nur Debian basierte Distros unterstützt, da apt verwendet wird
- Terminal App mit Nerd-Font (z. B. Mononoki Nerd Font) für Powerlevel10k

## Installation
Die Skripte installieren Packages, Themes (Powerlevel10k), ZSH-Plugins und erzeugen Symlinks zu den Konfigurationsdateien.

- Repo klonen:
   - `git clone git@github.com:NilsLorenzen/DotFiles.git` oder
   - `git clone https://github.com/NilsLorenzen/DotFiles.git`

- macOS:
   - `cd ~/Coding/DotFiles/mac-setup`
   &rarr; `bash install_mac.sh`

- Linux:
   - `cd ~/Coding/DotFiles/linux-setup`
   &rarr; `bash install_linux.sh`

## Update
Die Update-Skripte aktualisieren Paketmanager, oh-my-zsh und erneuern die Symlinks.

- Repo regelmässig pullen:
   - `git pull`

- macOS:
   - `cd ~/Coding/DotFiles/mac-setup`
   &rarr; `zsh update_mac.sh`

- Linux:
   - `cd ~/Coding/DotFiles/linux-setup`
   &rarr; `zsh update_linux.sh`

## ⁉️ Hinweise / Häufige Probleme
- Secrets / Passwörter / SSH-Keys werden nicht im Repo gespeichert. Es gibt Platzhalter unter `~/passwords/` (z. B. `nlo`).
- iTerm2-Config muss ggf. manuell importiert werden (Datei: `mac-setup/iTermConfigNils.json`).
- Manche homebrew casks erfordern bei der ersten Ausführung zusätzliche macOS-Berechtigungen.
- Font-Icons fehlen: Stelle sicher, dass der verwendete Nerd-Font in Terminal/iTerm gesetzt ist.