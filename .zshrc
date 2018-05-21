if [[ -s ~/.zplugin/bin/zplugin.zsh ]]; then
    source ~/.zplugin/bin/zplugin.zsh

    autoload -Uz _zplugin
    (( ${+_comps} )) && _comps[zplugin]=_zplugin

    zplugin load zdharma/history-search-multi-word

    zplugin light zsh-users/zsh-autosuggestions
    zplugin light zsh-users/zsh-syntax-highlighting

    zplugin light chrissicool/zsh-256color

    zplugin ice blockf
    zplugin light zsh-users/zsh-completions
    # zplugin creinstall zsh-users/zsh-completions

    # Load completion library for those sweet [tab] squares
    zplugin snippet OMZ::lib/completion.zsh

    zplugin snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

    zplugin snippet OMZ::lib/git.zsh
    zplugin snippet OMZ::plugins/git/git.plugin.zsh
    zplugin snippet OMZ::plugins/virtualenvwrapper/virtualenvwrapper.plugin.zsh

    # Load theme from OMZ
    zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure
    # setopt promptsubst
    # zplugin snippet OMZ::themes/alanpeabody.zsh-theme
    # zplugin light denysdovhan/spaceship-prompt
fi

autoload -Uz compinit
compinit

eval "$(dircolors --sh)"
alias ls="ls --color=auto"

bindkey -e emacs

# DEL KEY http://zsh.sourceforge.net/FAQ/zshfaq03.html#l25
bindkey "\e[3~" delete-char

HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=1000
EDITOR=vim
VISUAL=$EDITOR
PATH=~/.local/bin:$PATH
TERM=xterm-256color
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

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

replaceAg() {
	if [ "$#" -eq 2 ]; then
		for f in $(ag $1 -l); do sed -i "s/$1/$2/g" $f; done
	else
		echo "Illegal number of parameters"
	fi
}

deleteAg() {
	if [ "$#" -eq 1 ]; then
		for f in $(ag $1 -l); do sed -i "/$1/d" $f; done
	else
		echo "Illegal number of parameters"
	fi
}

pyclean () {
        find . -regex "\(.*__pycache__.*\|*.py[co]\)" -delete
}

weather() {
	curl 'http://wttr.in'
}

## ctrl-s will no longer freeze the terminal.
# stty erase "^?"
stty -ixon

[[ -s ~/work.sh ]] && . ~/work.sh
[[ -s ~/thinkpad.sh ]] && . ~/thinkpad.sh

if [[ -s /usr/share/fzf/key-bindings.zsh ]]; then
	.  /usr/share/fzf/key-bindings.zsh
	.  /usr/share/fzf/completion.zsh
fi

# vim: ft=sh ts=4 sw=4 tw=0 fdm=marker foldlevel=0 :
