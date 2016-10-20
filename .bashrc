export CLICOLOR=1

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

color_off='\[\033[0m\]'
color_black='\[\033[1;30m\]'
color_red='\[\033[1;31m\]'
color_green='\[\033[1;32m\]'
color_yellow='\[\033[1;33m\]'
color_blue='\[\033[1;34m\]'
color_purple='\[\033[1;35m\]'
color_cyan='\[\033[1;36m\]'
color_white='\[\033[1;37m\]'

function git-branch-name {
  git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3
}

function git-branch-prompt {
  local branch=`git-branch-name`
  if [ $branch ]; then printf " [%s]" $branch; fi
}

if [ $EUID -eq 0 ]
then
  user_color=${color_red}
else
  user_color=${color_green}
fi

PS1="${user_color}\u@\h \[\033[1;36m\]\W\[\033[0m\]\[\033[0;32m\]\$(git-branch-prompt)\[\033[0m\] \$ "
export PATH="/usr/local/heroku/bin:$PATH"

code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}  