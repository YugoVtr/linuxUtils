#!/bin/bash

# Only use colors if connected to a terminal
if [ -t 1 ]; then
    RED=$(printf '\033[31m')
    GREEN=$(printf '\033[32m')
    YELLOW=$(printf '\033[33m')
    BLUE=$(printf '\033[34m')
    BOLD=$(printf '\033[1m')
    RESET=$(printf '\033[m')
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    RESET=""
fi

echo "${BLUE}# === === === === === === === === VARIAVEIS === === === === === === === === #${RESET}"
REPOSITORIOS=(
    "ppa:daniruiz/flat-remix"
)

PROGRAMAS=(
    build-essential
    default-jdk
    libssl-dev
    fontconfig
    imagemagick
    software-properties-common
    apt-transport-https
    ca-certificates
    git
    git-svn
    vim-gtk3
    tmux
    plank
    curl
    svn
    gnupg-agent
    zsh
    fonts-firacode
    snapd
    flat-remix
    flat-remix-gtk
    dconf-cli
    flameshot
)

FLATPAKS=(
    "com.wps.Office"
    "com.github.hluk.copyq"
    "com.spotify.Client"
    "org.inkscape.Inkscape"
    "com.discordapp.Discord"
    "org.videolan.VLC"
    "org.telegram.desktop"
)

SNAPS=(
    insomnia
    photogimp
)

DOWNLOADS="$HOME/Downloads/programas"

echo "${BLUE}# === === === === === === === === INSTALAR === === === === === === === === #${RESET}"

echo "${YELLOW}# Atualizar repositorios${RESET}"
sudo apt update -y

echo "${YELLOW}# Adicionar repositorios${RESET}"
for repositorio in ${REPOSITORIOS[@]}; do
    sudo add-apt-repository "$repositorio" -y
done

echo "${YELLOW}# Atualizar repositorios${RESET}"
sudo apt update -y

echo "${YELLOW}# Instalar programas no apt${RESET}"
for programa in ${PROGRAMAS[@]}; do
    echo "${GREEN}[INSTALANDO] - $programa${RESET}"
    apt install "$programa" -y
done

echo "${YELLOW}# Atualizar repositorios${RESET}"
sudo apt update -y

echo "${YELLOW}# Instalar programas flatpak${RESET}"
for programa in ${FLATPAKS[@]}; do
    if ! flatpak list | grep -q $programa; then
        echo "${GREEN}[INSTALANDO] - $programa${RESET}"
        flatpak install flathub "$programa" -y
    else
        echo "${RED}[INSTALADO] - $programa${RESET}"
    fi
done

echo "${YELLOW}# Instalar programas snap${RESET}"
for programa in ${SNAPS[@]}; do
    if ! snap list | grep -q $programa; then
        echo "${GREEN}[INSTALANDO] - $programa${RESET}"
        sudo snap install "$programa"
    else
        echo "${RED}[INSTALADO] - $programa${RESET}"
    fi
done

echo "${YELLOW}# Download and install .DEB files${RESET}"
mkdir "$DOWNLOADS"
cd "$DOWNLOADS"
wget -O vscode.deb -c "https://go.microsoft.com/fwlink/?LinkID=760868" &&
wget -O gitkraken.deb -c "https://release.gitkraken.com/linux/gitkraken-amd64.deb" &&
wget -O teams.deb -c "https://go.microsoft.com/fwlink/p/?linkid=2112886&clcid=0x416&culture=pt-br&country=br" &&
wget -O virtualbox.deb -c "https://download.virtualbox.org/virtualbox/6.1.6/virtualbox-6.1_6.1.6-137129~Ubuntu~bionic_amd64.deb" &&
sudo dpkg -i $DOWNLOADS/*.deb

echo "${BLUE}# === === === === === === === === OUTROS === === === === === === === === #${RESET}"
echo "${YELLOW}# ASDF${RESET}"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8

echo "${YELLOW}# Finalizando${RESET}"
sudo apt-get --fix-broken install &&
sudo apt update -y && 
sudo apt dist-upgrade -y &&
flatpak update -y &&
sudo apt autoclean -y &&
sudo apt autoremove -y &&

echo "${BLUE}# !!!! ENCERRADO !!!! #${RESET}"
