#!/bin/bash -eu
# Last Change:2024/11/07.

SCRIPT_DIR=$(cd $(dirname $0); pwd)

sudo apt update
sudo apt install -y fcitx-bin fcitx-mozc dbus-x11 language-pack-ja fonts-noto
sudo update-locale LANG=ja_JP.UTF8

cat << EOS >> ~/.profile
source ${SCRIPT_DIR}/../.zshrc.win.wsl
EOS
