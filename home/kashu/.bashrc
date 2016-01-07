# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=30000
PROMPT_COMMAND="history -a"
HISTTIMEFORMAT="%Y-%m-%d_%H:%M:%S "
# Don't store duplicate adjacent items in the history
HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -Ah'
alias l='ls -CFh'

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

#alias sshsh='ssh -qTfnN -D :7070 eexp@128.199.153.182'
alias aria2c='aria2c -c -d /tmp -t 300 -m 30 -s10 -k5M -x10'
alias cleancache='echo 123 | sudo -S sh -c "echo 1 > /proc/sys/vm/drop_caches"'
alias ishadowsocks='wget -q html http://ishadowsocks.com -O - | grep 密码: | cut -d: -f2 | cut -d\< -f1'
#alias dstat='echo 123 | sudo -S dstat -lcdnmspyt -N eth0 -D total,sda,sdb'
alias dstat='dstat -cdnmpy -N eth0 -D total,sda,sdb --top-bio-adv'
alias rdesktopsh='rdesktop -u username -p password -r clipboard:CLIPBOARD -g 1024x700 -T 2xx.6x.56.206 -r sound:off -N -P -m -E -0 -a 15 2.6.56.206:51181'
alias calc='gnome-calculator &'
alias apt-get='/usr/bin/apt-fast'
alias chrome='/usr/bin/chromium-browser &'
alias goagent='echo 123 | sudo -S python /opt/goagent-3.0/local/proxy.py'
#alias go='sudo python /opt/goagent-goagent-03e2040/local/proxy.py &'
alias TTY='sudo miniterm.py -p /dev/ttyUSB0 --lf'
#alias sshus='ssh -CfNg -D 127.0.0.1:44444 root@162.244.78.154'

# My export
export PS4='+{$LINENO:${FUNCNAME[0]}} '
export PS1="\e[01;34m\h\[\e[m:\e[01;32m\w\e[m$ "
export EDITOR=vim
export GREP_OPTIONS='--color=auto'

nicemount(){ (echo "DEVICE PATH TYPE OPTIONS" && mount | awk '$2=$4="";1') | column -t; }

# Set colors for man pages
man() {
  env \
  LESS_TERMCAP_mb=$(printf "\e[1;31m") \
  LESS_TERMCAP_md=$(printf "\e[1;31m") \
  LESS_TERMCAP_me=$(printf "\e[0m") \
  LESS_TERMCAP_se=$(printf "\e[0m") \
  LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
  LESS_TERMCAP_ue=$(printf "\e[0m") \
  LESS_TERMCAP_us=$(printf "\e[1;32m") \
  man "$@"
}

#dictionary for command line environment
function sword()
{ 
    local word;
    word=$1;
    word=$(echo $word | tr ' ' '+');
    prefix='https'
    dotflg='.'
    andflg='&'
    qmflg='?'
    lynx -accept_all_cookies -source "$prefix://www${dotflg}bing${dotflg}com/dict/search${qmflg}q=$word${andflg}qs=n${andflg}form=CM${andflg}pq=$word${andflg}sc=0-0${andflg}sp=-1${andflg}sk=" | html2text | sed '1,12d' | ccze -A | less -R
}

#Currency Converter
#Usage: currenry 1 usd cny
currency(){ curl -s "https://www.google.com/finance/converter?a=$1&from=$2&to=$3" | sed '/res/!d;s/<[^>]*>//g'; }
