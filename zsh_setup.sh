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

# Backup existing .zshrc if it exists
if [ -f ~/.zshrc ]; then
    backup_file=~/.zshrc.backup
    counter=1
    while [ -f "$backup_file" ]; do
        backup_file=~/.zshrc.backup.$counter
        ((counter++))
    done
    mv ~/.zshrc "$backup_file"
    echo "Existing .zshrc backed up to $backup_file"
fi

# Copy the new .zshrc to the home directory
cp .zshrc ~/.zshrc
echo "New .zshrc copied to home directory"

echo "ZSH setup complete. Please restart your terminal or run 'source ~/.zshrc' to apply changes."
