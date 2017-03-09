#!/bin/bash
SCOPE=--global
git config ${SCOPE} user.name $git_name
git config ${SCOPE} user.email $git_email
git config ${SCOPE} push.default simple
git config ${SCOPE} core.editor vim
git config ${SCOPE} color.ui auto
git config ${SCOPE} ui.abbrevCommit yes
git config ${SCOPE} credential.https://github.com.username $git_name
git config ${SCOPE} credential.https://gitlab.com.username $git_name
git config ${SCOPE} credential.helper 'cache --timeout=3600'