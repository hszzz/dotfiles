#!/bin/bash

set -e
echo "-- configure my personal run config"

# back up old config files
CONFIG_FILES=(
  .clang-format
  .zshrc
  .gitconfig
  .bash_alias
)

BACKUP_DIR=~/.myrc.bak
MY_RC_PATH=.myrc

install_config() {
  echo "-- install config files"

  if [ -d ${BACKUP_DIR} ]; then
    echo " -- backup dir already exists!"
  else
    echo " -- create backup dir ${BACKUP_DIR}."
    mkdir ${BACKUP_DIR}
  fi

  for file in ${CONFIG_FILES[@]}
  do
    if [ -f ~/${file} ]; then
      echo " -- ${file} already exists, move to backup dir."
      mv ~/${file} ${BACKUP_DIR}
    fi

    ln -s $MY_RC_PATH/${file} ~/${file}
    echo " -- link $MY_RC_PATH/${file} to ~/${file}."
  done
}

install_neovim() {
  hash nvim 2> /dev/null || {
    cd ~;
    git clone https://github.com/neovim/neovim;
    cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo;
    sudo make install;
    cd -;
    echo "-- neovim is installed.";
  }

  if [ -d ~/.config/nvim ]; then
    echo "-- ${file} already exists, move to backup dir."
    mv ~/.config/nvim ${BACKUP_DIR}
  fi

  echo "-- creating symbolic link to ~/.config/nvim"
  ln -sf `pwd`"/nvim" ~/.config/nvim
}

install_oh_my_zsh() {
  cd ~
  if [ ! -d ".oh-my-zsh" ]; then
    echo "-- install oh-my-zsh"
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
  cd -
}

install_omz_plugins() {
  rm ~/.oh-my-zsh/custom/plugins/* -rf
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

install_oh_my_zsh
install_omz_plugins
install_config
install_neovim

echo "-- complete !!!"

