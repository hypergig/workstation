#! /usr/bin/env bash
set -xeuo pipefail

pushd /tmp
curl -fLO https://downloads.slack-edge.com/linux_releases/slack-desktop-4.0.2-amd64.deb
popd

tee -a target/apps.txt <<< '/tmp/slack-desktop-4.0.2-amd64.deb'
