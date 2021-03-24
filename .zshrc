if [[ -s ~/.zinit/bin/zinit.zsh ]]; then
	# http://zdharma.org/zinit/wiki/INTRODUCTION/
    source ~/.zinit/bin/zinit.zsh

    # https://github.com/zdharma/zinit/blob/master/doc/INSTALLATION.adoc#manual-installation
    autoload -Uz _zinit
    (( ${+_comps} )) && _comps[zinit]=_zinit

    # Breaks completion
    # zinit snippet OMZ::plugins/common-aliases/common-aliases.plugin.zsh

    zinit ice wait"0" atload"_zsh_autosuggest_start" lucid
    zinit light zsh-users/zsh-autosuggestions

    # `blockf` will block the traditional method of adding completions, zinit uses its own
    zinit ice blockf
    zinit light zsh-users/zsh-completions

    # Aws completion
    zinit ice wait"0" lucid
    zinit snippet OMZ::plugins/aws/aws.plugin.zsh

	zinit ice as"completion"
	zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

    zinit ice wait"0" atinit"zpcompinit; zpcdreplay" lucid
    zinit light zdharma/fast-syntax-highlighting

    zinit load zdharma/history-search-multi-word

    zinit light chrissicool/zsh-256color

	zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
		atpull'%atclone' pick"clrs.zsh" nocompile'!' \
		atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
	zinit light trapd00r/LS_COLORS

    # Load completion library for those sweet [tab] squares
    zinit snippet OMZ::lib/completion.zsh

    zinit ice wait"0" lucid
    zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

    # ZSH_TMUX_AUTOSTART=true
    # ZSH_TMUX_AUTOCONNECT=false
    # zinit snippet OMZ::plugins/tmux/tmux.plugin.zsh
    # zinit light jreese/zsh-titles

    # Check if we are in a virtualenv directory when zshrc is loaded
    zinit ice nocd wait'!0' atload'workon_cwd'
    zinit snippet OMZ::plugins/virtualenvwrapper/virtualenvwrapper.plugin.zsh

    # Load OMZ Git library
    zinit snippet OMZ::lib/git.zsh

    # Load Git plugin from OMZ
    zinit snippet OMZ::plugins/git/git.plugin.zsh
    zinit cdclear -q # <- forget completions provided up to this moment

    # Load theme from OMZ
    zinit ice pick"async.zsh" src"pure.zsh"
    zinit light sindresorhus/pure
    # setopt promptsubst
    # zinit snippet OMZ::themes/alanpeabody.zsh-theme
    # zinit light denysdovhan/spaceship-prompt
else
    autoload -Uz compinit; compinit
fi

alias cal="cal -m"
alias ls="ls --color=auto"
alias vim="nvim"

bindkey -e emacs

# DEL KEY http://zsh.sourceforge.net/FAQ/zshfaq03.html#l25
bindkey "\e[3~" delete-char

HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=1000
export EDITOR=vim
export VISUAL=$EDITOR
export GOPATH=~/go
export PATH=~/.local/bin:~/.yarn/bin:${GOPATH//://bin:}/bin:$PATH
#TERM=xterm-256color
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

# FZF
if [[ -s /usr/share/fzf/key-bindings.zsh ]]; then
	.  /usr/share/fzf/key-bindings.zsh
	.  /usr/share/fzf/completion.zsh
fi

[[ -z "$TMUX" && -n "$DISPLAY" ]] && tmux

source /usr/share/nvm/init-nvm.sh
# vim: ft=sh ts=4 sw=4 tw=0 fdm=marker foldlevel=0 :
