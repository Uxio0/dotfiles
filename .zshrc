alias vi="vim"

#Vi Style
#bindkey -v

#Mutt
export MAIL=/home/uxio/.mail

export SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass
export SUDO_ASKPASS=/usr/lib/ssh/x11-ssh-askpass

# If not running interactively, do not do anything
#[[ $- != *i* ]] && return
#[[ -z "$TMUX" ]] && exec tmux
export PATH=$PATH:/home/uxio/.gem/ruby/2.0.0/bin/
