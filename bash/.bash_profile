# Source the .bashrc if it exists
if [ -f ~/.bashrc ]; then
	    . ~/.bashrc
fi

# Set environment variables
export EDITOR=nvim
export VISUAL=nvim
export LANG=en_US.UTF-8
export DOTFILES_DIR="$HOME/.dotfiles"

addToPath() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH=$PATH:$1
    fi
}

addToPathFront() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH=$1:$PATH
    fi
}

addToPathFront "$HOME/.local/bin"

if command -v tmux > /dev/null && [ -z "$TMUX" ]; then
  tmux_auto.sh
fi
