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
org.gnome.Boxes \
com.getpostman.Postman \
com.obsproject.Studio \
de.haeckerfelix.Fragments

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

# Apply images
mkdir -p ~/.local/share/backgrounds
cp ./wallpaper.jpg ~/.local/share/backgrounds/wallpaper.jpg
sudo cp ./avatar.jpg /var/lib/AccountsService/icons/$USER

# Clean up unecessary packages
sudo dnf autoremove -y

# Define GNOME settings on next boot
mkdir -p ~/.config/systemd/user

cat <<EOT > ~/.config/systemd/user/gsettings.service
[Unit]
Description=Configurar Extensões
After=graphical-session.target

[Service]
Type=oneshot
ExecStart=$(pwd)/gsettings.sh

[Install]
WantedBy=graphical-session.target
EOT

systemctl --user daemon-reload
systemctl --user enable gsettings.service
