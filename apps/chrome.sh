(cd /tmp && curl -fLO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb; )&

apts+=' /tmp/google-chrome-stable_current_amd64.deb'
tests['chrome']="google-chrome --version"
