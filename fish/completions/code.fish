# Function to complete files and directories
function __fish_code_complete_files_or_dirs
    set -l cmd (commandline -opc)
    switch $cmd[1]
        case --diff -d --goto -g
            __fish_complete_path
        case --folder-uri --user-data-dir --extensions-dir -a --add
            __fish_complete_directories
        case --install-extension --uninstall-extension
            __fish_complete_path -g "*.vsix"
        case '*'
            __fish_complete_path
    end
end

# Function to complete locales
function __fish_code_complete_locale
    commandline -a 'de en en-US es fr it ja ko ru zh-CN zh-TW bg hu pt-br tr'
end

# Function to complete log levels
function __fish_code_complete_log
    commandline -a 'critical error warn info debug trace off'
end

# Define completions
complete -c code -f -a '-d --diff --folder-uri -a --add -g --goto -n --new-window -r --reuse-window -w --wait --locale= --user-data-dir -v --version -h --help --extensions-dir --list-extensions --show-versions --install-extension --uninstall-extension --enable-proposed-api --verbose --log -s --status -p --performance --prof-startup --disable-extensions --disable-extension --inspect-extensions --update-extensions --inspect-brk-extensions --disable-gpu'

complete -c code -n '__fish_seen_subcommand_from -d --diff' -a '(__fish_code_complete_files_or_dirs)'
complete -c code -n '__fish_seen_subcommand_from -a --add --user-data-dir --extensions-dir' -a '(__fish_code_complete_files_or_dirs)'
complete -c code -n '__fish_seen_subcommand_from -g --goto' -a '(__fish_code_complete_files_or_dirs)'
complete -c code -n '__fish_seen_subcommand_from --locale' -a '(__fish_code_complete_locale)'
complete -c code -n '__fish_seen_subcommand_from --install-extension --uninstall-extension' -a '(__fish_code_complete_files_or_dirs)'
complete -c code -n '__fish_seen_subcommand_from --log' -a '(__fish_code_complete_log)'
complete -c code -n '__fish_seen_subcommand_from --disable-extension' -a '(__fish_code_complete_files_or_dirs)'

complete -c code -s d -l diff -d 'compare two files with each other' -a '(__fish_code_complete_files_or_dirs)'
complete -c code -l folder-uri -d 'open a window with given folder uri(s)' -a '(__fish_code_complete_files_or_dirs)'
complete -c code -s a -l add -d 'add folder(s) to the last active window' -a '(__fish_code_complete_files_or_dirs)'
complete -c code -s g -l goto -d 'open a file at the path on the specified line and column position' -a '(__fish_code_complete_files_or_dirs)'
complete -c code -s n -l new-window -d 'force to open a new window'
complete -c code -s r -l reuse-window -d 'force to open a file or folder in an already opened window'
complete -c code -s w -l wait -d 'wait for the files to be closed before returning'
complete -c code -l locale -d 'the locale to use (e.g. en-US or zh-TW)' -a '(__fish_code_complete_locale)'
complete -c code -l user-data-dir -d 'specify the directory that user data is kept in' -a '(__fish_code_complete_files_or_dirs)'
complete -c code -s v -l version -d 'print version'
complete -c code -s h -l help -d 'print usage'
complete -c code -l telemetry -d 'show all telemetry events which VS code collects'
complete -c code -l extensions-dir -d 'set the root path for extensions' -a '(__fish_code_complete_files_or_dirs)'
complete -c code -l list-extensions -d 'list the installed extensions'
complete -c code -l category -d 'filters installed extension list by category, when using --list-extensions'
complete -c code -l show-versions -d 'show versions of installed extensions, when using --list-extensions'
complete -c code -l install-extension -d 'install an extension' -a '(__fish_code_complete_files_or_dirs)'
complete -c code -l uninstall-extension -d 'uninstall an extension' -a '(__fish_code_complete_files_or_dirs)'
complete -c code -l update-extensions -d 'update the installed extensions'
complete -c code -l enable-proposed-api -d 'enables proposed API features for extensions'
complete -c code -l verbose -d 'print verbose output (implies --wait)'
complete -c code -l log -d 'log level to use' -a '(__fish_code_complete_log)'
complete -c code -s s -l status -d 'print process usage and diagnostics information'
complete -c code -s p -l performance -d 'start with the "Developer: Startup Performance" command enabled'
complete -c code -l prof-startup -d 'run CPU profiler during startup'
complete -c code -l disable-extensions -d 'disable all installed extensions'
complete -c code -l disable-extension -d 'disable an extension' -a '(__fish_code_complete_files_or_dirs)'
complete -c code -l inspect-extensions -d 'allow debugging and profiling of extensions'
complete -c code -l inspect-brk-extensions -d 'allow debugging and profiling of extensions with the extension host being paused after start'
complete -c code -l disable-gpu -d 'disable GPU hardware acceleration'
complete -c code -d 'file or directory' -a '(__fish_code_complete_files_or_dirs)'
