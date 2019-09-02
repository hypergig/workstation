#! /usr/bin/env bash
set -xeuo pipefail

curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list

tee -a target/apps.txt <<< "sublime-text"
