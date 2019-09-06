add-apt-repository -yn ppa:mmstick76/alacritty

[ -d ~/.config/alacritty ] || mkdir -v ~/.config/alacritty
[ -L ~/.config/alacritty/alacritty.yml ] || ln -vs ${PWD}/config/alacritty.yml ~/.config/alacritty/alacritty.yml

apts+=' alacritty'
tests['alacritty']="alacritty --version"
