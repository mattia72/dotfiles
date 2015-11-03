
if [ -n "${ConEmuDir}" ]; then
  export TERM=cygwin
else
  export TERM=xterm-256color
fi

export GITAWAREPROMPT=~/bin/git-prompt
#source "${GITAWAREPROMPT}/main.sh"
source "${GITAWAREPROMPT}/prompt.sh"

if [ -f ~/.bashrc ]; then . ~/.bashrc; fi
