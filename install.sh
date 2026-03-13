#!/bin/bash

# Remove unwanted packages
sudo dnf remove -y \
firefox \
gnome-contacts \
gnome-weather \
gnome-clocks \
gnome-maps \
libreoffice-* \
gnome-boxes \
snapshot \
gnome-connections \
yelp \
gnome-tour \
malcontent-control \
gnome-calendar \
gnome-shell-extension-*

# Install wanted packages
sudo dnf install -y \
google-chrome-stable \
gnome-shell-extension-appindicator \
gnome-shell-extension-dash-to-dock \
gnome-shell-extension-blur-my-shell \
papirus-icon-theme \
breeze-cursor-theme \
adw-gtk3-theme \
jetbrains-mono-fonts \
fastfetch \
timeshift \
akmod-nvidia \
steam

# Install flatpaks
flatpak install -y flathub \
io.podman_desktop.PodmanDesktop \
com.mongodb.Compass \
com.spotify.Client \
com.discordapp.Discord \
io.github.nozwock.Packet \
org.gnome.Boxes

# Config git
git config --global user.name "Samuel Novaes"
git config --global user.email "samuel.novaes.96@gmail.com"
git config --global core.editor nano
git config --global init.defaultBranch main

# Install bash-it for local user
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
rm -rf ~/.bashrc
~/.bash_it/install.sh
nano ~/.bashrc

# Install bash-it for root
sudo su -c 'git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it'
sudo su -c 'rm -rf ~/.bashrc'
sudo su -c '~/.bash_it/install.sh'
sudo su -c 'nano ~/.bashrc'

# Install vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc && echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update
sudo dnf install -y code

# Install nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install --lts
npm i -g npm

## Install Go
GO_VERSION=$(curl -sSL "https://go.dev/VERSION?m=text" | head -n 1)
GO_TARBALL=$GO_VERSION.linux-amd64.tar.gz
wget -P /tmp https://go.dev/dl/$GO_TARBALL
sudo tar -C /usr/local -xzf /tmp/$GO_TARBALL
echo | sudo tee -a /etc/profile > /dev/null
echo "export PATH=\$PATH:/usr/local/go/bin" | sudo tee -a /etc/profile > /dev/null

# Gnome settings
mkdir -p ~/.local/share/backgrounds
cp ./wallpaper.jpg ~/.local/share/backgrounds/wallpaper.jpg
sudo cp ./avatar.jpg /var/lib/AccountsService/icons/$USER
gsettings set org.gnome.desktop.background picture-uri "file://$HOME/.local/share/backgrounds/wallpaper.jpg"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$HOME/.local/share/backgrounds/wallpaper.jpg"
gsettings set org.gnome.desktop.interface enable-hot-corners false
gsettings set org.gnome.desktop.interface accent-color purple
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
gsettings set org.gnome.desktop.interface cursor-theme breeze_cursors
gsettings set org.gnome.shell favorite-apps "['google-chrome.desktop', 'code.desktop', 'org.gnome.Ptyxis.desktop', 'com.mongodb.Compass.desktop', 'com.spotify.Client.desktop', 'com.discordapp.Discord.desktop', 'io.podman_desktop.PodmanDesktop.desktop', 'org.gnome.Nautilus.desktop']"
gsettings set org.gnome.shell enabled-extensions "['appindicatorsupport@rgcjonas.gmail.com', 'dash-to-dock@micxgx.gmail.com', 'blur-my-shell@aunetx']"
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'br')]"

# Clean up unecessary packages
sudo dnf autoremove -y