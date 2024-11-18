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

# Generate and use LS_COLORS
if type dircolors > /dev/null 2>&1; then
    eval "$(dircolors -b)"
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
else
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# Enable completion (some config stolen from https://github.com/Aloxaf/fzf-tab?tab=readme-ov-file#fzf-tab)
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select # Menu selection for completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # file colors

# ==========
# PROMPT SETUP
# ==========

setopt PROMPT_SUBST

# Function to shorten path like Fish shell
function shortened_path() {
    local path_components=(${(s:/:)PWD})
    local result=""
    
    # Handle home directory
    if [[ $PWD == $HOME* ]]; then
        result="~"
        path_components=(${path_components[@]:${#${(s:/:)HOME}}})
    elif [[ $PWD == "/" ]]; then
        echo "/"
        return
    fi
    
    # Shorten all but the last component
    for ((i=1; i<${#path_components[@]}; i++)); do
        result+="/${path_components[i][1]}"
    done
    
    # Add the last component in full
    if ((${#path_components[@]} > 0)); then
        result+="/${path_components[-1]}"
    fi
    
    echo ${result}  # Remove leading slash if present
}

# This is a special zsh function that is called before each prompt is displayed. Set any variables
# that you want to use in your prompt here.
function precmd() {
    shortened_path="$(shortened_path)"
}

# Somewhere along the line the PROMPT var is being set to something
# that's bash-style, so we need to explicitly set it to something that zsh
# will print properly.
PROMPT='%F{green}%n@%m%f %F{blue}${shortened_path}%f%(?..%F{red} [%?]%f)> '

# ===========
# COLORS/ZSH OPTS
# ===========

# Set the terminal to xterm-256color so that colors work properly (in some
# old and rare environments it gets set to non 256 color which messes with
# colors used by things like zsh suggestions). If colors have issues you can
# try unsetting this.)
TERM='xterm-256color'

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

# Up + Down do substring history search.
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Additional way to bind up + down that works in some environemnts where ^[[A doesn't work.
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# ==== Fuzzy Finding ====

# Use fzf for fuzzy finding.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
