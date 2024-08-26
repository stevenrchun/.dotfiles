COLOR_RED="\[\e[31;49m\]"
COLOR_GREEN="\[\e[32;40m\]"
COLOR_GREEN2="\[\033[0;32m\]"
COLOR_CYAN="\[\e[36;40m\]"
COLOR_RESET="\[\e[0m\]"
COLOR_PURPLE="\[\033[0;35m\]"

function Git_branch_name {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " ("${ref#refs/heads/}")"
}

function Git_branch_color {
  if [[ $(git status 2> /dev/null | grep -c :) == 0 ]]
    then echo "${COLOR_GREEN2}"
    else echo "${COLOR_RED}"
  fi
}

# Taken from https://gist.github.com/miki725/9783474
function set_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
      PYTHON_VIRTUALENV=""
  else
      PYTHON_VIRTUALENV="${BLUE}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE} "
  fi
}

function prompt_title {
  set_virtualenv
  PS1="$COLOR_PURPLE\w$(Git_branch_color)$(Git_branch_name)${COLOR_RESET}$PYTHON_VIRTUALENV "
}

PROMPT_COMMAND=prompt_title
alias cp='cp -i'
alias grep='grep --color=auto'
alias ls='ls -F'
alias mkdir='mkdir -p'
alias mv='mv -i'
alias mygcc='gcc -wall -pedantic -std=c11 -ggdb'
alias myvalgrind='valgrind --leak-check=full --show-leak-kinds=all'
alias rm='rm -i'
alias vi='vim'
alias which='type -all'
alias asana='/applications/google\ chrome.app/contents/macos/google\ chrome --app=https://app.asana.com/0/457187100235215/list'
alias connectJupyter='ssh -N -L localhost:9001:localhost:9000 f002c51@andes.dartmouth.edu'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias network_strength='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I'
alias gccp='g++ -ansi -pedantic-errors -Wall $1 $2 $3'

# Allow Ctrl-S Ctrl-Q commands in terminal (for saving in Vim)
stty -ixon

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
