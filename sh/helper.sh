TEXT_EXT=('txt' 'py' 'js' 'html' )
IMAGE_EXT=('png' 'jpg')
VIDEO_EXT=('')

function is_text_(){
    for i in ${TEXT_EXT[@]}; do
        if [[ "$i" == "$1" ]]; then
            return 0
        fi
    done
    return 1
}
function is_image_(){
    for i in ${IMAGE_EXT[@]}; do
        if [[ "$i" == "$1" ]]; then
            return 0
        fi
    done
    return 1
}
function is_video_(){
    for i in ${VIDEO_EXT[@]}; do
        if [[ "$i" == "$1" ]]; then
            return 0
        fi
    done
    return 1
}

