# zinit, manage zsh plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# alias
if [ -f ~/.bash_alias ]; then
    . ~/.bash_alias
fi

# ls color
export LSCOLORS=exdxcxdxbxegedabagacad # BSD
# export LS_COLORS=di=34:ln=33:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43 # Linux

# local
if [ -f ~/.zshrc_local ]; then
    . ~/.zshrc_local
fi

# proxy
if uname -r |grep -i -q 'WSL2' ; then
  export hostip=$(cat /etc/resolv.conf | grep -oP '(?<=nameserver\ ).*');
  export https_proxy="http://${hostip}:7890";
  export http_proxy="http://${hostip}:7890";
  echo "[WSL2]: set http proxy: $http_proxy";
else
  export https_proxy=http://127.0.0.1:7890;
  export http_proxy=http://127.0.0.1:7890;
  export all_proxy=socks5://127.0.0.1:7890;
fi

export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="/opt/homebrew/Cellar/qt@5/5.15.8_2/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
     if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
         . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
     else
         export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
     fi
# fi
#  unset __conda_setup
# <<< conda initialize <<<

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zdharma-continuum/history-search-multi-word
zinit light thewtex/tmux-mem-cpu-load # tmux status line

eval "$(starship init zsh)"

