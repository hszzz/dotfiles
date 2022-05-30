# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# install Powerline Fonts first
ZSH_THEME="ys"

DISABLE_AUTO_TITLE="true"
HIST_STAMPS="yyyy-mm-dd"

# ---- install plugins
# cd ~/.oh-my-zsh/custom/plugins
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

plugins=(git z sudo zsh-autosuggestions zsh-syntax-highlighting)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=yellow'
source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

# DEFAULT_USER="hszzz"

if [ -f ~/.zshrc_local ]; then
    . ~/.zshrc_local
fi

# alias
if [ -f ~/.bash_alias ]; then
    . ~/.bash_alias
fi

cd ~
