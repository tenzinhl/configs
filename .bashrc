# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
bind 'set bell-style none'
alias mv='mv -i' # Set all moves to be interactive by default (to not accidentally overwrite)
alias cp='cp -i'
export PROMPT_COMMAND=
export LESS=FRX-Q
export LC_CTYPE=C.UTF-8
# Ignore duplicate commands in bash history
export HISTCONTROL=ignoreboth:erasedups

