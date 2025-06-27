if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

export PATH=/usr/local/bin:/usr/local/sbin:$PATH

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Adds homebrew to path.
eval "$(/opt/homebrew/bin/brew shellenv)"

# For Java
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export PATH="/Users/steven/.cargo/bin:$PATH"

# For poetry
export PATH="/Users/steven/.local/bin:$PATH"


#FZF rose pine colors
# export FZF_DEFAULT_OPTS="
# 	--color=fg:#797593,bg:#faf4ed,hl:#d7827e
# 	--color=fg+:#575279,bg+:#f2e9e1,hl+:#d7827e
# 	--color=border:#dfdad9,header:#286983,gutter:#faf4ed
# 	--color=spinner:#ea9d34,info:#56949f
# 	--color=pointer:#907aa9,marker:#b4637a,prompt:#797593"
export FZF_DEFAULT_OPTS=""

# Language Servers
export PATH="/Users/steven/projects/kotlin-language-server/server/build/install/server/bin:$PATH"
# For superhtml
export PATH="/Users/steven/language_servers/superhtml:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/steven/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/steven/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/steven/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/steven/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

