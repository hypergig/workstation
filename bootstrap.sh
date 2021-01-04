#! /usr/bin/env sh
set -xeuo pipefail
mkdir -vp ~/repos
cd ~/repos
open https://brew.sh/
read -p "Install homebrew, press enter when completed..."
brew install bash git make
pip3 install --user --upgrade pip
pip3 install --user ansible jmespath
open https://github.com/settings/keys
read -p "Create your ssh key for github, press entry when completed..."
[ -d 'workstation' ] || git clone git@github.com:hypergig/workstation.git
cd workstation
PATH="/Users/jordancohen/Library/Python/3.8/bin:/usr/local/opt/make/libexec/gnubin:${PATH}"
hash -r
exec make install
