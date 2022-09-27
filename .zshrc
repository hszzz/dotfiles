export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="ys"

export UPDATE_ZSH_DAYS=13
DISABLE_AUTO_TITLE="true"
HIST_STAMPS="yyyy-mm-dd"
DEFAULT_USER="laixintao"

source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8

HISTFILE=~/.config/histfile
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
plugins=(git z sudo zsh-autosuggestions zsh-syntax-highlighting)

# alias
if [ -f ~/.bash_alias ]; then
    . ~/.bash_alias
fi

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
  export https_proxy="https://127.0.0.1:7890";
  export http_proxy="http://127.0.0.1:7890";
fi
