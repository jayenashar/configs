# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
unset HISTFILESIZE
HISTSIZE=1000000
HISTTIMEFORMAT='%a, %d %b %Y %H:%M:%S %z '

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files
# see lesspipe(1) and source-highlight(1)
if [ -x /usr/bin/lesspipe ]; then
  eval "$(SHELL=/bin/sh lesspipe)"
  if [ -r /usr/share/source-highlight/src-hilite-lesspipe.sh ]; then
    if [ ! -e "${HOME}/.lessfilter" ]; then
      sed -r 's@ --failsafe(.*)(#|$|;;)@\12>/dev/null \2@' \
        /usr/share/source-highlight/src-hilite-lesspipe.sh > \
        "${HOME}/.lessfilter"
      chmod +x "${HOME}/.lessfilter"
    fi
  fi
else
  if [ -x /usr/share/source-highlight/src-hilite-lesspipe.sh ]; then
    export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
  fi
fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm*) color_prompt=yes;;
    screen*) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'

    export GREP_OPTIONS='-T --color=auto'
    #found text is green and not red
    export GREP_COLOR='01;32'
    export GREP_COLORS='ms=01;32:mc=01;32:sl=:cx=:fn=35:ln=32:bn=32:se=36'
fi

# some more ls aliases
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -CF'

if type rgrep >/dev/null 2>&1; then
    alias rgrep='grep -r'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

alias sshfs='sshfs -o reconnect -o gid=`id -g` -o idmap=user -o allow_root'
alias mount.csefs='sshfs -o "ControlPath=/tmp/sshfs.cse" cse: ~/cse'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias wcc='gcc -Wall -Werror'
alias mcc='gcc -Wall -Werror -fmudflap -lmudflap'
alias netstat='netstat -e -p -c -a -o -t -u -w --ax25 --ipx --netrom'
alias i='sudo aptitude install'
alias r='sudo aptitude purge'
alias sudo='sudo '

bind "\C-f":forward-search-history

IGNOREEOF=1

# case-insensitive globs
shopt -s nocaseglob

# useful for merging changes up in git
function gitmergeup {
  (set -e
   git remote prune origin
   oldbranch=
   for branch in "$@"; do
     git checkout $branch
     git pull --rebase
     [[ x"$oldbranch" == x ]] || git merge $oldbranch
     oldbranch=$branch
   done
   git push)
}
