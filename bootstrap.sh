#! /usr/bin/env bash
set -euo pipefail

mkdir -v ~/repos
sudo apt-get update
sudo apt-get install -y git make
cd ~/repos
git clone git@github.com:hypergig/workstation.git
cd workstation
make
