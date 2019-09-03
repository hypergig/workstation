(cd /tmp && curl -fLO https://zoom.us/client/latest/zoom_amd64.deb; )&

apts+=' /tmp/zoom_amd64.deb'
tests['zoom']="which zoom"
