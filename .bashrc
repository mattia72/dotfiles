# If not running interactively, don't do anything
case $- in
  *i*) ;;
*) return;;
esac

load_bashrc_if_exists()
{
  local bashrc_path="$1"
  if [ -f "$bashrc_path" ]; then
    . "$bashrc_path"
  fi
}

sysname=`uname -s | sed "s/\([a-zA-Z]\+\).*/\1/"`
case $sysname in
  CYGWIN) load_bashrc_if_exists ~/.bashrc.cygwin;;
  MSYS) load_bashrc_if_exists ~/.bashrc.msys;;
  MINGW*) load_bashrc_if_exists ~/.bashrc.mingw;;
  AIX) load_bashrc_if_exists ~/.bashrc.aix;;
  UBUNTU) load_bashrc_if_exists ~/.bashrc.ubuntu;;
esac

case $sysname in
  CYGWIN|MSYS|MINGW*) 
    export PATH="$PATH:/c/ProgramData/chocolatey/bin";;
esac

#if [ "$sysname" = "CYGWIN" ]; then
  #if [ -f ~/.bashrc.cygwin ]; then
    #. ~/.bashrc.cygwin
  #fi
#elif [ "$sysname" = "MSYS" ]; then
  #if [ -f ~/.bashrc.msys ]; then
    #. ~/.bashrc.msys
  #fi
#elif [[ $sysname == MINGW* ]]; then
  #if [ -f ~/.bashrc.mingw ]; then
    #. ~/.bashrc.mingw
  #fi
#elif [ "$sysname" = "AIX" ]; then
  #if [ -f ~/.bashrc.aix ]; then
    #. ~/.bashrc.aix
  #fi
#elif [ "$sysname" = "UBUNTU" ]; then
  #if [ -f ~/.bashrc.ubuntu ]; then
    #. ~/.bashrc.ubuntu
  #fi
#fi

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

# ssh stuff
SSH_ENV=$HOME/.ssh/environment

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    echo "call ssh-add for adding identities"
    #/usr/bin/ssh-add
}

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi


if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi
