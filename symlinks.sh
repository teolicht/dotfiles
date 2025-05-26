#!/bin/bash

# Define source and destination pairs using an array
SYMLINKS=(
    "$HOME/.dotfiles/nvim|$HOME/.config/nvim"
    "$HOME/.dotfiles/tmux|$HOME/.config/tmux"
    "$HOME/.dotfiles/ghostty|$HOME/.config/ghostty"
    "$HOME/.dotfiles/wezterm|$HOME/.config/wezterm"
    "$HOME/.dotfiles/aerospace|$HOME/.config/aerospace"
    "$HOME/.dotfiles/jankyborders|$HOME/.config/borders"
    "$HOME/.dotfiles/sketchybar|$HOME/.config/sketchybar"
    "$HOME/.dotfiles/karabiner/karabiner.json|$HOME/.config/karabiner/karabiner.json"
    "$HOME/.dotfiles/zsh/.zshrc|$HOME/.zshrc"
    "$HOME/.dotfiles/zsh/oh-my-zsh/custom/aliases.zsh|$HOME/.oh-my-zsh/custom/aliases.zsh"
    "$HOME/.dotfiles/zsh/oh-my-zsh/custom/typewritten.zsh|$HOME/.oh-my-zsh/custom/typewritten.zsh"
    "$HOME/.dotfiles/vscode/settings.json|$HOME/Library/Application Support/Code/User/settings.json"
)

# Loop through each entry
for entry in "${SYMLINKS[@]}"; do
    # Split the string on |
    src="${entry%%|*}"
    dest="${entry##*|}"

    # Ensure the parent directory exists
    mkdir -p "$(dirname "$dest")"

    # Remove existing file/directory if it exists
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "Removing existing: $dest"
        rm -rf "$dest"
    fi

    # Create the symlink
    ln -s "$src" "$dest"
    echo "Created symlink: $dest -> $src"
done

echo "All symlinks created successfully!"
