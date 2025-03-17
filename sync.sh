#!/bin/bash

# Configuration
CONFIG_DIR="$HOME/.config"
DOTFILES_DIR="$HOME/Projects/dotfiles"
UNISON_PROFILES_DIR="$HOME/.unison"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default sync direction, can be:
# "config-to-dotfiles" to force ~/.config to override dotfiles
# "dotfiles-to-config" to force dotfiles to override ~/.config
# "ask" to prompt for each conflict
# "skip" to skip conflicts
SYNC_DIRECTION="ask"

# Function to print status messages
print_status() {
  echo -e "${YELLOW}[INFO]${NC} $1"
}

print_success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

print_prompt() {
  echo -e "${BLUE}[PROMPT]${NC} $1"
}

# Print usage information
usage() {
  echo "Usage: $0 [options]"
  echo
  echo "Options:"
  echo "  -h, --help                  Show this help message"
  echo "  -d, --direction DIRECTION   Set sync direction. One of:"
  echo "                               config-to-dotfiles: Force ~/.config to override dotfiles"
  echo "                               dotfiles-to-config: Force dotfiles to override ~/.config"
  echo "                               ask: Prompt for each conflict (default)"
  echo "                               skip: Skip conflicts"
  echo "  -p, --profile PROFILE       Sync only the specified profile"
  echo
  echo "When using interactive mode (ask), you'll need to respond to conflicts with:"
  echo "  >    Use the file from the left side (your ~/.config)"
  echo "  <    Use the file from the right side (your dotfiles)"
  echo "  f    Follow with more detailed options"
  echo "  i    Ignore this file"
  echo "  m    Merge the files (if they're text files)"
  echo "  q    Quit the synchronization"
  echo
  exit 1
}

# Process command line arguments
PROFILE_FILTER=""

while [[ $# -gt 0 ]]; do
  case $1 in
  -h | --help)
    usage
    ;;
  -d | --direction)
    if [[ "$2" == "config-to-dotfiles" || "$2" == "dotfiles-to-config" || "$2" == "ask" || "$2" == "skip" ]]; then
      SYNC_DIRECTION="$2"
      shift
    else
      print_error "Invalid direction: $2"
      usage
    fi
    ;;
  -p | --profile)
    PROFILE_FILTER="$2"
    shift
    ;;
  *)
    print_error "Unknown option: $1"
    usage
    ;;
  esac
  shift
done

# Check if Unison is installed
if ! command -v unison &>/dev/null; then
  print_error "Unison is not installed. Please install it first."
  exit 1
fi

# Create the dotfiles directory if it doesn't exist
if [ ! -d "$DOTFILES_DIR" ]; then
  print_status "Creating dotfiles directory at $DOTFILES_DIR"
  mkdir -p "$DOTFILES_DIR"
fi

# Find all .prf files in the Unison profiles directory
if [ -n "$PROFILE_FILTER" ]; then
  PRF_FILES="$UNISON_PROFILES_DIR/$PROFILE_FILTER.prf"
  if [ ! -f "$PRF_FILES" ]; then
    print_error "Profile $PROFILE_FILTER not found in $UNISON_PROFILES_DIR"
    exit 1
  fi
else
  PRF_FILES=$(find "$UNISON_PROFILES_DIR" -name "*.prf")
  if [ -z "$PRF_FILES" ]; then
    print_error "No profile files found in $UNISON_PROFILES_DIR"
    exit 1
  fi
  print_status "Found $(echo "$PRF_FILES" | wc -l | tr -d ' ') profile files"
fi

# Process each profile
for profile_file in $PRF_FILES; do
  # Extract profile name without extension
  profile_name=$(basename "$profile_file" .prf)

  print_status "Syncing $profile_name..."

  # Prepare Unison options based on sync direction
  UNISON_OPTS="-terse"
  DIRECTION_PROMPT=""

  case "$SYNC_DIRECTION" in
  "config-to-dotfiles")
    # Force ~/.config to override dotfiles
    UNISON_OPTS="$UNISON_OPTS -force $CONFIG_DIR"
    DIRECTION_PROMPT="(config → dotfiles)"
    ;;
  "dotfiles-to-config")
    # Force dotfiles to override ~/.config
    UNISON_OPTS="$UNISON_OPTS -force $DOTFILES_DIR"
    DIRECTION_PROMPT="(dotfiles → config)"
    ;;
  "skip")
    # Skip conflicts by using batch mode
    UNISON_OPTS="$UNISON_OPTS -batch"
    DIRECTION_PROMPT="(skipping conflicts)"
    ;;
  "ask")
    # Interactive mode, will prompt for each conflict
    DIRECTION_PROMPT="(interactive)"
    ;;
  esac

  print_status "Syncing $profile_name $DIRECTION_PROMPT..."

  # Run Unison with the profile
  if [ "$SYNC_DIRECTION" == "ask" ]; then
    # Interactive mode
    unison "$profile_name" $UNISON_OPTS
  else
    # Non-interactive mode
    unison "$profile_name" $UNISON_OPTS
  fi

  if [ $? -eq 0 ]; then
    print_success "Synced $profile_name successfully"
  else
    print_error "Failed to sync $profile_name"
  fi
done

print_status "All syncing operations completed"
