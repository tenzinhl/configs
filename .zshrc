# General Notes: There's MANY zsh startup script locations
# that it checks. https://unix.stackexchange.com/questions/246751/how-to-know-why-and-where-the-path-env-variable-is-set
# It seems by default the PATH variable is choosing something we want, but I
# have no idea how (it may be an interaction with VSCode).
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

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

# ==== ZSH Extensions ====

# Set up auto-completions (fish style!)
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Set up zsh syntax highlighting (needs to be done before partial history search),
# but should be done as late as possible. See original repo for reasoning.
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set up partial history search
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

# ==== Keybindings ====

# ctrl + right and ctrl + left do forwards/backwards a word.
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# alt + left + alt + right do forwards/backwards a word.
bindkey "^[f" forward-word
bindkey "^[b" backward-word
bindkey "^[^[[D" backward-word
bindkey "^[^[[C" forward-word

# Up + Down do prefix history search.
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Additional way to bind up + down that works in some environemnts where ^[[A doesn't work.
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# ==== Fuzzy Finding ====

# Use fzf for fuzzy finding.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
