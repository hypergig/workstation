

add-apt-repository -yn ppa:samoilov-lex/sway

[ -d /etc/sway ] || mkdir -v /etc/sway
[ -L /etc/sway/config.d ] || ln -vs ${PWD}/config/sway/config.d /etc/sway/config.d

apts+=' sway'
tests['sway']="sway --version"
