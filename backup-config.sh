#!/usr/bin/env bash

# get dir of script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if test -f "$SCRIPT_DIR/i3config"; then
    echo "Overwriting i3 config..."
else
    echo "Backing up i3 config..."
fi
cp ~/.config/i3/config "$SCRIPT_DIR/i3config" && echo "i3 config backed up successfully."

if test -f "$SCRIPT_DIR/i3blocksconfig"; then
    echo "Overwriting i3blocks config..."
else
    echo "Backing up i3blocks config..."
fi
cp ~/.config/i3blocks/config "$SCRIPT_DIR/i3blocksconfig" && echo "i3blocks config backed up successfully."

if test -f "$SCRIPT_DIR/kittyconfig"; then
    echo "Overwriting kitty config..."
else
    echo "Backing up kitty config..."
fi
cp ~/.config/kitty/kitty.conf "$SCRIPT_DIR/kittyconfig" && echo "kitty config backed up successfully."

echo "Backing up i3blocks scripts..."
find ~/computer/i3blocks-scripts -mindepth 1 -maxdepth 1 -path ~/computer/i3blocks-scripts/venv -prune -o -print | grep -v ~$ | xargs -I{} cp {} ~/computer/dev/i3wmconfig/i3blocks-scripts/ && echo "i3blocks scripts backed up successfully."