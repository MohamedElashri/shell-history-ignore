#!/usr/bin/env sh

# Detect the shell
if [ -n "$ZSH_VERSION" ]; then
    CURRENT_SHELL="zsh"
elif [ -n "$BASH_VERSION" ]; then
    CURRENT_SHELL="bash"
else
    echo "Unsupported shell. This script works with Bash and ZSH only."
    exit 1
fi

# Default ignore list
DEFAULT_IGNORE_COMMANDS=(
    # Directory listing
    "ls" "exa" "eza" "lsd" "l" "ll" "la"
    # Directory navigation
    "pwd" "cd" "pushd" "popd" "dirs"
    # File operations
    "cp" "mv" "rm" "touch" "mkdir" "rmdir"
    # Text viewing
    "cat" "less" "more" "head" "tail"
    # System info
    "uname" "hostname" "whoami" "id"
    # Process management
    "ps" "top" "htop"
    # Network
    "ping" "ifconfig" "ip" "netstat" "ss"
    # Package management
    "apt" "apt-get" "yum" "dnf" "pacman" "brew"
    # Version control
    "git"
    # Shell built-ins
    "echo" "printf" "true" "false"
    # History commands
    "history" "fc"
    # Other common utilities
    "clear" "exit" "which" "whereis" "whatis"
    "man" "info" "help"
    # Time and date
    "date" "time"
    # File permissions
    "chmod" "chown" "chgrp"
    # Compression
    "tar" "gzip" "gunzip" "zip" "unzip"
    # Disk usage
    "df" "du"
    # Text processing
    "grep" "sed" "awk" "cut" "sort" "uniq" "wc"
    # macOS specific
    "open" "pbcopy" "pbpaste"
)

# Config file location
CONFIG_FILE="${HOME}/.shell_history_ignore_config"

# Function to load config
load_config() {
    if [ -f "$CONFIG_FILE" ]; then
        . "$CONFIG_FILE"
    fi
}

# Function to save config
save_config() {
    printf "IGNORE_COMMANDS=(" > "$CONFIG_FILE"
    printf "\"%s\" " "${IGNORE_COMMANDS[@]}" >> "$CONFIG_FILE"
    printf ")\n" >> "$CONFIG_FILE"
}

# Load config if exists, otherwise use defaults
load_config
IGNORE_COMMANDS=${IGNORE_COMMANDS:-$DEFAULT_IGNORE_COMMANDS}

# Function to add command to ignore list
add_ignore_command() {
    IGNORE_COMMANDS+=("$1")
    save_config
    update_history_ignore
}

# Function to remove command from ignore list
remove_ignore_command() {
    new_ignore_commands=()
    for cmd in "${IGNORE_COMMANDS[@]}"; do
        if [ "$cmd" != "$1" ]; then
            new_ignore_commands+=("$cmd")
        fi
    done
    IGNORE_COMMANDS=("${new_ignore_commands[@]}")
    save_config
    update_history_ignore
}

# Function to update HISTORY_IGNORE
update_history_ignore() {
    if [ "$CURRENT_SHELL" = "zsh" ]; then
        HISTORY_IGNORE="(${(j:|:)IGNORE_COMMANDS})[[:space:]]*"
    elif [ "$CURRENT_SHELL" = "bash" ]; then
        HISTIGNORE=$(IFS=:; echo "${IGNORE_COMMANDS[*]}*")
    fi
}

# Initial setup of HISTORY_IGNORE
update_history_ignore

# Add to shell startup files if not already present
add_to_startup_file() {
    local startup_file="$1"
    local script_path="$2"
    if ! grep -q "source $script_path" "$startup_file"; then
        echo "source $script_path" >> "$startup_file"
        echo "Added to $startup_file"
    fi
}

script_path=$(realpath "$0")
if [ "$CURRENT_SHELL" = "zsh" ]; then
    add_to_startup_file "$HOME/.zshrc" "$script_path"
elif [ "$CURRENT_SHELL" = "bash" ]; then
    add_to_startup_file "$HOME/.bashrc" "$script_path"
fi

# Print current ignore list
print_ignore_list() {
    echo "Current ignore list:"
    for cmd in "${IGNORE_COMMANDS[@]}"; do
        echo "  $cmd"
    done
}

# Help function
print_help() {
    echo "Usage:"
    echo "  add_ignore_command <command>    - Add a command to the ignore list"
    echo "  remove_ignore_command <command> - Remove a command from the ignore list"
    echo "  print_ignore_list               - Print the current ignore list"
}

# Make functions available in the shell
if [ "$CURRENT_SHELL" = "zsh" ]; then
    autoload -U add_ignore_command remove_ignore_command print_ignore_list print_help
elif [ "$CURRENT_SHELL" = "bash" ]; then
    export -f add_ignore_command remove_ignore_command print_ignore_list print_help
fi