[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

if [ -f ~/.bash_alias ]; then
    . ~/.bash_alias
fi

eval "$(starship init bash)"

