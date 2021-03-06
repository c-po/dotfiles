# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# machine aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# machine local aliases
if [ -f ~/local.bash_aliases ]; then
    . ~/local.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# use a nice looking terminal
TERM="xterm-256color"

# add a fancy prompt
PS1="(\A) \[\033[01;37m\]\u\[\033[01;31m\] \h\[\033[00m\]:\w # "

function git-branch-name {
  git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3
}
function git-branch-prompt {
  local branch=`git-branch-name`
  if [ $branch ]; then printf " [%s]" $branch; fi
}

PS1="(\A) \[\033[01;37m\]\u\[\033[01;31m\] \h\[\033[00m\]:\w\$(git-branch-prompt) # "

if [ -f ~/.ssh/id_rsa ] || [ -f ~/.ssh/id_ed25519 ] || [ -f ~/.ssh/id_ecdsa ]; then
    if [ -x "$(command -v keychain)" ]; then
        for key in $(find $HOME/.ssh -type f ! -name "*.*" -name "id_*"); do
            keychain --nogui $key
        done
        source $HOME/.keychain/$HOSTNAME-sh
    else
        if [ ! -S ~/.ssh/ssh_auth_sock ]; then
            eval `ssh-agent`
            ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
        fi
        export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
        ssh-add -l > /dev/null || ssh-add
    fi
fi

stty ixany
stty ixoff -ixon

# CDir on WSL hosts to real home instead of /mnt/c/Users/<username> Windows home
if [[ ! -f /.dockerenv ]] && [[ "$(< /proc/sys/kernel/osrelease)" == *[Mm]icrosoft* ]]; then
    cd
fi

export EMAIL="christian@poessinger.com"
export NAME="Christian Poessinger"
export PYTHONSTARTUP=~/.pythonrc
