#!/usr/bin/env sh

set -xeu

export PYTHON="/usr/bin/python3.7"

TAG=v3.0.8

[[ -d standard-notes ]] || git clone https://github.com/standardnotes/desktop.git ./standard-notes/
cd standard-notes/
git checkout -f "${TAG}"

python3 ../flatpak-npm-generator.py package-lock.json -o ../generated-sources.json
python3 ../flatpak-npm-generator.py app/package-lock.json -o ../app-generated-sources.json
