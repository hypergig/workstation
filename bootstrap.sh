#! /usr/bin/env bash
set -xeuo pipefail
mkdir -vp ~/repos
cd ~/repos
sudo apt-get update
sudo apt-get install -y git make python3-pip
pip3 install --user ansible jmespath
[ -d 'workstation' ] || git clone git@github.com:hypergig/workstation.git
cd workstation
PATH="~/.local/bin:/snap/bin:${PATH}"
exec make install
