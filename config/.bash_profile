# -*- bash -*-
set -o vi

# source stuff
. $HOME/.vars
. $HOME/.property_file.env


# aliases
alias gr="cd $_repos_dir"
alias ga="cd $_repos_dir/$_most_common_repo"
alias jork="${_bash_profile_lib_dir}/jork.sh"
alias ll='ls --color=auto -alF'


function chromeapp(){
  for url in $@; do
    /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --app="${url}"
  done
}


# docker functions
docker-dedangle(){
  docker rmi -f $(docker images -q --filter "dangling=true")
}


docker-warm(){
  printf 'docker pull %s\n' ${_fav_containers[@]} | jork | grep 'Status'
}


docker-happy-compose(){
  docker-compose down -v && docker-compose build && docker-compose up
}

# docker-reboot(){
#   sudo systemctl restart docker.service
#   sleep 3
#   until docker images --all &> /dev/null; do
#     echo 'waiting for docker to start'
#     sleep 2
#   done
#   echo 'docker is up!'
# }


docker-kill-all(){
  docker ps -aq | xargs docker rm -fv
}


docker-nuke(){
  docker-kill-all
  docker volume ls -q | xargs docker volume rm
  docker images -aq | xargs docker rmi -f
  #docker-reboot
  echo 'warming docker cache background'
  docker-warm &> /dev/null &
}


docker-watch(){
  tmux -2 new-session htop -p $(cat /var/run/docker.pid)\; split-window -v docker stats\; split-window -v  watch -td docker ps\; attach
}


# git bash prompt
export GIT_PROMPT_ONLY_IN_REPO=1
export GIT_PROMPT_THEME=Minimal
source ~/repos/bash-git-prompt/gitprompt.sh


# you complete me
[[ -r "${_brew_prefix}/etc/profile.d/bash_completion.sh" ]] && . "${_brew_prefix}/etc/profile.d/bash_completion.sh"
if [ -f '/Users/jordancohen/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/jordancohen/Downloads/google-cloud-sdk/completion.bash.inc'; fi


# my screen
# docker not supported on apple silicon yet
# (( RANDOM % 10 )) || docker run -t hypergig/parrotsay


# direnv
eval "$(direnv hook bash)"
