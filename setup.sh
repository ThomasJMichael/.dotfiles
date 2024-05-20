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

# Function to stow configurations
stow_configs() {
    echo "Stowing configurations for $CONFIG..."

    stow -v --target=$HOME -d $GIT_DIR
    stow -v --target=$HOME -d $NVIM_DIR
    stow -v --target=$HOME -d $TMUX_DIR
    stow -v --target=$HOME -d $BASH_DIR

    # Uncomment the following lines when you add the private repo
    # if [ -d "$PRIVATE_REPO_DIR/$CONFIG" ]; then
    #     stow -v --target=$HOME -d $PRIVATE_REPO_DIR/$CONFIG
    # fi

    echo "Stowing complete."
}

# Function to clean existing configurations
clean_configs() {
    echo "Cleaning configurations for $CONFIG..."

    stow -D --target=$HOME -d $GIT_DIR
    stow -D --target=$HOME -d $NVIM_DIR
    stow -D --target=$HOME -d $TMUX_DIR
    stow -D --target=$HOME -d $BASH_DIR

    # Add the private dotfiles repo
    # if [ -d "$PRIVATE_REPO_DIR/$CONFIG" ]; then
    #     stow -D --target=$HOME -d $PRIVATE_REPO_DIR/$CONFIG
    # fi

    echo "Cleaning complete."
}

# Function to install dependencies
install_dependencies() {
    echo "Installing dependencies for $CONFIG..."
    if [ "$CONFIG" == "personal" ]; then
        bash $DOTFILES_DIR/scripts/install_personal_dependencies.sh
    elif [ "$CONFIG" == "work" ]; then
        bash $DOTFILES_DIR/scripts/install_work_dependencies.sh
    fi
    echo "Dependencies installed."
}

# # Function to setup private repo
# setup_private_repo() {
#     if [ ! -d "$PRIVATE_REPO_DIR" ]; then
#         git submodule add git@github.com:yourusername/private-configs.git $PRIVATE_REPO_DIR
#         git submodule update --init --recursive
#     else
#         git submodule update --recursive --remote
#     fi
# }

# Main script execution
if [ "$CLEAN" == true ]; then
    clean_configs
fi

# setup_private_repo

stow_configs
install_dependencies

echo "Setup complete for $CONFIG."
