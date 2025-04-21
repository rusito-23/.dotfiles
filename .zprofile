# zprofile
# Configuration for all sessions.

# {{{ Configuration

export TERM="xterm-256color"
export VISUAL=nvim
export EDITOR=nvim
export PAGER=less
export LESS=-FRX

# }}}

# {{{ Path Setup

export PATH=$HOME/.local/bin:$PATH
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/opt/homebrew/opt/fzf/bin:$PATH

# }}}

# {{{ Welcome

ascii_image='
     ДОБРО ПОЖАЛОВАТЬ, РУСИТО 23!

             ██████ █████
           ████     ██  ████
         ███  █████ ██    ███
        ███  ██████ ██      ██
       ███  ██  ███ ██      ███
       ███ ███  ███ ██     ███
       ███ ████████ ██████████
       ███ ███  ███ ██      ███
        ███ ██  ███ ██      ██
         ███        ██    ███
           ████     ██  ████
             ██████ █████
'

# Get terminal dimensions
rows=$(tput lines)
cols=$(tput cols)

# Count lines and max width of the ASCII art
image_lines=$(echo "$ascii_image" | wc -l)
image_width=$(echo "$ascii_image" | awk '{ if (length > max) max = length } END { print max }')

# Calculate starting position
start_row=0
start_col=$(( (cols - image_width) / 2 ))

# Clear screen
clear

# Move cursor and print line-by-line
row=$start_row
while IFS= read -r line; do
    tput cup $row $start_col
    echo "$line"
    row=$((row + 1))
done <<< "$ascii_image"

# }}}
