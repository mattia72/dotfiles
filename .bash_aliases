
# ls ordered by modification time
alias lm='ls -lactr'
# ls ordered by name
alias la='ls -la'
alias ls='ls -F --color=auto --show-control-chars'
alias rm='rm -i'
alias grep='grep --color'
# downloads torrent files and kills itself after two days
alias leech='aria2c --max-concurrent-downloads=10 --bt-require-crypto=true --lowest-speed-limit=1024 --disable-ipv6=true --seed-time=2880 --enable-rpc=false *.torrent'
# seeds torrent files and kills itself after two days
alias seed='aria2c --bt-require-crypto=true --check-integrity=false --bt-seed-unverified=true --disable-ipv6=true --seed-time=2880 --seed-ratio=1.0 --max-overall-upload-limit=10 --dir=. *.torrent '

#start my own vim
#alias vim="/c/ProgramData/chocolatey/lib/vim-tux.portable/tools/vim74/vim.exe"
#alias gvim="/c/ProgramData/chocolatey/lib/vim-tux.portable/tools/vim74/gvim.exe"
alias vi="vim -u NONE"

alias rclone="~/utils/sync-backup/rclone/rclone.exe --config ~/utils/sync-backup/rclone/.rclone.conf"

alias setvi="set -o vi"
alias setnorm="set -o emacs"

alias pacman-list="pacman -Qqe"
alias pacman-upgrade="pacman -Syu"
alias pacman-search="pacman -Ss"
alias pacman-install="pacman -S"
alias pacman-remove="pacman -R"

