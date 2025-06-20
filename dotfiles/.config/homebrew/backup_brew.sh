#!/bin/bash
BREWFILE_PATH="$HOME/ghq/github.com/archcorsair/nix-macos/dotfiles/.config/homebrew"
/opt/homebrew/bin/brew bundle dump --file="$BREWFILE_PATH" --force
cd "$HOME/.config"
git add "homebrew/Brewfile"
git commit -m "chore: Brewfile Automated Backup"
