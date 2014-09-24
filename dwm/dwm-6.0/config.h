/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

/* appearance statuscolors */
#define NUMCOLORS         8             // need at least 3
/*
static const char colors[NUMCOLORS][ColLast][8] = {
   // border   foreground  background
   { "#cccccc", "#000000", "#cccccc" },  // 0 = normal
   { "#0066ff", "#ffffff", "#0066ff" },  // 1 = selected
   { "#0066ff", "#0066ff", "#ffffff" },  // 2 = urgent/warning
   { "#ff0000", "#ffffff", "#ff0000" },  // 3 = error
   // add more here
}; */
static const char colors[NUMCOLORS][ColLast][8] = {
   // border   foreground  background
   { "#000000", "#ffffff", "#000000" },  // 0 = normal
   { "#0066ff", "#ffffff", "#0066ff" },  // 1 = selected
   { "#0066ff", "#0066ff", "#ffffff" },  // 2 = urgent/warning
   { "#ff0000", "#ffffff", "#ff0000" },  // 3 = error
   { "#00ff00", "#95e454", "#000000" },  // 4 = verde sobre negro
   { "#000000", "#e5786d", "#000000" },  // 5 = naranja sobre negro
   { "#000000", "#ffc726", "#000000" },  // 6 = amarillo sobre negro
   { "#000000", "#3790e8", "#000000" },  // 7 = azul sobre negro
   // add more here
};
static const char font[]            = "-*-stlarch-medium-r-*-*-10-*-*-*-*-*-*-*" "," "-*-terminus-medium-r-*-*-12-*-*-*-*-*-*-*";
static const char normbordercolor[] = "#444444";
static const char normbgcolor[]     = "#222222";
static const char normfgcolor[]     = "#bbbbbb";
static const char selbordercolor[]  = "#005577";
static const char selbgcolor[]      = "#005577";
static const char selfgcolor[]      = "#eeeeee";
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const Bool showsystray       = True;     /* False means no systray */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */
static const unsigned int dzen_height = 0;     /* Bottom bar */

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            False,       -1 },
	{ "Ekiga",    NULL,       NULL,       0,            True,        -1 },
	{ "Skype",    NULL,       NULL,       0,            True,        -1 },
	{ "Firefox",  NULL,       NULL,       1 << 7,       False,       -1 },
	{ "Chromium", NULL,       NULL,       1 << 8,       False,       -1 },
	{ "Google-chrome-stable", NULL,NULL,  1 << 8,       False,       -1 },
	{ "Dwb",  	  NULL,       NULL,       1 << 6,       False,       -1 },
	{ "Eclipse",  NULL,       NULL,       1 << 2,       False,        -1 },
	{ "Thunderbird",NULL,     NULL,       1 << 5,       False,       -1 },
	{ "jetbrains-phpstorm",  NULL, NULL,  1 << 1,       False,       -1 },
};

/* layout(s) */
static const float mfact      = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster      = 1;    /* number of clients in master area */
static const Bool resizehints = True; /* True means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/zsh", "-c", cmd, NULL } }

/* commands */
//static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", colors[0][ColBG], "-nf", colors[0][ColFG],"-sb", colors[1][ColBG], "-sf", colors[1][ColFG], NULL };
static const char *termcmd[]  = { "urxvtc", NULL };


static const char *volup[]    = { "amixer", "-q", "sset", "Master", "5%+", "unmute", NULL };
static const char *voldown[]  = { "amixer", "-q", "sset", "Master", "5%-", "unmute", NULL };
static const char *volmute[]  = { "amixer", "-q", "sset", "Master", "toggle", NULL };
static const char *mpctoggle[]  = { "mpc", "toggle", NULL };
static const char *mpcstop[]  = { "mpc", "stop", NULL };
static const char *mpcnext[]  = { "mpc", "next", NULL };
static const char *mpcprev[]  = { "mpc", "prev", NULL };
static const char *bloquear[]  = { "slock", NULL };
static const char *explorador[]  = { "thunar", NULL };
static const char *touchpad[]  = { "trackpad_toggle.sh", NULL };
static const char *gvim[]  = { "gvim", NULL };
static const char *scrolllock[]  = { "xset", "led", "named", "\"Scroll ", "Lock\"" };
static const char *pavucontrol[]  = { "pavucontrol", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,			            XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
	{ MODKEY|ShiftMask,             XK_l,      spawn,           {.v = bloquear } },
	{ MODKEY,	  					XK_e,      spawn,			{.v = explorador } },
	{ MODKEY|ShiftMask,             XK_v,      spawn,			{.v = gvim } },
	{ MODKEY|ShiftMask,             XK_s,      spawn,			{.v = pavucontrol } },
	{ 0,                            XK_Scroll_Lock,      spawn,        {.v = scrolllock } },
	{ MODKEY,                       XK_F12,			     spawn,        {.v = volup } },
	{ MODKEY,                       XK_F11,     		 spawn,        {.v = voldown } },
	{ MODKEY,                       XK_F10,			     spawn,        {.v = mpctoggle } },
	{ 0,                            XF86XK_AudioRaiseVolume,      spawn,        {.v = volup } },
	{ 0,                            XF86XK_AudioLowerVolume,      spawn,        {.v = voldown } },
	{ 0,                            XF86XK_AudioMute,      spawn,        {.v = volmute } },
	{ 0,                            XF86XK_AudioStop,      spawn,        {.v = mpcstop } },
	{ 0,                            XF86XK_AudioPlay,      spawn,        {.v = mpctoggle } },
	{ 0,                            XF86XK_AudioPrev,      spawn,        {.v = mpcprev } },
	{ 0,                            XF86XK_AudioNext,      spawn,        {.v = mpcnext } },
	{ 0,                            XF86XK_TouchpadToggle,      spawn,        {.v = touchpad } },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

