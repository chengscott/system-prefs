#!/bin/bash
[ $(id -u) -eq 0 ] && sudo="sudo" || sudo=""

echo "---------------APT Update and Install---------------"
$sudo apt update
$sudo apt install -y --no-install-recommends vim git curl tmux \
    fcitx fcitx-chewing python-dev python-pip python3-dev python3-pip &&\
  $sudo -H pip install --upgrade pip
$sudo apt install -y --install-recommends chromium-browser
# $sudo update-alternatives --config x-www-browser
# atom
curl -s https://api.github.com/repos/atom/atom/releases/latest |\
    grep browser_download_url | grep '64[.]deb' |\
    head -n 1 | cut -d '"' -f 4 | xargs wget &&\
  $sudo dpkg --install *64[.]deb

echo "---------------APT Remove Default Program---------------"
$sudo apt purge -y webbrowser-app firefox
$sudo apt autoremove

echo "---------------Install Paper Theme---------------"
$sudo add-apt-repository ppa:snwh/pulp -y &&\
  $sudo apt update &&\
  $sudo apt install -y paper-icon-theme paper-gtk-theme paper-cursor-theme &&\
  gsettings set org.gnome.desktop.interface gtk-theme "Paper" &&\
  gsettings set org.gnome.desktop.interface icon-theme "Paper" &&\
  gsettings set org.gnome.desktop.wm.preferences theme "Paper"

echo "---------------Install Powerline---------------"
python3 -m pip install --user setuptools
python3 -m pip install --user git+git://github.com/Lokaltog/powerline
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf \
  https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p ~/.fonts/ && mv PowerlineSymbols.otf ~/.fonts/
fc-cache -vf ~/.fonts
mkdir -p ~/.config/fontconfig/conf.d/ && mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
echo "source ~/.local/lib/python3.5/site-packages/powerline/bindings/bash/powerline.sh" >> ~/.bashrc 

echo "---------------Config---------------"
$sudo ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime
# vim
wget -O ~/.vimrc https://github.com/chengscott/system-prefs/raw/master/dotfiles/vimrc
# tmux
'source ~/.local/lib/python3.5/site-packages/powerline/bindings/tmux/powerline.conf
set-option -g default-terminal "screen-256color"
set -g mouse on' >> ~/.tmux.conf
# git
: ${name:=chengscott}
: ${email:=60510scott@gmail.com}
wget https://github.com/chengscott/system-prefs/raw/master/dotfiles/git.sh &&\
  chmod +x git.sh &&\
  name=$name email=$email ./git.sh &&\
  rm git.sh
# launcher
gsettings set com.canonical.Unity.Launcher favorites "['application://google-chrome.desktop', 'application://gnome-terminal.desktop', 'unity://running-apps', 'application://org.gnome.Screenshot.desktop', 'unity://expo-icon', 'unity://devices']"

echo "Setup a Develpment environment? [Y/n]"
read is_dev
if [ $is_dev -ne "n" ]; then
    echo "Install MySQL Workbench"
    $sudo apt update &&\
      $sudo apt install -y --no-install-recommends\
        build-essential mysql-client libmysqlclient-dev mysql-workbench

    echo "Install npm nodejs"
    $sudo apt install -y python-software-properties
    curl -sL https://deb.nodesource.com/setup_8.x | $sudo -E bash - &&\
      $sudo apt install nodejs

    echo "Install yarn"
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | $sudo apt-key add - &&\
      echo "deb https://dl.yarnpkg.com/debian/ stable main" | $sudo tee /etc/apt/sources.list.d/yarn.list &&\
      $sudo apt update &&\
      $sudo apt install yarn

    echo "Install docker"
    $sudo apt remove docker docker-engine docker.io
    $sudo apt install -y apt-transport-https ca-certificates software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | $sudo apt-key add - &&\
      $sudo add-apt-repository "deb [arch=s390x] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" &&\
      $sudo apt update &&\
      $sudo apt install -y docker-ce
fi
