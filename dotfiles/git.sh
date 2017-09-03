#!/bin/bash
: ${SCOPE:=--global}
git config $SCOPE user.name $name
git config $SCOPE user.email $email
git config $SCOPE alias.ls ls-files
git config $SCOPE alias.ign "ls-files -o -i --exclude-standard"
git config $SCOPE alias.recent "log -3"
git config $SCOPE alias.lg "log --graph --decorate --pretty=oneline --abbrev-commit"
git config $SCOPE alias.lograph "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config $SCOPE push.default simple
git config $SCOPE core.editor vim
git config $SCOPE color.branch auto
git config $SCOPE color.diff auto
git config $SCOPE color.interactive auto
git config $SCOPE color.status auto
git config $SCOPE color.ui auto
git config $SCOPE ui.abbrevCommit yes
git config $SCOPE credential.https://github.com.username $name
git config $SCOPE credential.https://gitlab.com.username $name
git config $SCOPE credential.helper 'cache --timeout=3600'
