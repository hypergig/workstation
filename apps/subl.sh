curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list

apts+=' sublime-text'
tests['sublime']="subl --version"
