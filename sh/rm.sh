source ${BASH_SOURCE%/*}/default.sh

function dot_rm(){
    for i in "$@"; do
        if [[ -e "$i" ]]; then
            "$DOT_DEFAULT_REMOVE" "$i"
        else
            echo "error: \"$i\" does not exists."
            return
        fi
    done
}
