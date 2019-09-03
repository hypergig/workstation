# setup bash profile
line="source ${PWD}/config/.bash_profile"
grep -q "${line}" ~/.profile || {
    echo "${line}" >> ~/.profile
    touch ~/.property_file.env
}

# .gitconfig
[ -L ~/.gitconfig ] || ln -vs ${PWD}/config/.gitconfig ~/.gitconfig
