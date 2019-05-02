#!/usr/bin/env sh

TAG=v3.0.8

set -xe

rm -rf flatpak-builder-tools/ standard-notes/
git clone https://github.com/flatpak/flatpak-builder-tools.git ./flatpak-builder-tools/
git clone https://github.com/standardnotes/desktop.git ./standard-notes/

cd standard-notes/
git checkout "${TAG}"

cp ../flatpak-builder-tools/yarn/flatpak-yarn-generator.py ./
rm -f package-lock.json app/package-lock.json   # ...because yarn complains about different packaging tools and what not
yarn install
yarn check --integrity
yarn check --verify-tree
python3 flatpak-yarn-generator.py yarn.lock -o ../generated-sources.json
python3 flatpak-yarn-generator.py app/yarn.lock -o ../generated-sources-app.json
cat yarn.lock app/yarn.lock > ../yarn.lock

unset TAG
