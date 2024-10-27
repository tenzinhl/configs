if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Setup fzf (minus ctrl + R)
if command -v fzf >/dev/null 2>&1
    fzf --fish | source
    bind --erase \cr
end
