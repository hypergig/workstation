#! /usr/bin/env bash
set -xeuo pipefail

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list

apt-get update
apt-get install -y sublime-text

subl -v
