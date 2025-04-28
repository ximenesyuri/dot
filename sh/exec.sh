function dot_exec() {
    if [[ -n "$1" ]]; then
        local ext=${1##*.}
        local cmd=$(yq e ".exec.extension.${ext} // .exec.default" $CONFIG_FILE)
        if [[ -n "$cmd" && "$cmd" != "null" ]]; then
            eval "$cmd \"$1\""
        fi
    fi
}
