#! /bin/bash

DOT_DEFAULT_LS="ls --color=auto --group-directories-first"
DOT_DEFAULT_LS_ALL="ls -A --color=auto --group-directories-first"

function DOT_DEFAULT_CD(){
    pushd $1 > /dev/null 2>&1
}

DOT_DEFAULT_OPEN="xdg-open"

function DOT_DEFAULT_BACK(){
    popd > /dev/null 2>&1
}

function DOT_DEFAULT_REMOVE(){
    rm -rf "$1"
}

function DOT_DEFAULT_PREVIEW(){
    fzf --preview="cat {}"
}

DOT_DEFAULT_MAKE_FILE="touch"
DOT_DEFAULT_MAKE_DIR="mkdir -p"
