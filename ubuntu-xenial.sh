#!/bin/bash

# sudo
sudo=""
if [$(id -u) -ne 0];then
    sudo="sudo"
fi

echo "---------------Set Timezone---------------"
$sudo timedatectl set-timezone Asia/Taipei
timedatectl

echo "---------------APT Update and Install---------------"
$sudo apt update &&\
   $sudo apt install -y --no-install-recommends wget curl vim git python-dev python-pip python3 python3-dev &&\
   $sudo apt autoclean -y
sudo -H pip install --upgrade pip
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
$sudo dpkg -i google-chrome-stable_current_amd64.deb
# $sudo update-alternatives --config x-www-browser

echo "---------------APT Remove Default Program---------------"
$sudo apt purge -y webbrowser-app firefox &&\
   $sudo apt autoremove

echo "---------------Install Paper Theme---------------"
$sudo add-apt-repository ppa:snwh/pulp -y &&\
  $sudo apt update
$sudo apt install -y paper-icon-theme paper-gtk-theme paper-cursor-theme
gsettings set org.gnome.desktop.interface gtk-theme "Paper"
gsettings set org.gnome.desktop.interface icon-theme "Paper"
gsettings set org.gnome.desktop.wm.preferences theme "Paper"

echo "---------------Install Powerline---------------"
$sudo -H pip install setuptools
$sudo -H pip install git+git://github.com/Lokaltog/powerline
echo "
# powerline
powerline-daemon -q
source /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh
" >> ~/.bashrc 

echo "---------------Config---------------"
# vim
mv dotfiles/vimrc ~/.vimrc
# git
: ${name:=chengscott}
: ${email:=60510scott@gmail.com}
chmod +x dotfiles/git.sh
name=$name email=$email dotfiles/git.sh

echo "Setup a Develpment environment? [Y/n]"
read is_dev
if [ $is_dev -ne "n" ]; then
    $sudo apt update &&\
      $sudo apt install -y --no-install-recommends\
        build-essential mysql-client libmysqlclient-dev

    #echo "Install mysql-workbench-community"

    #echo "Install npm nodejs"

    #echo "Install docker"

    echo "---------------Modify Launcher---------------"
    gsettings set com.canonical.Unity.Launcher favorites "['application://google-chrome.desktop', 'application://gnome-terminal.desktop', 'unity://running-apps', 'application://mysql-workbench.desktop', 'application://org.gnome.Screenshot.desktop', 'unity://expo-icon', 'unity://devices']"
else
    echo "---------------Modify Launcher---------------"
    gsettings set com.canonical.Unity.Launcher favorites "['application://google-chrome.desktop', 'application://gnome-terminal.desktop', 'unity://running-apps', 'application://org.gnome.Screenshot.desktop', 'unity://expo-icon', 'unity://devices']"
fi
