if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Setup fzf (minus ctrl + R)
if command -v fzf >/dev/null 2>&1
    fzf --fish | source
    bind --erase \cr
end

# Add iterm integration when in a Mac environment where iterm2 is installed
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
