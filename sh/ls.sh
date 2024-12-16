source ${BASH_SOURCE%/*}/default.sh

if [[ -n "$DOT_LS" ]]; then
    DOT_COMMAND_LS=$DOT_LS
else
    DOT_COMMAND_LS=$DOT_DEFAULT_LS
fi
if [[ -n "$DOT_LS_ALL" ]]; then
    DOT_COMMAND_LS_ALL=$DOT_LS_ALL
else
    DOT_COMMAND_LS_ALL=$DOT_DEFAULT_LS_ALL
fi

function dot_lsa_files(){
    if [[ -z "$1" ]]; then
        find . -maxdepth 1 -type f -printf '%P\n' | xargs -d '\n' $DOT_COMMAND_LS_ALL
    else
        find $1 -maxdepth 1 -type f -exec ls {} +
    fi
}

function dot_lsa_dirs(){
    if [[ -z "$1" ]]; then
        find . -maxdepth 0 -type d -printf '%P\n' | xargs -d '\n' $DOT_COMMAND_LS_ALL
    else
        find $1 -maxdepth 0 -type d -exec $DOT_COMMAND_LS_ALL {} +
    fi
}

function dot_lsa(){
    ls -a "$@"
}

function dot_lsf(){
    if [[ -z "$1" ]]; then
        find . -maxdepth 1 -type f -printf '%P\n' | xargs -d '\n' $DOT_COMMAND_LS
    else
        find $1 -maxdepth 1 -type f -exec $DOT_COMMAND_LS {} +
    fi
}

function dot_lsd(){
    if [[ -z "$1" ]]; then
        find . -maxdepth 0 -type d -printf '%P\n' | xargs -d '\n' $DOT_COMMAND_LS
    else
        find $1 -maxdepth 0 -type d -exec $DOT_COMMAND_LS {} +
    fi
}

function dot_ls() { 
    if [[ "$1" == "f" ]] ||
       [[ "$1" == "file" ]] ||
       [[ "$1" == "files" ]]; then
        if [[ "$2" == "a" ]] ||
           [[ "$2" == "all" ]]; then
            shift 2
            dot_lsa_files "$@"
        else
            shift 2
            dot_lsf "$@"
        fi
    elif [[ "$1" == "d" ]] ||
         [[ "$1" == "dir" ]] ||
         [[ "$1" == "dirs" ]]; then
        if [[ "$2" == "a" ]] ||
           [[ "$2" == "all" ]]; then
            shift 3
            dot_lsa_dirs "$@"
        else
            shift 2
            dot_lsd "$@"
        fi
    elif [[ "$1" == "a" ]] ||
         [[ "$1" == "all" ]]; then
        if [[ "$2" == "f" ]] ||
           [[ "$2" == "file" ]] ||
           [[ "$2" == "files" ]]; then
            shift 3
            dot_lsa_files "$@"
        elif [[ "$2" == "d" ]] ||
             [[ "$2" == "dir" ]] ||
             [[ "$2" == "dirs" ]]; then
            shift 3
            dit_lsa_dirs "$@"
        else
            shift 2
            dot_lsa "$@"
        fi 
    else
        $DOT_COMMAND_LS "$@"
    fi
}

