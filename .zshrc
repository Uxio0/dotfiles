# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/uxio/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

alias vi='nvim'
alias vim='nvim'

export TERM="xterm-256color"
export GOPATH=~/gocode
PATH=$PATH:$GOPATH/bin
export PATH
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

# extract function
extract() {
  if [[ -f $1 ]]; then
    case $1 in
      *.7z) 7z x $1;;
      *.bz2) bunzip2 $1;;
      *.gz) gunzip $1;;
      *.rar) unrar x $1;;
      *.tar) tar xvf $1;;
      *.tar.bz2) tar xvjf $1;;
      *.tar.gz) tar xvzf $1;;
      *.tbz2) tar xvjf $1;;
      *.tgz) tar xvzf $1;;
      *.zip) unzip $1;;
      *.Z) uncompress $1;;
      *) echo "unable to extract '$1'..." ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}
#Compress function
compress() {
    name=${1##*/}
    tar -cv $1 | lzma -9 > $name.tar.lzma
}

# press ctrl-q to quote line:
mquote () {
      zle beginning-of-line
      zle forward-word
      # RBUFFER="'$RBUFFER'"
      RBUFFER=${(q)RBUFFER}
      zle end-of-line
}
zle -N mquote && bindkey '^q' mquote

## ctrl-s will no longer freeze the terminal.
# stty erase "^?"
stty -ixon

[[ -f ~/work.sh ]] && . ~/work.sh
[[ -f ~/thinkpad.sh ]] && . ~/thinkpad.sh
