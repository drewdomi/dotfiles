if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting

set -gx PATH "$VOLTA_HOME/bin" $PATH

# Set Volta PATH
set -gx VOLTA_HOME "$HOME/.volta"

# Set Volta SDKMAN PATH
set -gx SDKMAN_DIR "$HOME/.sdkman"

# Set PNPM PATH
set -gx PNPM_HOME "/home/drew/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

# Fix pipewire not work properly on enter in Hyprland
abbr --add fix-pipewire "pkill pipewire; pipewire & disown"
abbr --add cl clear
