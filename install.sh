#!/bin/bash

set -e
echo "configure my personal run config ..."

VIMEXE=vim

# back up old config files
CONFIG_FILES=(
    .clang-format
    .vim
    .zshrc
    .vimrc
    .gitconfig
    .bash_alias
    .ycm_extra_conf.py
    .zshrc_default_user
)

BACKUP_DIR=~/.myrc.bak
MY_RC_PATH=.myrc

deb_install() {
    sudo apt install -y curl
    sudo apt install -y zsh
    sudo apt install -y clang libclang-dev clang-format
    sudo apt install -y ccls
    sudo apt install -y ripgrep
    sudo apt install -y fzf

}

install_nodejs_lts() {
    if ! which node || [ `node --version | sed s/v// | cut -f1 -d.` -lt 12 ]; then
        echo '-- Upgrading Node.js version to 12.x'
        sudo bash -c 'curl -sL install-node.vercel.app/lts | bash -s - --force --prefix /usr'
        node --version
    fi
}

install_coc_plugins() {
    bash <<EOF
set -e
pushd ~/
echo -e '\\n\\nZZZZ\\n\\n' | "$VIMEXE" -c "set mouse= | echo 'installing all Vim plugins, please wait...' | PlugInstall | echo 'done' | quit"
for x in coc-ccls coc-pyright coc-git coc-json; do
    echo "-- Installing coc plugin '\$x', please wait..."
    echo -e '\\n\\nZZZZ\\n\\n' | "$VIMEXE" -c "set mouse= | echo 'installing \$x, please wait...' | CocInstall -sync \$x | echo 'done' | quit"
done
# mkdir -p ~/.config/coc/extensions/node_modules/coc-ccls
# ln -sf node_modules/ws/lib ~/.config/coc/extensions/node_modules/coc-ccls/lib
# echo '-- coc plugins installed successfully'
popd
EOF
}

install_universal_ctags() {
if which ctags && [ `ctags --version | sed -n '1p' | cut -f1 -d' '` = "Universal" ]; then
    echo "-- your ctags is universal-ctags!"
else
    sudo apt remove -y exuberant-ctags

    echo "-- Compile ctags from source ..."
    # Compile ctags with JSON format support
    sudo apt install -y libjansson-dev

    cd ~
    git clone https://github.com/universal-ctags/ctags.git
    cd ctags
    ./autogen.sh
    ./configure
    make
    sudo make install
    cd ~
fi
}

install_config() {
    echo "-- install config files"

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

    # support nvim
    if which nvim; then
        if [ -d ~/.vim ]; then
            mv ~/.config/nvim ${BACKUP_DIR}
        fi
        echo "-- creating symbolic link to ~/.config/nvim"
        ln -sf ~/.vim/ ~/.config/nvim
    fi
}

install_oh_my_zsh() {
    if ! while omz; then
        echo "-- install oh-my-zsh"
        sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
}

install_omz_plugins() {
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

deb_install
install_nodejs_lts
install_coc_plugins
install_oh_my_zsh
install_omz_plugins
install_universal_ctags
install_config

echo "-- Complete !!!"
source ~/.zshrc
