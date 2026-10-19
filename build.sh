#!/bin/bash
# Makes the two zips from package/ (rebuild package/HugsAndMore/HugsAndMore.pck first with pack.gd, see the README):
#   out/HugsAndMore-mod.zip         the HugsAndMore folder to drop into GDWeave/mods
#   out/HugsAndMore-<version>.zip   the Thunderstore upload
set -e
cd "$(dirname "$0")"
mkdir -p out
V=$(python3 -c "import json;print(json.load(open('thunderstore/manifest.json'))['version_number'])")
rm -f out/HugsAndMore-mod.zip out/HugsAndMore-$V.zip
(cd package && zip -qr ../out/HugsAndMore-mod.zip HugsAndMore)
T=$(mktemp -d)
cp thunderstore/manifest.json thunderstore/README.md thunderstore/CHANGELOG.md thunderstore/icon.png $T/
mkdir -p $T/GDWeave/mods/HugsAndMore
cp package/HugsAndMore/manifest.json package/HugsAndMore/HugsAndMore.pck $T/GDWeave/mods/HugsAndMore/
(cd $T && zip -qr - .) > out/HugsAndMore-$V.zip
rm -rf $T
echo "out/HugsAndMore-mod.zip"
echo "out/HugsAndMore-$V.zip"
