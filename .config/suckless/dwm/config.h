/* appearance */
static const unsigned int borderpx  = 4;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
// static const int vertpad            = 4;       /* [patch]:barpadding vertical padding of bar */
// static const int sidepad            = 4;       /* [patch]:barpadding horizontal padding of bar */
static const char *fonts[]          = { "JetBrainsMono Nerd Font:size=12:antialias=true:autohint=true" };
static const char dmenufont[]       = "JetBrainsMono Nerd Font:size=12:antialias=true:autohint=true";
static const char col_bg[]       = "#ffffff";
static const char col_fg[]       = "#393737";
static const char col_ac[]       = "#6C7A89";
static const char col_empty[]       = "#c8c8c8";
static const char col_dark[]        = "#000000";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_empty, col_bg, col_bg },
	[SchemeSel]  = { col_dark, col_bg,  col_ac  },
};

/* tagging  󰇥 󰈸 󰍳  */
static const char *tags[] = { "󰅬", "", "", "", "", "", "", "󰨞", "" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      				instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     				NULL,       NULL,       0,            1,           -1 },
	{ "qutebrowser",  		NULL,       NULL,       2,       			0,           -1 },
	{ "Vivaldi-stable",  	NULL,       NULL,       2,       			0,           -1 },
	{ "LibreWolf",  			NULL,       NULL,       2,       			0,           -1 },
	{"TelegramDesktop", 	NULL, 			NULL, 			5, 						1, 						-1},
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "[F]",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

// static const Layout layouts[] = {
// 	/* symbol     arrange function */
// 	{ " ",      tile },    /* first entry is default */
// 	{ "󱂬 ",      NULL },    /* no layout function means floating behavior */
// 	{ " ",      monocle },
// };

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", NULL };
static const char *rofidruncmd[] = {"rofi", "-show", "drun", NULL};
static const char *windowswitchcmd[] = {"rofi", "-show", "window", NULL};
static const char *termcmd[]  = { "kitty", NULL };

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ Mod1Mask,                     XK_F1,     spawn,          {.v = rofidruncmd } },
	{ MODKEY,					              XK_Return, spawn,          {.v = termcmd } },
	{Mod1Mask, 											XK_Tab,		 spawn, 			 	 {.v = windowswitchcmd}},
	{ MODKEY,                       XK_d,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,					              XK_q,      killclient,     {0} },
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
	
	/* Brightness & Volume */
	{ 0, 														0x1008ff02,		 spawn,			 SHCMD("~/.local/bin/brightness.sh up") },
	{ 0, 														0x1008ff03,		 spawn, 		 SHCMD("~/.local/bin/brightness.sh down") },
	{ 0, 														0x1008ff13,		 spawn, 		 SHCMD("~/.local/bin/volume.sh up") },
	{ 0, 														0x1008ff11,		 spawn, 		 SHCMD("~/.local/bin/volume.sh down") },
	{ 0, 														0x1008ff12,		 spawn, 		 SHCMD("~/.local/bin/volume.sh mute") },
  // { MODKEY,              					XK_F4,      	 spawn, 		 SHCMD("~/.local/bin/temperature.sh cooler") },
  // { MODKEY,             					XK_F3,      	 spawn, 		 SHCMD("~/.local/bin/temperature.sh warmer") },

	/* Apps */
	{ 0,                       			XK_Print, 		 spawn,      SHCMD("flameshot gui") },
	{ MODKEY,                       XK_w, 		 		 spawn,      SHCMD("qutebrowser") },
	{ MODKEY,                       XK_n, 		 		 spawn,      SHCMD("kitty nvim") },

	/* Wallpapers chager */
	{ MODKEY|ShiftMask,             XK_w, 		 		 spawn,      SHCMD("feh --bg-scale --randomize --no-fehbg ~/Pictures/Wallpapers/*") },
};

/* [patch]: Autostart apps */
static const char *const autostart[] = {
    "sh", "-c", "~/.local/bin/autostart.sh", NULL,
    "sh", "-c", "~/.local/bin/battery_monitor.sh", NULL,
    NULL
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
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

