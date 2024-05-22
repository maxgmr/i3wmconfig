#!/usr/bin/env bash

# get dir of script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if test -f "$SCRIPT_DIR/i3config"; then
    echo "Overwriting i3 config backup..."
else
    echo "Backing up i3 config..."
fi
cp ~/.config/i3/config "$SCRIPT_DIR/i3config" && echo "i3 config backed up successfully."

if test -f "$SCRIPT_DIR/swayconfig"; then
    echo "Overwriting sway config backup..."
else
    echo "Backing up sway config..."
fi
cp ~/.config/sway/config "$SCRIPT_DIR/swayconfig" && echo "sway config backed up successfully."

if test -f "$SCRIPT_DIR/footconfig"; then
    echo "Overwriting foot config backup..."
else
    echo "Backing up foot config..."
fi
cp ~/.config/foot/foot.ini "$SCRIPT_DIR/footconfig" && echo "foot config backed up successfully."

if test -f "$SCRIPT_DIR/i3blocksconfig"; then
    echo "Overwriting i3blocks config backup..."
else
    echo "Backing up i3blocks config..."
fi
cp ~/.config/i3blocks/config "$SCRIPT_DIR/i3blocksconfig" && echo "i3blocks config backed up successfully."

if test -f "$SCRIPT_DIR/kittyconfig"; then
    echo "Overwriting kitty config backup..."
else
    echo "Backing up kitty config..."
fi
cp ~/.config/kitty/kitty.conf "$SCRIPT_DIR/kittyconfig" && echo "kitty config backed up successfully."

if test -f "$SCRIPT_DIR/bashrc"; then
    echo "Overwriting ~/.bashrc backup..."
else
    echo "Backing up ~/.bashrc..."
fi
cp ~/.bashrc "$SCRIPT_DIR/bashrc" && echo "~/.bashrc backed up successfully."


echo "Backing up neovim lua config files..."
find ~/.config/nvim/lua -mindepth 1 | xargs -I{} cp {} "$SCRIPT_DIR/nvim-config/" && echo "neovim config files backed up successfully."

echo "Backing up i3blocks scripts..."
find ~/computer/i3blocks-scripts -mindepth 1 -maxdepth 1 -path ~/computer/i3blocks-scripts/venv -prune -o -print | grep -v ~$ | xargs -I{} cp {} "$SCRIPT_DIR/i3blocks-scripts/" && echo "i3blocks scripts backed up successfully."
