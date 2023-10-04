# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/homes/iws/tenzinhl/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Somewhere along the line the PROMPT var is being set to something
# that's bash-style, so we need to explicitly set it to something that zsh
# will print properly.
PROMPT='%F{green}%n@%m%f %F{blue}%~%f %# '

# Unset the expansion of "!" in double quoted strings.
setopt nobanghist

# Change widget understanding of a "word" to terminate at slashes since
# we want forward-word to stop at path separators (removes "/" from wordchars)
WORDCHARS=${WORDCHARS/\/}

# Set up auto-completions (fish style!)
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Set up zsh syntax highlighting (needs to be done before partial history search),
# but should be done as late as possible. See original repo for reasoning.
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set up partial history search
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

# ==== Keybindings ====

# ctrl + left and ctrl + right do backwards/forwards a word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
