### .bashrc
# Dimitrios Paraschas (paraschas@gmail.com)

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# a copy of the default .bashrc resides in /etc/skel/.bashrc


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


### history

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# TODO
# erase previous entries of the current command from the history

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

### /history


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


### prompt

# ### older implementation
# # http://xta.github.io/HalloweenBash/
# # see also https://github.com/twolfson/sexy-bash-prompt
# parse_git_branch() {
#     git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
# }
# export PS1="\u@\h:\W \$(parse_git_branch)$ "
#
# # Bash prompt
# set_bash_prompt() {
#     # whenever displaying the prompt, write the previous line to disk
#     # http://www.ukuug.org/events/linux2003/papers/bash_tips/
#     history -a
#     # http://superuser.com/questions/79972/set-the-title-of-the-terminal-window-to-the-current-directory
#     echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"
#     #echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"
# }
# PROMPT_COMMAND=set_bash_prompt

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
    #xterm-color) color_prompt=yes;;
#esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt


### git prompt
# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
if [ -f ~/dotfiles/.git-prompt.sh ]; then
    source ~/dotfiles/.git-prompt.sh
fi
#PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
#PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
PROMPT_COMMAND='__git_ps1 "\u@\h \W" "\\\$ "'
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWCOLORHINTS=1

### /prompt


### title

## If this is an xterm set the title to user@host:dir
#case "$TERM" in
#    xterm*|rxvt*)
#        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#        ;;
#    *)
#        ;;
#esac

### /title


## enable color support of ls and also add handy aliases
#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#    alias ls='ls --color=auto'
#    #alias dir='dir --color=auto'
#    #alias vdir='vdir --color=auto'
#
#    #alias grep='grep --color=auto'
#    #alias fgrep='fgrep --color=auto'
#    #alias egrep='egrep --color=auto'
#fi


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
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
set completion-ignore-case on

# include filenames beginning with a '.' (dot) in the results of
# filename expansion
# https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
shopt -s dotglob

### Ctrl-D twice to exit
export IGNOREEOF=1

### Vim
set -o vi
export EDITOR=vim
export VISUAL=vim

### Bash bindings
bind -m vi-insert "\C-l":clear-screen
bind -m vi-insert "\C-p":previous-history
bind -m vi-insert "\C-n":next-history

### safety
set -o noclobber


### grep
# print lines matching a pattern
export GREP_OPTIONS='--color=auto'
# green for matches
export GREP_COLOR='1;31'


# 2.5) sort options
# Ensures cross-platform sorting behavior of GNU sort.
# http://www.gnu.org/software/coreutils/faq/coreutils-faq.html#Sort-does-not-sort-in-normal-order_0021
unset LANG
export LC_ALL=POSIX


### z
# jump around
# https://github.com/rupa/z
if [ -f ~/repositories/z/z.sh ]; then
    # "." and "source" are supposed to be synonyms
    source ~/repositories/z/z.sh
fi


### PATH

# ~/bin/
[[ -s "$HOME/bin" ]] && export PATH="$PATH:$HOME/bin"

# RVM
[[ -s "$HOME/.rvm/bin" ]] && export PATH="$PATH:$HOME/.rvm/bin"

# Haskell
[[ -s "$HOME/.cabal/bin" ]] && export PATH="$PATH:$HOME/.cabal/bin"

### /PATH

### optional includes

### desktop settings
if [ -f ~/.bashrc_desktop ]; then
    source ~/.bashrc_desktop
fi

### Python development
if [ -f ~/.bashrc_python ]; then
    source ~/.bashrc_python
fi

### Node.js development
if [ -f ~/.bashrc_nodejs ]; then
    source ~/.bashrc_nodejs
fi

### Google App Engine / Google Cloud SDK settings
if [ -f ~/.bashrc_google-app-engine ]; then
    source ~/.bashrc_google-app-engine
fi

### /optional includes
