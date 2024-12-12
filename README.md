# About

`dot` is a universal terminal utility that provides a unified command to be used for the mainly daily stuff, as navigation, open or execute files, rename files, safety deletion, and so on.

# Features

1. Single command with multiple usages
2. Navigate across directory stack
3. Easily access common directories and execute common files
4. Safety delete files and directories
5. Restore deleted files and directories
6. Preview files inside a directory using `fzf`
7. Configurable in `yaml`

# Dependencies

* `bash`, i.e, a UNIX-based operating system
* [yq](https://github.com/mikefarah/yq), version `>=4`
* [fzf](https://github.com/junegunn/fzf) (optional)

# Install

1. Clone the repository:
```bash
git clone https://ximenesyuri/dot /your/favorite/location/dot
```
2. Source the `dot` script in your `.bashrc`:
```bash
echo "source /your/favorite/location/dot/dot" >> $HOME/.bashrc
```

# Usage

```
DESCRIPTION:
    Navigate in directory stack, and open and execute files.

USAGE:
    dot [option] [argument]

OPTIONS:
    [dir] ...................... Navigate to the specified directory and list contents
    [file] ..................... Open the specified file according to its extension
    -, ... ..................... Go back to the previous directory in the stack
    .. ......................... Navigate to parent directory
    -h, --home [user] .......... Move to the user's home directory
    -c, --config [alias] ....... Move to the config directory with given alias
    -r, --rc [alias] ........... Open rc file with given alias
    -a, --alias [alias] ........ Navigate or open alias directory or file
    -s, --src [file] ........... Source the file
    -x, --exec [file] .......... Execute the file according to its extension
    -p, --preview [dir] ........ Open fzf in preview mode for the given directory
    -n, --name [entry].......... Rename the given entry
    -d, --delete [entry] ....... Safely delete the given entry
    -rm, --remove [entry] ...... Permanently remove the given entry
```

# Configuration

```yaml
open:
  default: default_command
  text:
    default: vim
    extension: 
      txt: txt_command
      sh: js_command
      # ...
  image:
    default: display
    extension:
      jpg: jpg_command
      jpeg: jpeg_command
      png: png_command
      # ...
  video:
    default: mplayer
    extension:
      mp4: mp4_command
      avi: avi_command
      # ...
exec:
  default: sh
  extension:
    py: /path/to/main/venv/bin/python3
    js: node
    # ...
trash:
  path: /path/to/trash
  clean:
    time: 10 # in days
    size: 50 # in mb
```
