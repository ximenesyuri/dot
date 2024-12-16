function dot_trash(){
    TRASH_DIR=$(yq e ".trash.path" $CONFIG_FILE)
    if [[ -z "$TRASH_DIR" || "$TRASH_DIR" == "null" ]]; then
        TRASH_DIR=$HOME/.trash
    fi
}

function clean_trash() {
    dot_trash
    local CLEAN_TIME_DAYS=$(yq e '.trash.clean.time // 30' $CONFIG_FILE)
    local CLEAN_SIZE_MB=$(yq e '.trash.clean.size' $CONFIG_FILE)
    find "$TRASH_DIR" -type f -mtime +$CLEAN_TIME_DAYS -exec rm {} \;
    if [[ -n "$CLEAN_SIZE_MB" && "$CLEAN_SIZE_MB" != "null" ]]; then
        local trash_size
        trash_size=$(du -sm "$TRASH_DIR" | cut -f1)
        while [[ $trash_size -gt $CLEAN_SIZE_MB ]]; do
            find "$TRASH_DIR" -type f -printf '%T+ %p' | sort | head -n 50 | cut -d' ' -f2- | xargs rm
            trash_size=$(du -sm "$TRASH_DIR" | cut -f1)
        done
    fi
}

function dot_del(){
    dot_trash
    TRASH_LOG="$TRASH_DIR/trash.log"
    clean_trash
    if [[ ! -f "$TRASH_LOG" ]]; then
        touch "$TRASH_LOG"
    fi
    if [[ "$1" == "--undo" ]]; then
        local last_entry=$(tail -n 1 "$TRASH_LOG")
        if [[ -n "$last_entry" ]]; then
            local src=$(echo "$last_entry" | cut -d '|' -f1)
            local dest=$(echo "$last_entry" | cut -d '|' -f2)
            mv "$dest" "$src"
            sed -i '$ d' "$TRASH_LOG"
        else
            echo "No deletion to undo."
        fi
    elif [[ -e "$1" ]]; then
        local timestamp=$(date +%s)
        local dest_file="$TRASH_DIR/$(basename "$1").$timestamp"
        mv "$1" "$dest_file"
        echo "$1|$dest_file" >> "$TRASH_LOG"
    fi
}
