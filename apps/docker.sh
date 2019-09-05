
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add
apt-key fingerprint 0EBFCD88 | grep '9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88'

add-apt-repository -yn \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

posts['docker-group']="usermod -a -G docker jordan"

apts+=' docker-ce docker-ce-cli containerd.io'
tests['docker']="docker --version"

# docker compose
pips+=' docker-compose'
curl -fsSL https://raw.githubusercontent.com/docker/compose/1.24.1/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
tests['docker-compose']="docker-compose --version"
