if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
set -gx DOCKER_BUILDKIT 0
set -U fish_greeting ""


# pnpm
set -gx PNPM_HOME "/home/drew/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

abbr --add cl clear
abbr --add vi nvim
