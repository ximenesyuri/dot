#! /bin/bash

source ${BASH_SOURCE%/*}/default.sh
source ${BASH_SOURCE%/*}/ls.sh

function dot_cd() {
    if [[ -n "$DOT_CD" ]]; then
        "$DOT_CD" "$@"
    else
        eval "DOT_DEFAULT_CD $1"
    fi
}

function dot_open() {
    local ext=${1##*.}
    local default_cmd=$(yq e ".open.default // \"$DOT_DEFAULT_OPEN\"" $CONFIG_FILE)
    local cmd=$(yq e ".open.${ext} // \"$default_cmd\"" $CONFIG_FILE)
    eval "$cmd $1"
}

function dot_home(){
    if [[ -z "$1" ]]; then
        dot_cd $HOME
    else
        mapfile -t USERS < <(users)
        if [[ "${USERS[@]}" =~ "$1" ]]; then
            dot_cd /home/$1
        else
            echo "error: user $1 not exists."
            return 1
        fi
    fi
}

function dot_rc(){
    if [[ -z "$1" ]]; then
        dot_open $HOME/.bashrc
    else
        local rc_file=$(yq e ".paths.rc.${2}" $CONFIG_FILE)
        if [[ -n "$rc_file" && "$rc_file" != "null" ]]; then
            dot_open "$rc_file"
        fi
    fi
}

function dot_config(){
    if [[ -z "$1" ]]; then
        dot_cd $HOME/.config
    else
        local config_dir=$(yq e ".paths.config.${2}" $CONFIG_FILE)
        if [[ -n "$config_dir" && "$config_dir" != "null" ]]; then
            cd "$config_dir"
        fi
    fi
}

function dot_nav(){
    if [[ "$1" == "-" ]] ||
       [[ "$1" == "..." ]]; then
        shift 1
        DOT_DEFAULT_BACK
        dot_ls
    elif [[ "$1" == ".." ]]; then
        dot_cd ..
        dot_ls
    elif [[ -d "$1" ]]; then
        dot_cd "$1"
        dot_ls 
    elif [[ -f "$1" ]]; then
        dot_open "$1"
    elif [[ "$1" == "h" ]] ||
         [[ "$1" == "home" ]] ||
         [[ "$1" == ".h" ]] ||
         [[ "$1" == ".home" ]]; then
        shift 1
        dot_home "$@"
    elif [[ "$1" == "rc" ]] ||
         [[ "$1" == ".rc" ]]; then
        shift 1
        dot_rc "$@"
    elif [[ "$1" == "c" ]] ||
         [[ "$1" == "conf" ]] ||
         [[ "$1" == "config" ]] ||
         [[ "$1" == ".c" ]] ||
         [[ "$1" == ".conf" ]] ||
         [[ "$1" == ".config" ]]; then
        shift 1
        dot_config "$@"
    else
        dot_ls
    fi
}
