source ${BASH_SOURCE%/*}/default.sh

function dot_preview(){
    if [[ -n $(which fzf) ]]; then
        "$DOT_DEFAULT_PREVIEW" "$1"
    fi
}
