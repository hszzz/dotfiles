#!/bin/bash

echo "configure my personal run config ..."

# back up old config files

CONFIG_FILES=(
    .zshrc
    .vimrc
    .gitconfig
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

