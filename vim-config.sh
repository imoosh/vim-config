#!/bin/bash
# Created by Wayne, 2022.7.29

VI=""
VIM=""
PWD=$(readlink -f "$(dirname "$0")")

function check_vim() {
    VI=$(which vi 2>/dev/null)
    VIM=$(which vim 2>/dev/null)
    if [ -z "$VI" ] || [ -z "$VIM" ]; then
        echo "please install vi/vim first"
        exit 1
    fi
}

function backup_vimconfig() {
  rm -rf $HOME/.bakvim 2>&-
  mkdir $HOME/.bakvim 2>&-
  cp -rf $HOME/.vim $HOME/.bakvim 2>&-
  cp $HOME/.vimrc $HOME/.bakvim 2>&-
  cp $HOME/.bashrc $HOME/.bakvim 2>&-
}

function config_vim() {
  rm -rf $HOME/.vim 2>&-
  cp -rf $PWD/.vim $HOME 2>&-
  cp $PWD/.vimrc $HOME 2>&-
  cp $PWD/.bashrc $HOME 2>&-

  mv "${VI}" "${VI}-bak"
  ln -s "${VIM}" "${VI}"

  #cp $PWD/cindex /usr/bin/ 2>&-
  #chmod +x /usr/bin/cindex 2>&-
  #cd /usr/include
  #ctags -I __THROW -I __THROWNL -I __nonnull -R --c-kinds=+p --fields=+iaS --extra=+q
}

check_vim
backup_vimconfig
config_vim
