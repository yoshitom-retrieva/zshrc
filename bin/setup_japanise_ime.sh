#!/bin/bash -eu
# Last Change:2022/12/14.

SCRIPT_DIR=$(cd $(dirname $0); pwd)

sudo apt update
sudo apt install -y fcitx-bin fcitx-mozc dbus-x11 language-pack-ja fonts-noto
sudo update-locale LANG=ja_JP.UTF8

source ${SCRIPT_DIR}/../.zsshrc.win.wsl
