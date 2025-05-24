#!/bin/sh
set -e
ROJO_PROJECT="dev.project.json"
aftman install
sh scripts/download-types.sh
sh scripts/wally-install.sh "$ROJO_PROJECT"
# npm i --package-lock-only
# sh scripts/npm-install.sh
sh scripts/build.sh "$ROJO_PROJECT" --serve