#! /bin/bash

set -o vi

# default vars
export VISUAL=vim
export EDITOR="$VISUAL"
#export GTK_THEME="Solarized-Dark-Orange"
#export _JAVA_AWT_WM_NONREPARENTING=1
#export XCURSOR_PATH="/usr/share/icons:${XCURSOR_PATH}"
_repos_dir="$HOME/repos"
_workstation_dir="${_repos_dir}/workstation"
_bash_profile_lib_dir="${_repos_dir}/workstation/lib"
_fav_containers=(alpine:latest ubuntu:latest debian:latest python:3 hypergig/parrotsay)

# path mods
PATH="${_workstation_dir}/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/make/libexec/gnubin:/usr/local/opt/gnu-tar/libexec/gnubin:/usr/local/opt/diffutils/libexec/gnubin:${HOME}/Library/Python/3.8/bin::${PATH}"
if [ -f '/Users/jordancohen/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/jordancohen/Downloads/google-cloud-sdk/path.bash.inc'; fi

# property_file.sh looks like, needs to be in the $HOME directory
# export private_docker_repo=something.io/this
# export most_common_repo=foo
#
. $HOME/.property_file.env

# aliases
alias gr="cd $_repos_dir"
alias ga="cd $_repos_dir/$_most_common_repo"
alias jork="${_bash_profile_lib_dir}/jork.sh"
alias copy='tee /dev/stderr | xclip -sel clip'
alias ll='ls --color=auto -alF'


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
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
source <(kubectl completion bash)

# my screen
(( RANDOM % 10 )) || docker run -t hypergig/parrotsay

# direnv
eval "$(direnv hook bash)"

# sway
if [ "$(tty)" = "/dev/tty2" ]; then
  exec start-sway
fi
