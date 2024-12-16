function dot_help(){
        echo "
DESCRIPTION:
    Navigate in directory stack, and open and execute files.

USAGE:
    dot [option] [argument]

OPTIONS:
    n, nav [dir] ............ Navigate to the specified directory and list contents
           [file] ........... Open the specified file according to its extension
           '-', '...' ....... Go back to the previous directory in the stack
           '..' ............. Navigate to parent directory
    a, alias ................ Navigate or open alias directory or file
    s, src, source .......... Source a file or all files in a directory
    x, exec.................. Execute the file according to its extension
    p, prev, preview ........ Open fzf in preview mode for the given directory
    d, del, delete .......... Safely delete the given entry
    l, ls, list ............. List files and directories
    lf, lsf, list-files ..... List files
    ld, lsd, list-dirs ...... List dirs
    rm, remove .............. Permanently remove the given entry
    rn, rename .............. Rename the given entry
    m, mk, make ............. Creates something
    mf, mkf, make-file ...... Create files
    md, mkd, make-dir ....... Create directories
    "
    }
