function dot_exec() {
    local ext=${1##*.}
    local cmd=$(yq e ".exec.${ext} $CONFIG_FILE")
    if [[ -n "$cmd" ]]; then
        eval "$cmd "$1""
    fi
}
