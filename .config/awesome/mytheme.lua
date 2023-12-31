---------------------------
-- My awesome theme --
---------------------------

local theme_assets              = require("beautiful.theme_assets")
local xresources                = require("beautiful.xresources")
local dpi                       = xresources.apply_dpi

local gfs                       = require("gears.filesystem")
local themes_path               = gfs.get_themes_dir()

local theme                     = {}

local awful                     = require("awful")
local screen_width              = awful.screen.focused().geometry.width
local screen_height             = awful.screen.focused().geometry.height

theme.font                      = "JetBrainsMono Nerd Font 14"

theme.bg_normal                 = "#6C7A89"
theme.bg_focus                  = "#ffffff"
theme.bg_urgent                 = "#ffffff"
theme.bg_minimize               = "#444444"
theme.bg_systray                = "#ffffff"
theme.systray_icon_spacing      = 4

theme.fg_normal                 = "#000000"
theme.fg_focus                  = "#6C7A89"
theme.fg_urgent                 = "#ffffff"
theme.fg_minimize               = "#ffffff"

theme.useless_gap               = dpi(2)
theme.border_width              = dpi(4)
theme.border_normal             = "#6C7A89"
theme.border_focus              = "#000000"
theme.border_marked             = "#91231c"

-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]

-- Tags
theme.tag                       = { "󰅬 ", " ", " ", "󰡛", " ", " ", " ", "󰨞 ", " " }

theme.taglist_fg_empty          = "#c8c8c8"
theme.taglist_fg_occupied       = "#6C7A89"
theme.taglist_fg_focus          = "#000000"

-- Generate taglist squares:
local taglist_square_size       = dpi(6)
theme.taglist_squares_sel       = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel     = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Notifications
theme.notification_position     = "top_right"
theme.notification_border_width = dpi(4)
theme.notification_border_color = "#000000"
theme.notification_bg           = "#ffffff"
-- theme.notification_fg = ""
-- theme.notification_crit_bg = ""
-- theme.notification_crit_fg = ""
theme.notification_icon_size    = dpi(64)
-- theme.notification_height = dpi(80)
-- theme.notification_width = dpi(300)
theme.notification_margin       = dpi(15)
theme.notification_opacity      = 1
-- theme.notification_font =
-- theme.notification_padding = theme.screen_margin * 2
-- theme.notification_spacing = theme.screen_margin * 2

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon         = themes_path .. "default/submenu.png"
theme.menu_height               = dpi(20)
theme.menu_width                = dpi(200)

-- theme.wallpaper = themes_path.."default/background.png"

-- You can use your own layout icons like this:
theme.layout_fairh              = "~/.config/awesome/icons/layouts/fairh.png"
theme.layout_fairv              = "~/.config/awesome/icons/layouts/fairv.png"
theme.layout_floating           = "~/.config/awesome/icons/layouts/floating.png"
theme.layout_magnifier          = "~/.config/awesome/icons/layouts/magnifier.png"
theme.layout_max                = "~/.config/awesome/icons/layouts/max.png"
theme.layout_fullscreen         = "~/.config/awesome/icons/layouts/fullscreen.png"
theme.layout_tilebottom         = "~/.config/awesome/icons/layouts/tilebottom.png"
theme.layout_tileleft           = "~/.config/awesome/icons/layouts/tileleft.png"
theme.layout_tile               = "~/.config/awesome/icons/layouts/tile.png"
theme.layout_tiletop            = "~/.config/awesome/icons/layouts/tiletop.png"
theme.layout_spiral             = "~/.config/awesome/icons/layouts/spiral.png"
theme.layout_dwindle            = "~/.config/awesome/icons/layouts/dwindle.png"
theme.layout_cornernw           = "~/.config/awesome/icons/layouts/cornernw.png"
theme.layout_cornerne           = "~/.config/awesome/icons/layouts/cornerne.png"
theme.layout_cornersw           = "~/.config/awesome/icons/layouts/cornersw.png"
theme.layout_cornerse           = "~/.config/awesome/icons/layouts/cornerse.png"

-- Generate Awesome icon:
theme.awesome_icon              = "~/.config/awesome/icons/menu.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme                = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
