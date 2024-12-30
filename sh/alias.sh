function dot_alias() {
    local input=("$@")
    local alias_path=""
    local depth=0
    local remaining_input=""
    local subalias_and_path=0

    for i in "${input[@]}"; do
        if [[ "$i" == *"/"* ]]; then
            alias_path+="${i%%/*}"
            remaining_input="${i#*/}"
            subalias_and_path=1
            break
        else
            alias_path+="$i."
        fi
    done

    alias_path="${alias_path%.}"

    if [[ "$subalias_and_path" -eq 1 ]]; then
        local path=$(yq eval ".aliases.$alias_path.path" "$CONFIG_FILE")
        path="$path/$remaining_input"
        if [[ -d "$path" ]]; then
            local action_key=$(yq eval ".aliases.$alias_path.action.dirs" "$CONFIG_FILE")
        elif [[ -f "$path" ]]; then
            local action_key=$(yq eval ".aliases.$alias_path.action.files" "$CONFIG_FILE")
        else
            echo "error: Invalid path: \"$path\""
            return 1
        fi
        local action="${DOT_FUNCTIONS[$action_key]}"
        $action "$path"

    else
        local path=$(yq eval ".aliases.$alias_path.path" "$CONFIG_FILE")
        local action_key=$(yq eval ".aliases.$alias_path.action.main" "$CONFIG_FILE")
        local action="${DOT_FUNCTIONS[$action_key]}"
        if [[ -n "$action" ]]; then
            $action $path
        else
            echo "Error: Action not found for alias $alias_path"
        fi
    fi
}
