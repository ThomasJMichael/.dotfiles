# Source the .bashrc if it exists
if [ -f ~/.bashrc ]; then
	    . ~/.bashrc
fi

# Set PATH so it includes user's private bin directories
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Set environment variables
export EDITOR=nvim
export VISUAL=nvim
export LANG=en_US.UTF-8

