
(cd /tmp && curl -fLO https://downloads.slack-edge.com/linux_releases/slack-desktop-4.0.2-amd64.deb)&

apts+=' /tmp/slack-desktop-4.0.2-amd64.deb'
tests['slack']="which slack"
