if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

export PATH=/usr/local/bin:/usr/local/sbin:$PATH

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
