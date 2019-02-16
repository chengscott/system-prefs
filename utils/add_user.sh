#!/bin/bash -e
function add {
    pw="$(openssl rand -base64 9)"
    echo -e "\e[32m$1: \e[33m${pw}\e[0m"
    useradd -m "$1" # -G cos
    chpasswd <<< "$1":"$pw"
    chage -d 0 "$1"
}
#groupadd cos
#echo '%cos ALL=(ALL) ALL' > /etc/sudoers.d/cos
#chmod 440 /etc/sudoers.d/cos
for user in "$@"; do
    add "$user"
done