curl -fsSL https://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add
echo "deb http://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest bionic main" | tee /etc/apt/sources.list.d/saltstack.list

apts+=' salt-minion'
tests['salt-minion']="salt-minion --version"
