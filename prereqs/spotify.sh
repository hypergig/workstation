#! /usr/bin/env bash
set -xeuo pipefail

curl -fsSL https://download.spotify.com/debian/pubkey.gpg | apt-key add -
echo "deb http://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list

tee -a target/apps.txt <<< 'spotify-client'
