# Colors declaration

FOREG='#FF797979'
FGM='#FFAE2841'
WIRE='#FF424242'
BATTERY='#FF2A4649'
THECOLOR='#FF3F4B9C'
BLUE='#FFAA9A4B'
YELLOW='#FFBABE3F'

. panel_colors

# Info used in bar
# Icons declarations

i_pkgs='\ue14d'   # pacman
i_mail='\ue072'     # mail icon
i_wifi='\ue0f0'     # signal
i_time='\ue017'     # clock
i_load='\ue021'     # micro chip
i_musk='\ue04d '     # headphones
i_alsa='\ue05d'     # speaker
i_tmp='  '
i_mpd=' '
i_bat=' '

# Call those motherfuckers icons
BATTIC=`echo -e $i_bat`
WIFIIC=`echo -e $i_wifi`
SOUNDIC=`echo -e $i_alsa`
MEMIC=`echo -e $i_load `
MUSIC=`echo -e $i_musk`
TEMPIC=`echo -e $i_tmp`
PACIC=`echo -e $i_pkgs`
CLKIC=`echo -e $i_time`

PANEL_FIFO=/tmp/panel-fifo
PANEL_HEIGHT=15
PANEL_FONT_FAMILY="-*-terminus-medium-r-normal-*-12-*-*-*-c-*-*-1"
