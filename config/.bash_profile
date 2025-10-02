# -*- bash -*-
set -o vi

# source stuff
. $HOME/.vars
[ -f "${HOME}/.property_file.env" ] && source "${HOME}/.property_file.env"

# aliases
alias gr="cd $_repos_dir"
alias ga="cd $_repos_dir/$_most_common_repo"
alias ll='ls --color=auto -alF'
alias gitroot='cd "$(git rev-parse --show-toplevel)"'

function chromeapp() {
  for url in "$@"; do
    /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --app="${url}"
  done
}

# you complete me
if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r ${COMPLETION} ]] && source "${COMPLETION}"
    done
  fi
fi

# direnv
eval "$(direnv hook bash)"

# prompt
GIT_PROMPT_THEME=Minimal
__GIT_PROMPT_DIR="${HOMEBREW_PREFIX}/opt/bash-git-prompt/share"
source "${HOMEBREW_PREFIX}/opt/bash-git-prompt/share/gitprompt.sh"
