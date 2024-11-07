#!/bin/bash -eu
# Last Change:2024/11/07.

ScriptDir="$(dirname "${BASH_SOURCE[0]}")"
ScriptDir="$(realpath "${ScriptDir}")"
cd ${ScriptDir}/../


if sheldon --version 1>/dev/null 2>&1;then
    if [ ! -e ~/.config/sheldon ]; then
        if mkdir -p ~/.config/sheldon; then
            echo "mkdir ~/.config/sheldon"
        fi
    fi
    if [ ! -e ~/.config/sheldon/plugins.toml ]; then
        ln -s ${ScriptDir}/../plugins.toml ~/.config/sheldon/plugins.toml
    fi
fi
