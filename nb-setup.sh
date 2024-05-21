#!/bin/bash
if [ -f "$HOME/.local/bin/nb" ]; then
  echo "Setting up notebooks..."
  $HOME/.local/bin/nb init https://github.com/vincentezw/notes.git main
  $HOME/.local/bin/nb notebooks add play https://github.com/vincentezw/notes.git play
else
  echo "nb not found, skipping setting up notebooks"
fi
