#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '

# my prompt
PS1="\[\033[32m\]異 \[\033[37m\]\[\033[34m\]\w \[\033[0m\]"
PS2="\[\033[32m\]  > \[\033[0m\]"

export PATH=/home/unreal/.local/bin:$PATH
export PATH=/usr/bin/:$PATH

cat /home/unreal/.cache/wal/sequences
