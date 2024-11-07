#!/bin/bash -eu
# Last Change:2024/11/07.

ScriptDir="$(dirname "${BASH_SOURCE[0]}")"
ScriptDir="$(realpath "${ScriptDir}")"
cd ${ScriptDir}/../

sheldon lock --update
