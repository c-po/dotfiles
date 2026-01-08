# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

# helper to check if running inside a container
is_container() {
  # 1. Check for the 'container=podman' environment variable (most reliable for Podman)
  if [ -n "$container" ] && [ "$container" == "podman" ]; then
    return 0
  fi

  # 2. Check for the /.dockerenv file (Docker)
  if [ -f /.dockerenv ]; then
    return 0
  fi

  # 3. Check for Kubernetes/containerd indicator
  if [ -f /run/containerd/io.containerd.runtime.v2.linux/k8s.io/containerd-shim ]; then
    return 0
  fi

  # 4. Check /proc/self/cgroup for Podman, LXC, systemd-nspawn (more general)
  if [ -f /proc/self/cgroup ]; then
    if grep -q -E 'podman|lxc|systemd-nspawn' /proc/self/cgroup; then
      return 0
    fi
  fi

  # 5. Check for common cgroup controllers (last resort - less specific)
  if [ -f /proc/1/cgroup ]; then
    if grep -q -E 'cpu|memory|blkio|pids' /proc/1/cgroup; then
      return 0
    fi
  fi

  # If none of the checks pass
  return 1
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

### CUSTOM ###

function git-branch-name {
  git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3
}
function git-branch-prompt {
  local branch=`git-branch-name`
  if [ $branch ]; then printf " [%s]" $branch; fi
}
if is_container; then
    PS1="(\A) \[\033[01;32m\]\h\[\033[00m\]:\w\$(git-branch-prompt) # "
else
    PS1="(\A) \[\033[01;37m\]\u\[\033[01;31m\] \h\[\033[00m\]:\w\$(git-branch-prompt) # "
fi

export EMAIL="christian@breunig.cc"
export NAME="Christian Breunig"

if [ -f ~/.pythonrc ]; then
    export PYTHONSTARTUP=~/.pythonrc
fi

if ! is_container; then
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
fi

# CDir on WSL hosts to real home instead of /mnt/c/Users/<username> Windows home
if [[ ! -f /.dockerenv ]] && [[ "$(< /proc/sys/kernel/osrelease)" == *[Mm]icrosoft* ]]; then
    cd
    RUNNING=`ps aux | grep dockerd | grep -v grep`
    if [ -x /usr/bin/dockerd ] && [ -z "$RUNNING" ]; then
        sudo service docker start
    fi
fi

if [ -f /etc/ssl/certs/ca-certificates.crt ]; then
    export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
fi

if [ -f ~/local.bash_aliases ]; then
    . ~/local.bash_aliases
fi
