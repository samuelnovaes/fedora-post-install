#!/bin/bash

sleep 5

gsettings set org.gnome.desktop.background picture-uri "file://$HOME/.local/share/backgrounds/wallpaper.jpg"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$HOME/.local/share/backgrounds/wallpaper.jpg"
gsettings set org.gnome.desktop.interface enable-hot-corners false
gsettings set org.gnome.desktop.interface accent-color purple
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
gsettings set org.gnome.desktop.interface cursor-theme breeze_cursors
gsettings set org.gnome.shell favorite-apps "['google-chrome.desktop', 'code.desktop', 'org.gnome.Ptyxis.desktop', 'com.mongodb.Compass.desktop', 'com.spotify.Client.desktop', 'com.discordapp.Discord.desktop', 'io.podman_desktop.PodmanDesktop.desktop', 'org.gnome.Nautilus.desktop', 'com.getpostman.Postman.desktop']"
gsettings set org.gnome.shell enabled-extensions "['appindicatorsupport@rgcjonas.gmail.com', 'dash-to-dock@micxgx.gmail.com', 'blur-my-shell@aunetx']"
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'br')]"

sleep 5

gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode DYNAMIC
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true
gsettings set org.gnome.shell.extensions.dash-to-dock multi-monitor true

sleep 5

gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock blur false

systemctl --user disable gsettings.service
rm ~/.config/systemd/user/gsettings.service