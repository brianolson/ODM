#!/bin/bash
# setup dev environment without Docker
# Works on Ubuntu 21.04 (and more?)
# Most of this is `apt-get install ...`
# Also some `pip install` to a venv
set -e
set -x

sudo apt-get install -y lsb-release pkg-config tzdata python3-pip python3-setuptools python3-venv
if [ ! -f odmve ]; then
    python3 -m venv --system-site-packages odmve
fi
. odmve/bin/activate
pip install -U pip
pip install shyaml
APT_GET="env DEBIAN_FRONTEND=noninteractive $(command -v apt-get)"
installdepsfromsnapcraft() {
    key="$1"
    section="$2"

    cat snap/snapcraft21.yaml | \
	shyaml get-values-0 parts.$section.$key | \
	xargs -0 sudo $APT_GET install -y -qq --no-install-recommends
}
installdepsfromsnapcraft build-packages prereqs
installdepsfromsnapcraft build-packages opencv
installdepsfromsnapcraft build-packages opensfm
installdepsfromsnapcraft build-packages openmvs

pip install -r requirements.txt

mkdir -p SuperBuild/build
(cd SuperBuild/build && cmake .. && make -j4)
