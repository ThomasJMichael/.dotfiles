#!/bin/bash

# Get the list of existing tmux sessions
sessions=$(tmux ls 2>/dev/null)

if [ $? -ne 0 ]; then
    # No tmux sessions found, create a new one
    tmux new-session -s my_session
else
    # Count the number of existing sessions
    session_count=$(echo "$sessions" | wc -l)

    if [ $session_count -eq 1 ]; then
        # Only one session exists, attach to it
        session_name=$(echo "$sessions" | awk -F: '{print $1}')
        tmux attach-session -t "$session_name"
    else
        # Multiple sessions exist, use fzf to select one
        session_name=$(echo "$sessions" | awk -F: '{print $1}' | fzf --prompt="Select a tmux session: ")
        if [ -n "$session_name" ]; then
            tmux attach-session -t "$session_name"
        else
            echo "No session selected. Exiting."
            exit 1
        fi
    fi
fi

