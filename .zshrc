if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
	source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export EDITOR=vim
export VISUAL=$EDITOR
export TERM=xterm-256color
export PATH=$PATH:~/scripts
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

cleanpython() {
	find -name '*.pyc' -delete
	find -name '__pycache__'
	rm -rf 'dist'
	rm -rf *\.egg-info
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
