function dot_source(){
    if [[ -z "$1" ]]; then
        source $HOME/.bashrc
    else
        for i in $@; do
            if [[ -f "$i" ]]; then
                source $i
            elif [[ -d "$i" ]]; then
                find $i -type f -exec source {} \;
            else
                echo "error: \"$i\" does not exists."
                return 1
            fi
        done 
    fi
}
