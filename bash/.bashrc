COLOR_RED="\[\e[31;49m\]"
COLOR_GREEN="\[\e[32;40m\]"
COLOR_GREEN2="\[\033[0;32m\]"
COLOR_GREEN_BOLD="\[\033[01;32m\]"
COLOR_CYAN="\[\e[36;40m\]"
COLOR_RESET="\[\e[0m\]"
COLOR_PURPLE="\[\033[0;35m\]"
COLOR_BLUE="\[\033[01;34m\]"

function GitBranchName {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " ("${ref#refs/heads/}")"
}

function GitBranchColor {
  if [[ $(git status 2> /dev/null | grep -c :) == 0 ]]
    then echo "${COLOR_GREEN2}"
    else echo "${COLOR_RED}"
  fi
}

# Taken from https://gist.github.com/miki725/9783474
function SetVirtualEnv () {
  if test -z "$VIRTUAL_ENV" ; then
      PYTHON_VIRTUALENV=""
  else
      PYTHON_VIRTUALENV="${BLUE}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE} "
  fi
}

function GoogleProdStr() {
  # based on go/g4recipes
  if command -v prodcertstatus >& /dev/null; then

    prodcertstatus --nocheck_loas --nocheck_ssh --check_remaining_hours=1 > /dev/null 2>&1;
    case $? in
      # Full prodaccess:
      0) local PROD_STR="" ;;
      # Prodaccess will soon expire:
      8) local PROD_STR="\[$(tput setaf 3)\][PROD < 1H] " ;;
      # No prodaccess:
      *) local PROD_STR="\[$(tput setaf 1)\][NO PROD] " ;;
    esac
    echo $PROD_STR
  fi
}

function prompt_title {
  SetVirtualEnv
  PS1="$(GoogleProdStr)$COLOR_GREEN_BOLD\h$COLOR_RESET:$COLOR_BLUE\w$(GitBranchColor)$(GitBranchName)${COLOR_RESET}$PYTHON_VIRTUALENV "
}

PROMPT_COMMAND=prompt_title
alias cp='cp -i'
alias grep='grep --color=auto'
alias ls='ls -F --color=auto'
alias mkdir='mkdir -p'
alias mv='mv -i'
alias mygcc='gcc -wall -pedantic -std=c11 -ggdb'
alias myvalgrind='valgrind --leak-check=full --show-leak-kinds=all'
alias rm='rm -i'
alias vi='vim'
alias which='type -all'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias network_strength='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I'
alias gccp='g++ -ansi -pedantic-errors -Wall $1 $2 $3'
# Adds homebrew to path.
# Silent if fails, where brew isn't available on workstation.
if [ -e "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# If nvim isn't installed on the system, alias to the expected path on workstation.
if ! command -v nvim >& /dev/null; then
  alias nvim='~/nvim11.appimage'
fi

# Allow Ctrl-S Ctrl-Q commands in terminal (for saving in Vim)
stty -ixon

if command -v direnv >& /dev/null; then
  echo "executing direnv hook"
  eval "$(direnv hook bash)"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
