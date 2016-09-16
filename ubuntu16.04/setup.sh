#!/bin/bash

# sudo
sudo=""
if [$(id -u) -ne 0];then
    sudo="sudo"
fi

echo "APT Update and Install"
$sudo apt update && apt install -y --no-install-recommends wget curl vim python-pip git\
  && apt autoclean

echo "APT Remove Default Program"
$sudo apt purge -y webbrowser-app firefox\
  && apt autoremove

if ! which google-chrome-stable > /dev/null; then
    echo "Install google-chrome-stable"
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | $sudo tee --append /etc/apt/sources.list
    wget https://dl.google.com/linux/linux_signing_key.pub
    $sudo apt-key add linux_signing_key.pub && apt update
    $sudo apt install google-chrome-stable
fi

echo "Install Paper Theme"
$sudo add-apt-repository ppa:snwh/pulp
$sudo apt update && apt install -y paper-icon-theme paper-gtk-theme paper-cursor-theme

echo "Install Powerline"
$su -c 'pip install git+git://github.com/Lokaltog/powerline'

echo "Copying Vimrc"
wget -O - https://raw.githubusercontent.com/chengscott/system-prefs/master/ubuntu16.04/vimrc
$sudo cp -y vimrc /etc/vim/

echo "Configure Git"
echo "username:"
read git_name
git config --global user.name $git_name
echo "email:"
read git_email
git config --global user.email $git_email
git config --global core.editor vim
git config --global color.ui auto
git config --global ui.abbrevCommit yes

echo "Setup a Develpment environment? [Y/n]"
read is_dev
if $is_dev != "n"; then
    $sudo apt update && apt install -y --no-install-recommends\
      build-essential mysql-client libmysqlclient-dev\
      python-dev python3 python3-dev

    #echo "Install mysql-workbench-community"

    #echo "Install npm nodejs"

    #echo "Install docker"

    echo "Modify Launcher"
    gsettings set com.canonical.Unity.Launcher favorites "['application://google-chrome.desktop', 'application://gnome-terminal.desktop', 'unity://running-apps', 'application://mysql-workbench.desktop', 'application://org.gnome.Screenshot.desktop', 'unity://expo-icon', 'unity://devices']"
else
    echo "Modify Launcher"
    gsettings set com.canonical.Unity.Launcher favorites "['application://google-chrome.desktop', 'application://gnome-terminal.desktop', 'unity://running-apps', 'application://org.gnome.Screenshot.desktop', 'unity://expo-icon', 'unity://devices']"

fi
