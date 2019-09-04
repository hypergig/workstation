if [ ! -d ~/repos/bash-git-prompt ];then
    cd ~/repos
    git clone https://github.com/magicmonty/bash-git-prompt.git
    cd -
fi

apts+=' git'
tests+=' git --version'
