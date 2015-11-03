# If not running interactively, don't do anything
case $- in
  *i*) ;;
*) return;;
esac

sysname=`uname -s | sed "s/\([a-zA-Z]\+\).*/\1/"`
if [ "$sysname" = "CYGWIN" ]; then
  if [ -f ~/.bashrc.cygwin ]; then
    . ~/.bashrc.cygwin
  fi
elif [ "$sysname" = "MSYS" ]; then
  if [ -f ~/.bashrc.msys ]; then
    . ~/.bashrc.msys
  fi
elif [[ $sysname == MINGW* ]]; then
  if [ -f ~/.bashrc.mingw ]; then
    . ~/.bashrc.mingw
  fi
elif [ "$sysname" = "AIX" ]; then
  if [ -f ~/.bashrc.aix ]; then
    . ~/.bashrc.aix
  fi
elif [ "$sysname" = "UBUNTU" ]; then
  if [ -f ~/.bashrc.ubuntu ]; then
    . ~/.bashrc.ubuntu
  fi
fi

#
# common settings
#
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
# History won't mother these:
export HISTIGNORE="[   ]*:&:bg:fg:cd:ls:la:exit"

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi
