# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

export PS1="[\[\033[01;32m\]\u\[\033[00m\]@\h:\[\e[01;34m\]\W\[\033[00m\]]\\$ \[$(tput sgr0)\]"
