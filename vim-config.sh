#!/bin/bash
# Created by Wayne, 2022.7.29

VI=""
VIM=""
CTAGS=""
PWD=$(readlink -f "$(dirname "$0")")

function install_ctags() {
    local result=$(uname -s 2>/dev/null)
    if [[ "$result" = "Darwin" ]]; then
        brew install -y ctags        
    elif [[ "$result" = "Linux" ]]; then
        os=$(head -1 /etc/os-release) 
        if [[ "$os" =~ "Ubuntu" ]]; then
            apt install -y ctags
        elif [[ "$os" =~ "CentOS" ]]; then
            yum install -y ctags
        elif [[ "$os" =~ "Alpine" ]]; then
            apk add --no-cache ctags
        fi
    fi
}

function check_vim() {
    VI=$(which vi 2>/dev/null)
    VIM=$(which vim 2>/dev/null)
    CTAGS=$(which ctags 2>/dev/null)
    [ -z "$VI" ] && echo "please install vi first" && exit 1
    [ -z "$VIM" ] && echo "please install vim first" && exit 1
    [ -z "$CTAGS" ] && echo "please install ctags first" && exit 1
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
