
set -gx DOCKER_BUILDKIT 1
set -gx CAPACITOR_ANDROID_STUDIO_PATH "/home/drew/.local/share/JetBrains/Toolbox/apps/android-studio/bin/studio.sh"
set -gx ANDROID_HOME "/home/drew/Android/Sdk"
set -gx KUBE_EDITOR "nvim"
set -gx CHROME_EXECUTABLE "/usr/bin/google-chrome-stable"
set -gx HISTTIMEFORMAT "%d/%m/%y %T "

abbr -a k kubectl

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims


# pnpm
set -gx PNPM_HOME "/home/drew/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
set -gx PATH /usr/share/dotnet $PATH
set -Ux PATH $PATH $HOME/.dotnet/tools

### ---------------------------------------- ###
starship init fish | source
