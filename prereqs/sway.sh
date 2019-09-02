#! /usr/bin/env bash
set -xeuo pipefail

add-apt-repository -y ppa:samoilov-lex/sway
tee -a target/apps.txt <<< "sway"
