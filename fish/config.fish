if status is-interactive
    # Commands to run in interactive sessions can go here
end

# pnpm
set -gx PNPM_HOME "/home/drew/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

set -U fish_greeting ""
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

abbr --add cl clear
abbr --add vi nvim

abbr --add runMain "cd src/; javac -d ../bin Main.java && cd ../bin; java Main; cd ../"
