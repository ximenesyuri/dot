function dot_alias() {
    if [[ -z "$2" ]]; then
        local alias_input="${1}"
    else
        alias_input=${!#}
    fi
    alias_stack=()
    for ((i = 1; i < $#; i++)); do
        alias_stack+=("${!i}")
    done
    local alias_name="${alias_input%%/*}"
    local remainder_path="${alias_input#*/}"
    if [[ -z "$2" ]]; then
        alias_string=$alias_name
    else
        alias_string="${alias_stack[*]}.$alias_name"
        alias_string=${alias_string// /.}
    fi
    if [[ "$alias_input" == "$alias_name" ]]; then
        remainder_path=""
    fi
    echo $alias_string

    local alias_dir=$(yq eval ".alias.${alias_string}.path" "$CONFIG_FILE")
    local recursive=$(yq eval ".alias.${alias_string}.recursive // false" "$CONFIG_FILE")
    local depth=$(yq eval ".alias.${alias_string}.depth // 0" "$CONFIG_FILE")

    if [[ ! -d "$alias_dir" ]]; then
        echo "Error: Alias or base directory not valid."
        return
    fi

    if [[ -z "$remainder_path" ]]; then
        dot_nav "$alias_dir"
        return
    fi

    local target_path="$alias_dir/$remainder_path"

    if [[ -d "$target_path" ]]; then
        dot_nav "$target_path"
        return
    fi

    if [[ "$recursive" == "true" && "$depth" -ge 0 ]]; then
        local search_path=$(find "$alias_dir" -mindepth 1 -maxdepth "$depth" -type d -path "$target_path*" -print -quit)
        if [[ -d "$search_path" ]]; then
            dot_nav "$search_path"
            return
        fi
    fi

    echo "Error: '$target_path' is not a valid directory."
}

