# Drew Domi Dotfiles Manager

A simple yet powerful tool to manage your dotfiles using Unison synchronization.

## Overview

This repository contains a bash script designed to synchronize your configuration files (dotfiles) between your active system location (`~/.config`) and a backup/repository location. Unlike traditional dotfiles managers that rely on symlinks or copying files, this tool uses Unison to perform two-way synchronization, giving you more flexibility in managing your configurations.

## Features

- **Two-way synchronization** - Changes can be made in either location and synchronized
- **Multiple sync directions** - Force sync from config to repository or vice versa
- **Interactive conflict resolution** - Choose what to do when files change in both locations
- **Profile-based organization** - Manage different applications separately using Unison profiles
- **Command-line options** - Easily configure synchronization behavior

## Requirements

- Unison file synchronizer
- Bash
- Linux/macOS environment

## Installation

1. Set up Unison profiles in `~/.unison/`:
   ```
   # Example: ~/.unison/nvim.prf
   root = /home/username/.config/nvim
   root = /home/username/Projects/dotfiles/nvim
   ```

## Usage

### Basic Usage

Simply run the script to synchronize all profiles in interactive mode:

```bash
./sync.sh
```

### Command-line Options

```
Usage: ./sync.sh [options]

Options:
  -h, --help                  Show this help message
  -d, --direction DIRECTION   Set sync direction. One of:
                               config-to-dotfiles: Force ~/.config to override dotfiles
                               dotfiles-to-config: Force dotfiles to override ~/.config
                               ask: Prompt for each conflict (default)
                               skip: Skip conflicts
  -p, --profile PROFILE       Sync only the specified profile

When using interactive mode (ask), you'll need to respond to conflicts with:
  >    Use the file from the left side (your ~/.config)
  <    Use the file from the right side (your dotfiles)
  f    Follow with more detailed options
  i    Ignore this file
  m    Merge the files (if they're text files)
  q    Quit the synchronization
```

### Common Use Cases

1. **Initial backup of your configurations**:
   ```bash
   ./sync.sh --direction config-to-dotfiles
   ```

2. **Setting up a new machine**:
   ```bash
   ./sync.sh --direction dotfiles-to-config
   ```

3. **Syncing just one application's settings**:
   ```bash
   ./sync.sh --profile nvim
   ```

4. **Interactive sync (making decisions for each conflict)**:
   ```bash
   ./sync.sh --direction ask
   ```

## How it Works

The script relies on Unison profiles that define synchronization pairs. Each profile typically corresponds to one application's configuration.

For example, a `fish.prf` profile might contain:
```
# ~/.unison/fish.prf
root = /home/username/.config/fish
root = /home/username/Projects/dotfiles/fish
```

This allows the script to sync your fish shell configurations between your active config and your dotfiles repository.

## Setting Up New Profiles

1. Create a new `.prf` file in `~/.unison/` for each application you want to sync
2. Define the two root directories in each profile:
   - Your active config location (usually in `~/.config`)
   - The corresponding location in your dotfiles repository

## Benefits of Using Unison

- **True synchronization** rather than one-way linking or copying
- **Conflict detection** when files change in both locations
- **Fine-grained control** over which version of a file to keep
- **Safety** by avoiding unintentional overwrites

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

[MIT License](LICENSE)
