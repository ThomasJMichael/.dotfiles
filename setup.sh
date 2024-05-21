#!/bin/bash

# Define usage function
usage() {
    echo "Usage: $0 {personal|work} [--clean]"
    exit 1
}

# Check for arguments
if [ "$#" -lt 1 ]; then
    usage
fi

# Set variables based on arguments
CONFIG=$1
CLEAN=false
if [ "$2" == "--clean" ]; then
    CLEAN=true
fi

# Define directories
DOTFILES_DIR="$HOME/.dotfiles"
GIT_DIR="$DOTFILES_DIR/git/$CONFIG"
NVIM_DIR="$DOTFILES_DIR/nvim"
TMUX_DIR="$DOTFILES_DIR/tmux"
BASH_DIR="$DOTFILES_DIR/bash"
# PRIVATE_REPO_DIR="$DOTFILES_DIR/private"
BACKUP_DIR="$HOME/dotfiles_backup"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Helper function to handle moving files
move_files() {
    local source_dir=$1
    local target_dir=$2

    for file in $(find "$source_dir" -type f); do
        target_file="${target_dir}/${file#$source_dir/}"
        if [ -e "$target_file" ]; then
            mkdir -p "$(dirname "$target_file")"
            mv "$target_file" "$BACKUP_DIR/${file#$source_dir/}"
        fi
    done
}

# Function to backup existing configurations by moving them
backup_configs() {
    echo "Backing up existing configurations..."

    move_files "$GIT_DIR" "$HOME"
    move_files "$NVIM_DIR" "$HOME"
    move_files "$TMUX_DIR" "$HOME"
    move_files "$BASH_DIR" "$HOME"

    echo "Backup complete."
}

# Function to restore original configurations
restore_configs() {
    echo "Restoring original configurations..."

    move_files "$BACKUP_DIR/$GIT_DIR" "$HOME"
    move_files "$BACKUP_DIR/$NVIM_DIR" "$HOME"
    move_files "$BACKUP_DIR/$TMUX_DIR" "$HOME"
    move_files "$BACKUP_DIR/$BASH_DIR" "$HOME"

    echo "Restore complete."
}

# Function to stow configurations
stow_configs() {
    echo "Stowing configurations for $CONFIG..."

    cd $DOTFILES_DIR

    if [ -d "git/$CONFIG" ]; then
        echo "Stowing git/$CONFIG..."
        stow -v --target=$HOME -d "$DOTFILES_DIR/git" "$CONFIG"
    else
        echo "Directory git/$CONFIG does not exist. Skipping."
    fi

    if [ -d "nvim" ]; then
        echo "Stowing nvim..."
        stow -v --target=$HOME -d "$DOTFILES_DIR" "nvim"
    else
        echo "Directory nvim does not exist. Skipping."
    fi

    if [ -d "tmux" ]; then
        echo "Stowing tmux..."
        stow -v --target=$HOME -d "$DOTFILES_DIR" "tmux"
    else
        echo "Directory tmux does not exist. Skipping."
    fi

    if [ -d "bash" ]; then
        echo "Stowing bash..."
        stow -v --target=$HOME -d "$DOTFILES_DIR" "bash"
    else
        echo "Directory bash does not exist. Skipping."
    fi

    echo "Stowing complete."
}

# Function to clean existing configurations
clean_configs() {
    echo "Cleaning configurations for $CONFIG..."

    cd $DOTFILES_DIR

    if [ -d "git/$CONFIG" ]; then
        echo "Unstowing git/$CONFIG..."
        stow -D --target=$HOME -d "$DOTFILES_DIR/git" "$CONFIG"
    else
        echo "Directory git/$CONFIG does not exist. Skipping."
    fi

    if [ -d "nvim" ]; then
        echo "Unstowing nvim..."
        stow -D --target=$HOME -d "$DOTFILES_DIR" "nvim"
    else
        echo "Directory nvim does not exist. Skipping."
    fi

    if [ -d "tmux" ]; then
        echo "Unstowing tmux..."
        stow -D --target=$HOME -d "$DOTFILES_DIR" "tmux"
    else
        echo "Directory tmux does not exist. Skipping."
    fi

    if [ -d "bash" ]; then
        echo "Unstowing bash..."
        stow -D --target=$HOME -d "$DOTFILES_DIR" "bash"
    else
        echo "Directory bash does not exist. Skipping."
    fi

    restore_configs

    echo "Cleaning complete."
}

# Function to install dependencies
install_dependencies() {
    echo "Installing dependencies..."
    if [ -f $DOTFILES_DIR/scripts/install_deps.sh ]; then
        bash $DOTFILES_DIR/scripts/install_deps.sh
    else
        echo "Error: Dependencies script not found."
    fi
    echo "Dependencies installed."
}

# Main script execution
install_dependencies
if [ "$CLEAN" == true ]; then
    clean_configs
else
    backup_configs
    stow_configs
fi

echo "Setup complete for $CONFIG."
