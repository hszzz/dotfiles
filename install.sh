#!/bin/bash

echo "configure my personal run config ..."

# install zsh
# sudo apt install zsh

# install oh-my-zsh
# echo "install oh-my-zsh"
# sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# back up old config files

CONFIG_FILES=(
    .clang-format
#   .vim
    .zshrc
    .vimrc
    .gitconfig
    .bash_alias
    .ycm_extra_conf.py
)

BACKUP_DIR=~/.myrc.bak
MY_RC_PATH=.myrc

if [ -d ${BACKUP_DIR} ]
then 
    echo "backup dir already exists!"
else
    echo "create backup dir"
    mkdir ${BACKUP_DIR}
fi

for file in ${CONFIG_FILES[@]}
do
    if [ -f ~/${file} ]
    then
        echo "${file} already exists"
        mv ~/${file} ${BACKUP_DIR}
    elif [ -h ~/{file} ]
    then
        echo "${file} is soft link, move to old_rcfiles"
        mv ~/${file} ${BACKUP_DIR}
    else
        echo "${file} doesn't exists"
    fi
    ln -s $MY_RC_PATH/${file} ~/${file}
done

# copy colors to .vim/colors
cp vim-colors ~/.vim/colors -r

