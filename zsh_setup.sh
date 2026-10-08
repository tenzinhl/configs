#!/bin/zsh

# Setup script for ZSH configuration
# source this script to setup all configs + required extensions for using ZSH

# Function to clone a git repository if it doesn't exist
clone_if_not_exists() {
    local repo_url="$1"
    local target_dir="$2"
    if [ ! -d "$target_dir" ]; then
        git clone "$repo_url" "$target_dir"
    else
        echo "Directory $target_dir already exists. Skipping clone."
    fi
}

# Create .zsh directory if it doesn't exist
mkdir -p ~/.zsh

# Install zsh-autosuggestions
clone_if_not_exists https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions

# Install zsh-syntax-highlighting
clone_if_not_exists https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

# Install zsh-history-substring-search
clone_if_not_exists https://github.com/zsh-users/zsh-history-substring-search.git ~/.zsh/zsh-history-substring-search

# Hook the shared config into ~/.zshrc by sourcing it from this repo (rather than
# copying it over), so ~/.zshrc stays the place for machine-specific overrides and
# edits to the shared config apply directly to this repo.
shared_zshrc="${${(%):-%x}:A:h}/.zshrc"
source_line="[[ -f \"$shared_zshrc\" ]] && source \"$shared_zshrc\""

if [ -f ~/.zshrc ] && grep -qF "$source_line" ~/.zshrc; then
    echo "~/.zshrc already sources $shared_zshrc. Skipping."
else
    if [ -f ~/.zshrc ]; then
        echo "Appending source line to existing ~/.zshrc. If it was copied from this repo by an"
        echo "older version of this script, remove the duplicated content from it."
    fi
    cat >> ~/.zshrc <<EOS

# Shared zsh config (added by zsh_setup.sh). Put machine-specific overrides below this line.
$source_line
EOS
    echo "~/.zshrc now sources $shared_zshrc"
fi

echo "ZSH setup complete. Please restart your terminal or run 'source ~/.zshrc' to apply changes."
