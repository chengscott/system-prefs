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
   $sudo apt install -y --no-install-recommends wget curl vim python-pip git &&\
   $sudo apt autoclean -y
sudo -H pip install --upgrade pip

echo "---------------APT Remove Default Program---------------"
$sudo apt purge -y webbrowser-app firefox &&\
   $sudo apt autoremove

if ! which google-chrome-stable > /dev/null; then
    echo "Install google-chrome-stable"
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | $sudo tee --append /etc/apt/sources.list
    wget https://dl.google.com/linux/linux_signing_key.pub
    $sudo apt-key add linux_signing_key.pub &&\
      $sudo apt update
    $sudo apt install -y google-chrome-stable
fi
# $sudo update-alternatives --config x-www-browser

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

echo "---------------Copying Vimrc---------------"
wget -O - https://raw.githubusercontent.com/chengscott/system-prefs/master/ubuntu16.04/vimrc
$sudo cp -f vimrc /etc/vim/

echo "---------------Configure Git---------------"
if [ -z $(git config user.name) ]; then
    echo "username:"
    read git_name
    git config --global user.name $git_name
fi
if [ -z $(git config user.email) ]; then
    echo "email:"
    read git_email
    git config --global user.email $git_email
fi
git config --global core.editor vim
git config --global color.ui auto
git config --global ui.abbrevCommit yes

echo "Setup a Develpment environment? [Y/n]"
read is_dev
if [ $is_dev -ne "n" ]; then
    $sudo apt update &&\
      $sudo apt install -y --no-install-recommends\
        build-essential mysql-client libmysqlclient-dev\
        python-dev python3 python3-dev

    #echo "Install mysql-workbench-community"

    #echo "Install npm nodejs"

    #echo "Install docker"

    echo "---------------Modify Launcher---------------"
    gsettings set com.canonical.Unity.Launcher favorites "['application://google-chrome.desktop', 'application://gnome-terminal.desktop', 'unity://running-apps', 'application://mysql-workbench.desktop', 'application://org.gnome.Screenshot.desktop', 'unity://expo-icon', 'unity://devices']"
else
    echo "---------------Modify Launcher---------------"
    gsettings set com.canonical.Unity.Launcher favorites "['application://google-chrome.desktop', 'application://gnome-terminal.desktop', 'unity://running-apps', 'application://org.gnome.Screenshot.desktop', 'unity://expo-icon', 'unity://devices']"
fi
