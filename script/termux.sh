#!/data/data/com.termux/files/usr/bin/bash

#Colors
RED=$(printf '\033[31m')
GREEN=$(printf '\033[32m')
YELLOW=$(printf '\033[33m')
BLUE=$(printf '\033[34m')
BOLD=$(printf '\033[1m')
RESET=$(printf '\033[m')

BACKUP="$HOME/storage/shared/termux" 

PROGRAMAS=(
    x11-repo
    util-linux
    procps
    openssh
    tmux
    git
    zsh
    wget
    vim-gtk
)

echo "${BLUE}# === === === STORAGE === === === #${RESET}"
apt update -y && apt upgrade -y
termux-setup-storage

echo "${BLUE}# === === === INSTALL PKG's === === === #${RESET}"
pkg update -y
for programa in ${PROGRAMAS[@]}; do
    echo "${GREEN}[INSTALLING] - $programa${RESET}"
    pkg install "$programa" -y
done

echo "${BLUE}# === === === OTHERS === === === #${RESET}"
echo "${YELLOW}# ASDF${RESET}"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0

if [ -d "$BACKUP" ] 
then
    echo "${YELLOW}# BACKUP${RESET}"
    cp -r "$BACKUP/." "$HOME"
fi

echo "${BLUE}# !!!! ENCERRADO !!!! #${RESET}"