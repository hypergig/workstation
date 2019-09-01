#! /usr/bin/env bash
set -xeuo pipefail

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add
apt-key fingerprint 0EBFCD88 | grep '9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88'

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update
apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io

docker version
