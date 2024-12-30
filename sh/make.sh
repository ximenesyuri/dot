source ${BASH_SOURCE%/*}/default.sh

function dot_mkf(){
    DOT_DEFAULT_MAKE_FILE "$@"
}

function dot_mkd(){
    DOT_DEFAULT_MAKE_DIR "$@"
}

function dot_make(){
    if [[ "$1" == "file" || "$1" == "f" ]]; then
        shift 1
        dot_mkf "$@"
        
    elif [[ "$1" == "dir" || "$1" == "d" ]]; then
        shift 1
        dot_mkd "$@"
    else
        echo "error: option not defined."
        return 1
    fi
}
