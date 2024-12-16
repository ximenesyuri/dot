dot_move() {
    local force_flag=""
    local all_flag=""
    local args=()

    for arg in "$@"; do
        case $arg in
            --force|-f)
                force_flag="-f"
                ;;
            --all|-a)
                all_flag=1
                ;;
            *)
                args+=("$arg")
                ;;
        esac
    done

    if [[ $all_flag ]]; then
        local destination="${args[-1]}"
        unset 'args[${#args[@]}-1]'

        if [[ -d $destination ]]; then
            for source in "${args[@]}"; do
                if [[ $source == */'*' ]]; then
                    local dir="${source%/*}"
                    mv $force_flag "$dir"/{.[!.],}* "$destination"
                else
                    mv $force_flag "$source" "$destination"
                fi
            done
        else
            echo "The last argument must be a directory when using --all."
            return 1
        fi
    else
        mv $force_flag "${args[@]}"
    fi
}


function dot_rename(){
    if [[ -e "$1" ]] && [[ -n "$2" ]]; then
        mv "$1" "$2"
    fi
}
