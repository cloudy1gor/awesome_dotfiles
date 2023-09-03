/* See LICENSE file for copyright and license details. */

static const unsigned int barborderpx    = 5; /* border pixel of bar */
static const unsigned int borderpx       = 5; /* border pixel of windows */

static const unsigned int snap           = 32; /* snap pixel */
static const int showbar                 = 1;  /* 0 means no bar */
static const int topbar                  = 1;  /* 0 means bottom bar */

static const int swallowfloating         = 0; /* 1 means swallow floating windows by default */
static const int riodraw_matchpid        = 1; /* 0 or 1, indicates whether to match the PID of the client that was spawned with riospawn */

static const int vertpad                 = 4; /* vertical padding of bar */
static const int sidepad                 = 4; /* horizontal padding of bar */
#define ICONSIZE 22    /* icon size */
#define ICONSPACING 5  /* space between icon and title */
/* Status is to be shown on: -1 (all monitors), 0 (a specific monitor by index), 'A' (active monitor) */

static int floatposgrid_x                = 5; /* float grid columns */
static int floatposgrid_y                = 5; /* float grid rows */

static const int horizpadbar             = 0; /* horizontal padding for statusbar */
static const int vertpadbar              = 0; /* vertical padding for statusbar */
static const int statusmon               = 'A';

static const unsigned int systraypinning = 0; /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft  = 0; /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2; /* systray spacing */
static const int systraypinningfailfirst = 1; /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray             = 1; /* 0 means no systray */
static const int systraypadding          = 0; /* padding to use between end of bar text and the systray */

static const unsigned int gappih         = 6; /* horiz inner gap between windows */
static const unsigned int gappiv         = 6; /* vert inner gap between windows */
static const unsigned int gappoh         = 4; /* horiz outer gap between windows and screen edge */
static const unsigned int gappov         = 4; /* vert outer gap between windows and screen edge */
static const int smartgaps_fact          = 1; /* 1 means no outer gap when there is only one window */

/* Indicators: see patch/bar_indicators.h for options */
static int tagindicatortype              = INDICATOR_TOP_LEFT_SQUARE;
static int tiledindicatortype            = INDICATOR_NONE;
static int floatindicatortype            = INDICATOR_TOP_LEFT_SQUARE;
static const char *fonts[]               = { "JetBrainsMono Nerd Font:size=12:antialias=true:autohint=true" };
static const char dmenufont[]            = "JetBrainsMono Nerd Font:size=12:antialias=true:autohint=true";

static char c000000[]                    = "#000000"; // placeholder value

static char normfgcolor[]                = "#393737";
static char normbgcolor[]                = "#ffffff";
static char normbordercolor[]            = "#6C7A89";
static char normfloatcolor[]             = "#005577";

static char selfgcolor[]                 = "#393737";
static char selbgcolor[]                 = "#ffffff";
static char selbordercolor[]             = "#6C7A89";
static char selfloatcolor[]              = "#005577";

static char titlenormfgcolor[]           = "#393737";
static char titlenormbgcolor[]           = "#ffffff";
static char titlenormbordercolor[]       = "#6C7A89";
static char titlenormfloatcolor[]        = "#005577";

static char titleselfgcolor[]            = "#393737";
static char titleselbgcolor[]            = "#ffffff";
static char titleselbordercolor[]        = "#6C7A89";
static char titleselfloatcolor[]         = "#005577";

static char tagsnormfgcolor[]            = "#c8c8c8";
static char tagsnormbgcolor[]            = "#393737";
static char tagsnormbordercolor[]        = "#6C7A89";
static char tagsnormfloatcolor[]         = "#005577";

static char tagsselfgcolor[]             = "#ffffff";
static char tagsselbgcolor[]             = "#393737";
static char tagsselbordercolor[]         = "#6C7A89";
static char tagsselfloatcolor[]          = "#005577";

static char hidnormfgcolor[]             = "#005577";
static char hidselfgcolor[]              = "#227799";
static char hidnormbgcolor[]             = "#393737";
static char hidselbgcolor[]              = "#393737";

static char urgfgcolor[]                 = "#ff0000";
static char urgbgcolor[]                 = "#393737";
static char urgbordercolor[]             = "#ff0000";
static char urgfloatcolor[]              = "#ff0000";

static char *colors[][ColCount] = {
	/*                       fg                bg                border                float */
	[SchemeNorm]         = { normfgcolor,      normbgcolor,      normbordercolor,      normfloatcolor },
	[SchemeSel]          = { selfgcolor,       selbgcolor,       selbordercolor,       selfloatcolor },
	[SchemeTitleNorm]    = { titlenormfgcolor, titlenormbgcolor, titlenormbordercolor, titlenormfloatcolor },
	[SchemeTitleSel]     = { titleselfgcolor,  titleselbgcolor,  titleselbordercolor,  titleselfloatcolor },
	[SchemeTagsNorm]     = { tagsnormfgcolor,  tagsnormbgcolor,  tagsnormbordercolor,  tagsnormfloatcolor },
	[SchemeTagsSel]      = { tagsselfgcolor,   tagsselbgcolor,   tagsselbordercolor,   tagsselfloatcolor },
	[SchemeHidNorm]      = { hidnormfgcolor,   hidnormbgcolor,   c000000,              c000000 },
	[SchemeHidSel]       = { hidselfgcolor,    hidselbgcolor,    c000000,              c000000 },
	[SchemeUrg]          = { urgfgcolor,       urgbgcolor,       urgbordercolor,       urgfloatcolor },
};

const char *spcmd1[] = {"kitty", "--class", "dropdown", "-e", "tmux", NULL};
const char *spcmd2[] = {"kitty", "--class", "files", "-e", "ranger", NULL};
const char *spcmd3[] = {"kitty", "--class", "monitor", "-e", "btop", NULL};
static Sp scratchpads[] = {
   /* name           cmd  */
   {"dropdown",      spcmd1},
   {"files",         spcmd2},
   {"monitor",       spcmd3},
};

static char *tagicons[][NUMTAGS] =
{
	// [DEFAULT_TAGS]        = { "󰅬", "", "", "", "", "", "", "󰨞", "" },
	[DEFAULT_TAGS]        = { "", "󰊯", "", "", "󱋊", "󱇨", "󰘦", "󱀫", "󰎅" },
	// [DEFAULT_TAGS]        = { "󰎥", "󰎨", "󰎫", "󰎲", "󰎯", "󰎴", "󰎷", "󰎺", "󰎽" },
	// [ALTERNATIVE_TAGS]    = { "󰎥 ", "󰼐 ", "󰎫 ", "󰼒 ", "󰎯 ", "󰼔 ", "󰎷 ", "󰼖 ", "󰎽 " },
	// [ALT_TAGS_DECORATION] = { "󰼏", "󰼐", "󰼑", "󰼒", "󰼓", "󰼔", "󰼕", "󰼖", "󰼗" },
	[ALT_TAGS_DECORATION] = { "󰅬", "", "", "", "󰭻", "󰷈", "", "󰨞", "󰎄" },
};

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 *	WM_WINDOW_ROLE(STRING) = role
	 *	_NET_WM_WINDOW_TYPE(ATOM) = wintype
	 */
	RULE(.wintype = WTYPE "DIALOG", 		.isfloating = 1)
	RULE(.wintype = WTYPE "UTILITY", 		.isfloating = 1)
	RULE(.wintype = WTYPE "TOOLBAR", 		.isfloating = 1)
	RULE(.wintype = WTYPE "SPLASH", 		.isfloating = 1)

	RULE(.class = "Pavucontrol", 				.tags = 1 << 0, .switchtag = 1, .isfloating = 1, .floatpos = "40% 40% 70% 80%")
	RULE(.class = "Safeeyes", 					.tags = 1 << 3, .isfloating = 1, .floatpos = "30 70")
	RULE(.class = "qutebrowser", 				.tags = 1 << 1, .switchtag = 1 )
	RULE(.class = "Vivaldi-stable", 		.tags = 1 << 3, .switchtag = 1)
	RULE(.class = "KeePassXC", 					.tags = 1 << 3, .switchtag = 1, .isfloating = 1, .floatpos = "40% 40% 70% 80%")
	RULE(.class = "kitty", 							.isterminal = 1)
	RULE(.instance = "spterm", 					.tags = SPTAG(0), .isfloating = 1)
	RULE(.title = "Discord Updater", 		.tags = 1 << 4, .isfloating = 1, .floatpos = "50% 50%")
	RULE(.class = "discord",         		.tags = 1 << 4)
	RULE(.class = "TelegramDesktop", 		.tags = 1 << 4, .isfloating = 1)
	RULE(.class = "zoom", 							.tags = 1 << 4, .switchtag = 1, .isfloating = 1)
	RULE(.class = "obsidian",        		.tags = 1 << 5, .switchtag = 1)
	RULE(.class = "Thunar", 						.tags = 1 << 2, .switchtag = 1)
	// RULE(.class = "obs", 								.tags = 1 << 7)
	RULE(.class = "qBittorrent", 				.tags = 1 << 3, .switchtag = 1)
	RULE(.class = "Virt-manager", 			.tags = 1 << 7, .switchtag = 1)

	/* Scratchpads rules */ 
	RULE(.class = "dropdown", 					.isfloating = 1, .floatpos = "30% 30% 50% 60%")
	RULE(.class = "files", 							.isfloating = 1, .floatpos = "40% 40% 70% 80%")
	RULE(.class = "monitor", 						.isfloating = 1, .floatpos = "50% 50% 60% 70%")

};


/* Bar rules allow you to configure what is shown where on the bar, as well as
 * introducing your own bar modules.
 *
 *    monitor:
 *      -1  show on all monitors
 *       0  show on monitor 0
 *      'A' show on active monitor (i.e. focused / selected) (or just -1 for active?)
 *    bar - bar index, 0 is default, 1 is extrabar
 *    alignment - how the module is aligned compared to other modules
 *    widthfunc, drawfunc, clickfunc - providing bar module width, draw and click functions
 *    name - does nothing, intended for visual clue and for logging / debugging
 */
static const BarRule barrules[] = {
	/* monitor   bar    alignment         widthfunc                 drawfunc                clickfunc                hoverfunc                name */
	{ -1,        0,     BAR_ALIGN_LEFT,   width_tags,               draw_tags,              click_tags,              hover_tags,              "tags" },
	{  0,        0,     BAR_ALIGN_RIGHT,  width_systray,            draw_systray,           click_systray,           NULL,                    "systray" },
	{ -1,        0,     BAR_ALIGN_LEFT,   width_ltsymbol,           draw_ltsymbol,          click_ltsymbol,          NULL,                    "layout" },
	{ statusmon, 0,     BAR_ALIGN_RIGHT,  width_status2d,           draw_status2d,          click_status2d,          NULL,                    "status2d" },
	{ -1,        0,     BAR_ALIGN_NONE,   width_wintitle,           draw_wintitle,          click_wintitle,          NULL,                    "wintitle" },
};

/* layout(s) */
static const float mfact            = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster            = 1;    /* number of clients in master area */
static const int resizehints        = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen     = 1;    /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[T]",      tile },    /* first entry is default */
	{ "[F]",      NULL },    /* no layout function means floating behavior */
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
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", NULL };
static const char *rofidruncmd[] = {"rofi", "-show", "drun", NULL};
static const char *windowswitchcmd[] = {"rofi", "-show", "window", NULL};
static const char *termcmd[]  = { "kitty", NULL };

static const Key keys[] = {
	/* modifier                     key            function        argument */
	{ Mod1Mask,                     XK_F1,         spawn,          {.v = rofidruncmd } },
	{ MODKEY,					              XK_Return,     spawn,          {.v = termcmd } },
	{Mod1Mask, 											XK_Tab,		     spawn, 			 	 {.v = windowswitchcmd}},
	{ MODKEY,                       XK_d,          togglebar,      {0} },
	{ MODKEY,                       XK_j,          focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,          focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,          incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,          incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,          setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,          setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_j,          movestack,      {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,          movestack,      {.i = -1 } },
	{ MODKEY,                       XK_Return,     zoom,           {0} },
	{ MODKEY,                       XK_Tab,        view,           {0} },
	{ MODKEY,					              XK_q,          killclient,     {0} },
	{ MODKEY,                       XK_t,          setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,          setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,          setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,      setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,      togglefloating, {0} },
	{ MODKEY|ShiftMask,             XK_s,          togglesticky,   {0} },

	// { MODKEY,                       XK_t,      togglescratch,          {.ui = 0 } },
	// { MODKEY|ControlMask,           XK_t,      setscratch,             {.ui = 0 } },
	// { MODKEY|ShiftMask,             XK_t,      removescratch,          {.ui = 0 } },
	{MODKEY|ShiftMask,              XK_Return,     togglescratch,  {.ui = 0}},
  {MODKEY|ShiftMask,              XK_BackSpace,  togglescratch,  {.ui = 1}},
  {Mod1Mask,                      XK_m,      		 togglescratch,  {.ui = 2}},

	{ Mod1Mask,                     XK_0,          view,           {.ui = ~SPTAGMASK } },
	{ Mod1Mask|ShiftMask,           XK_0,          tag,            {.ui = ~SPTAGMASK } },

	{ MODKEY,                       XK_comma,  		 focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, 		 focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  		 tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, 		 tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                          0)
	TAGKEYS(                        XK_2,                          1)
	TAGKEYS(                        XK_3,                          2)
	TAGKEYS(                        XK_4,                          3)
	TAGKEYS(                        XK_5,                          4)
	TAGKEYS(                        XK_6,                          5)
	TAGKEYS(                        XK_7,                          6)
	TAGKEYS(                        XK_8,                          7)
	TAGKEYS(                        XK_9,                      		 8)
	{ MODKEY|ShiftMask,             XK_q,      		 quit,           {0} },

	{ MODKEY|Mod4Mask,              XK_u,          incrgaps,               {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_u,          incrgaps,               {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_i,          incrigaps,              {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_i,          incrigaps,              {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_o,          incrogaps,              {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_o,          incrogaps,              {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_6,          incrihgaps,             {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_6,          incrihgaps,             {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_7,          incrivgaps,             {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_7,          incrivgaps,             {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_8,          incrohgaps,             {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_8,          incrohgaps,             {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_9,          incrovgaps,             {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_9,          incrovgaps,             {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_0,          togglegaps,             {0} },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_0,          defaultgaps,            {0} },

	
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
	{ MODKEY,                       XK_BackSpace,  spawn,      SHCMD("Thunar") },
	{ MODKEY,                       XK_w, 		 		 spawn,      SHCMD("qutebrowser") },
	{ MODKEY,                       XK_n, 		 		 spawn,      SHCMD("kitty nvim") },
	{ MODKEY|ShiftMask, 						XK_e, 				 spawn, 		 SHCMD("~/.config/rofi/powermenu.sh") },

	/* Wallpapers chager */
	{ MODKEY|ShiftMask,             XK_w, 		 		 spawn,      SHCMD("feh --bg-scale --randomize --no-fehbg ~/Pictures/Wallpapers/*") },
};

static const char *const autostart[] = {
    "sh", "-c", "~/.local/bin/autostart.sh", NULL,
    "sh", "-c", "~/.local/bin/battery_monitor.sh", NULL,
    NULL
};
/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask           button          function        argument */
	{ ClkLtSymbol,          0,                   Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,                   Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,                   Button2,        zoom,           {0} },
	{ ClkStatusText,        0,                   Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,              Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,              Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,              Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,                   Button1,        view,           {0} },
	{ ClkTagBar,            0,                   Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,              Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,              Button3,        toggletag,      {0} },
};


