#! /usr/bin/env bash
set -xeuo pipefail
mkdir -vp ~/repos
cd ~/repos
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get install -y git make ansible
[ -d 'workstation' ] || git clone git@github.com:hypergig/workstation.git
cd workstation
exec make install
