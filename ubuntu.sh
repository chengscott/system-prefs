#!/bin/bash -xe
function step { echo -e "\n: \e[32m$1\e[0m\n" ; }

step 'Install Utils'
sudo apt update
sudo apt install -y --no-install-recommends \
  vim fish tmux git curl aria2 tree htop \
  fcitx fcitx-chewing \
  python-dev python-pip python3-dev python3-pip python3-setuptools

step 'Install Chromium'
sudo apt install -y --install-recommends chromium-browser
sudo update-alternatives --set x-www-browser /usr/bin/chromium-browser
sudo update-alternatives --set gnome-www-browser /usr/bin/chromium-browser
xdg-settings set default-web-browser chromium-browser.desktop
sudo apt purge -y webbrowser-app firefox

step 'Install VSCode'
sudo apt install -y apt-transport-https
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install code

step 'Paper Theme'
sudo add-apt-repository ppa:snwh/ppa &&\
  sudo apt update &&\
  sudo apt install -y paper-icon-theme &&\
  #gsettings set org.gnome.desktop.interface gtk-theme "Paper" &&\
  gsettings set org.gnome.desktop.interface icon-theme "Paper" &&\
  gsettings set org.gnome.desktop.interface cursor-theme "Paper"
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"

step 'Setup Powerline'
sudo apt install -y powerline
echo "powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
source /usr/share/powerline/bindings/bash/powerline.sh
" >> ~/.bashrc
git clone https://github.com/powerline/fonts &&\
  cd fonts && sh ./install.sh

step 'Config'
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N '' -q
gsettings set org.gnome.shell favorite-apps \
  "['chromium-browser.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Screenshot.desktop']"

step 'Done'
