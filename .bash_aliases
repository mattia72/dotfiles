
# some ls aliases
alias ll='ls -l'
alias la='ls -la'
alias ls='ls -F --color=auto --show-control-chars'
alias rm='rm -i'
alias grep='grep --color'
# downloads torrent files and kills itself after two days
alias download='while true; do aria2c -j 10 *.torrent
--bt-require-crypto=true --lowest-speed-limit=1024 --disable-ipv6=true
--seed-time=2880 --enable-rpc=false; sleep 5; done'
# seeds torrent files and kills itself after two days
alias seed='while true; do aria2c --bt-require-crypto=true
--check-integrity=false --bt-seed-unverified=true --disable-ipv6=true -d .
*.torrent --seed-time=2880 --seed-ratio=1.0'

alias setvi="set -o vi"
alias setnorm="set -o emacs"
