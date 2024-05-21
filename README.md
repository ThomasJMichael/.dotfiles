# Dotfiles

This repository contains my personal and work dotfiles for configuring my development environment. The setup script handles backing up existing configurations, stowing new configurations, and installing dependencies.

## Supported Distributions

- Ubuntu
- Fedora

## Usage

To setup your dotfiles, run the `setup.sh` script with the appropriate configuration (`personal` or `work`). You can also clean the setup by using the `--clean` flag.
```
./setup.sh {personal|work} [--clean]
```

### Examples

- To setup the `work` configuration:
```
  ./setup.sh work
```

- To clean the `work` configuration and restore the previous setup:
```
  ./setup.sh work --clean
```

## Notes

- Backup any important data before running the setup script.
- You will need to manually handle installing tmux, TPM, and neovim.
