# Shell History Ignore Plugin

## Overview

The Shell History Ignore Plugin is a versatile tool designed to manage command history in Bash and Zsh shells. It provides a mechanism to exclude specific commands from being recorded in your shell's history, helping to maintain a cleaner and more relevant command history.

## Installation

### One-line Installation

For Bash:
```bash
curl -sSL https://raw.githubusercontent.com/MohamedElashri/shell-history-ignore/main/shell_history_ignore.sh | bash && source ~/.bashrc
```

For Zsh:
```zsh
curl -sSL https://raw.githubusercontent.com/MohamedElashri/shell-history-ignore/main/shell_history_ignore.sh | zsh && source ~/.zshrc
```

### Manual Installation

1. Clone this repository:
   ```
   git clone https://github.com/MohamedElashri/shell-history-ignore.git
   ```
2. Navigate to the cloned directory:
   ```
   cd shell-history-ignore
   ```
3. Make the script executable:
   ```
   chmod +x shell_history_ignore.sh
   ```
4. Run the script to set up:
   ```
   ./shell_history_ignore.sh
   ```
5. Source your shell configuration file:
   - For Bash: `source ~/.bashrc`
   - For Zsh: `source ~/.zshrc`

## Usage

After installation, the following functions will be available in your shell:

- `add_ignore_command <command>`: Add a command to the ignore list
- `remove_ignore_command <command>`: Remove a command from the ignore list
- `print_ignore_list`: Display the current list of ignored commands
- `print_help`: Show usage instructions

### Examples

```bash
# Add a command to the ignore list
add_ignore_command "docker"

# Remove a command from the ignore list
remove_ignore_command "git"

# View the current ignore list
print_ignore_list

# Get help
print_help
```

## Configuration

The plugin uses a configuration file located at `~/.shell_history_ignore_config`. You can manually edit this file to customize your ignore list:

```bash
IGNORE_COMMANDS=(
    "ls"
    "cd"
    "pwd"
    # Add your custom commands here
)
```

## Default Ignore List

The default ignore list includes many common commands. Here's the full list:

| Category | Commands |
|----------|----------|
| Directory Listing | ls, exa, eza, lsd, l, ll, la |
| Directory Navigation | pwd, cd, pushd, popd, dirs |
| File Operations | cp, mv, rm, touch, mkdir, rmdir |
| Text Viewing | cat, less, more, head, tail |
| System Info | uname, hostname, whoami, id |
| Process Management | ps, top, htop |
| Network | ping, ifconfig, ip, netstat, ss |
| Package Management | apt, apt-get, yum, dnf, pacman, brew |
| Version Control | git |
| Shell Built-ins | echo, printf, true, false |
| History Commands | history, fc |
| Other Utilities | clear, exit, which, whereis, whatis, man, info, help |
| Time and Date | date, time |
| File Permissions | chmod, chown, chgrp |
| Compression | tar, gzip, gunzip, zip, unzip |
| Disk Usage | df, du |
| Text Processing | grep, sed, awk, cut, sort, uniq, wc |
| macOS Specific | open, pbcopy, pbpaste |

**Note:** Commands are ignored regardless of their arguments. For example, if `git` is in the ignore list, all git commands (e.g., `git status`, `git push`, etc.) will be ignored.

## Customization

Users are encouraged to define their own list of commands to ignore. To do this:

1. Run `print_ignore_list` to see the current configuration
2. Use `remove_ignore_command` to remove any default commands you want to keep in your history
3. Use `add_ignore_command` to add any custom commands you want to ignore

Alternatively, you can directly edit the `~/.shell_history_ignore_config` file.

## Compatibility

This plugin has been tested on:
- Bash 3.2+
- Zsh 5.0+
- macOS 10.14+
- Ubuntu 18.04+

## Contributing

Contributions to the Shell History Ignore Plugin are welcome! Please feel free to submit pull requests, create issues or suggest improvements.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Disclaimer

This plugin modifies your shell's history behavior. While it has been designed to be safe and non-intrusive, please use it at your own risk. Always ensure you have backups of important data and configurations before modifying your shell environment.

The default configuration is designed to significantly reduce history clutter. It is strongly recommended that users review and customize the ignore list to suit their specific needs and workflows.
