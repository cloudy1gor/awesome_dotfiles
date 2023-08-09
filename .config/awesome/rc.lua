-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")

-- Systray`
local systray = wibox.widget.systray()
systray.set_base_size(25)

-- Separator
local separator = wibox.widget.separator()
separator.forced_width = 10

local separator_text = wibox.widget.textbox(")")
separator_text.font = "JetBrainsMono Nerd Font 26"

-- Displays names
local display_internal = "eDP"
local display_external = "HDMI-A-0"

-- Set rounded corners
function custom_shape(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 18)
end

beautiful.init("~/.config/awesome/mytheme.lua")

terminal = "kitty"
editor = os.getenv("EDITOR") or "micro"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"

awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile
}

-- {{{ Wibar
-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
    end),
    awful.button({}, 3, awful.tag.viewtoggle), awful.button({ modkey }, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", { raise = true })
        end
    end),
    awful.button({}, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end),
    awful.button({}, 4, function() awful.client.focus.byidx(1) end),
    awful.button({}, 5, function() awful.client.focus.byidx(-1) end)
)

awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    -- awful.tag(beautiful.tag or {"1", "2", "3", "4", "5", "6", "7", "8", "9"}, s, awful.layout.layouts[2])
    awful.tag({ "󰅬 " }, s, awful.layout.layouts[2])

    -- My tags
    awful.tag.add(beautiful.tag[2], {
        index  = 2,
        layout = awful.layout.suit.fair,
        screen = s
    })
    awful.tag.add(beautiful.tag[3], {
        index  = 3,
        layout = awful.layout.suit.tile,
        screen = s
    })
    awful.tag.add(beautiful.tag[4], {
        index              = 4,
        layout             = awful.layout.suit.floating,
        -- master_fill_policy = "master_width_factor",
        master_fill_policy = 0.7,
        screen             = s
    })
    awful.tag.add(beautiful.tag[5], {
        index  = 5,
        layout = awful.layout.suit.tile,
        screen = s
    })

    awful.tag.add(beautiful.tag[6], {
        index  = 6,
        layout = awful.layout.suit.tile,
        screen = s
    })
    awful.tag.add(beautiful.tag[7], {
        index             = 7,
        layout            = awful.layout.suit.magnifier,
        gap_single_client = true,
        gap               = 16,
        screen            = s
    })
    awful.tag.add(beautiful.tag[8], {
        index  = 8,
        layout = awful.layout.suit.fair,
        screen = s
    })
    awful.tag.add(beautiful.tag[9], {
        index  = 9,
        layout = awful.layout.suit.floating,
        screen = s
    })

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)
    )
    )
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        style = {
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 4)
            end,
            bg_resize = true,
            spacing = 8
        }
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({
        position = "bottom",
        screen = s,
        width = screen[1].geometry.width * 0.45,
        height = 34,
        border_width = beautiful.border_width,
        shape = custom_shape,
        border_color = beautiful.border_focus,
        bg = beautiful.bg_focus
    })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.layout.margin(systray, 13, 0, 5, 5),
            separator_text
        },
        -- Middle widget
        s.mytaglist,
        expand = "outside",
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.textbox("               "),
            wibox.layout.margin(s.mylayoutbox, 4, 4, 4, 4)
        }
    }
end)
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey }, "Left", awful.tag.viewprev),
    awful.key({ modkey }, "Right", awful.tag.viewnext),
    awful.key({ modkey }, "Tab", awful.tag.history.restore),
    awful.key({ modkey }, "j", function() awful.client.focus.byidx(1) end),
    awful.key({ modkey }, "k", function() awful.client.focus.byidx(-1) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end),
    awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end),
    awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end),
    awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end),
    awful.key({ modkey }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey }, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then client.focus:raise() end
        end),

    --  Brightness % Volume media keys
    awful.key({}, "XF86AudioRaiseVolume", function()
        awful.spawn.with_shell(
            "export XDG_RUNTIME_DIR=/run/user/$(id -u) && ~/.config/awesome/scripts/volume.sh up")
    end),
    awful.key({}, "XF86AudioMute", function()
        awful.spawn.with_shell(
            "export XDG_RUNTIME_DIR=/run/user/$(id -u) && ~/.config/awesome/scripts/volume.sh mute")
    end),
    awful.key({}, "XF86AudioLowerVolume", function()
        awful.spawn.with_shell(
            "export XDG_RUNTIME_DIR=/run/user/$(id -u) && ~/.config/awesome/scripts/volume.sh down")
    end),
    awful.key({}, "XF86MonBrightnessDown", function()
        awful.spawn.with_shell(
            "export XDG_RUNTIME_DIR=/run/user/$(id -u) && ~/.config/awesome/scripts/brightness.sh down")
    end),
    awful.key({}, "XF86MonBrightnessUp", function()
        awful.spawn.with_shell(
            "export XDG_RUNTIME_DIR=/run/user/$(id -u) && ~/.config/awesome/scripts/brightness.sh up")
    end),

    -- Standard program
    awful.key({ modkey }, "Return", function() awful.spawn(terminal) end),
    awful.key({ modkey }, "BackSpace", function() awful.spawn("thunar") end),
    awful.key({ modkey }, "w", function() awful.spawn("qutebrowser") end),
    awful.key({ modkey }, "c", function() awful.spawn("code") end),
    awful.key({ modkey, "Shift" }, "r", awesome.restart),
    awful.key({ modkey, "Shift" }, "q", awesome.quit),

    -- Wallpaper changer
    awful.key({ modkey, "Shift" }, "w",
        function() awful.spawn.with_shell("feh --bg-fill --no-fehbg -r -z ~/Pictures/Wallpapers/*") end),
    awful.key({ modkey }, "l", function() awful.tag.incmwfact(0.05) end),
    awful.key({ modkey }, "h", function() awful.tag.incmwfact(-0.05) end),
    awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end),
    awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end),
    awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end),
    awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end),
    awful.key({ modkey }, "space", function() awful.layout.inc(1) end),
    awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end),

    -- Strachpad show window
    awful.key({ modkey, "Shift" }, "s",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal(
                    "request::activate", "key.unminimize", { raise = true }
                )
            end
        end),

    -- Rofi app launcher
    awful.key({ "Mod1" }, "F1", function() awful.util.spawn("rofi -show drun") end),
    -- Rofi powermenu
    awful.key({ modkey, "Shift" }, "e",
        function() awful.util.spawn("sh " .. os.getenv("HOME") .. "/.config/rofi/powermenu.sh") end),
    -- Rofi wifi
    awful.key({ modkey, "Shift" }, "n",
        function() awful.util.spawn("sh " .. os.getenv("HOME") .. "/.config/rofi/wifi.sh") end),
    -- Rofi bluetooth
    awful.key({ modkey, "Shift" }, "b",
        function() awful.util.spawn("sh " .. os.getenv("HOME") .. "/.config/rofi/bluetooth.sh") end),
    -- Install package
    awful.key({ modkey, "Shift" }, "i",
        function() awful.util.spawn(terminal .. " sh " .. os.getenv("HOME") .. "/.config/awesome/scripts/install.sh") end),
    -- Remove package
    awful.key({ modkey, "Shift" }, "u",
        function() awful.util.spawn(terminal .. " sh " .. os.getenv("HOME") .. "/.config/awesome/scripts/remove.sh") end),
    -- Clear cashe
    awful.key({ modkey, "Shift" }, "c",
        function() awful.util.spawn(terminal .. " sh " .. os.getenv("HOME") .. "/.config/awesome/scripts/cashe.sh") end),

    -- Display toogle
    awful.key({ modkey, "Shift" }, "d",
        function()
            awful.spawn.with_shell(gears.filesystem.get_configuration_dir() ..
                "scripts/display_toggle.sh " .. display_internal .. " " .. display_external)
        end),

    -- Screenshot
    awful.key({}, "Print", function() awful.spawn.with_shell("flameshot gui") end),
    -- Toogle wibar
    awful.key({ modkey }, "d",
        function()
            myscreen = awful.screen.focused()
            myscreen.mywibox.visible = not myscreen.mywibox.visible
        end),
    -- Lock
    awful.key({ modkey }, "Escape",
        function() awful.spawn.with_shell("~/.config/awesome/scripts/i3lock-fancy/i3lock-fancy.sh") end))

clientkeys = gears.table.join(awful.key({ modkey }, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end),

    -- Strachpad hide window
    awful.key({ modkey }, "s", function(c) c.minimized = true end),

    awful.key({ modkey }, "q", function(c) c:kill() end),
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle),
    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey }, "o", function(c) c:move_to_screen() end),
    awful.key({ modkey }, "t", function(c) c.ontop = not c.ontop end),
    awful.key({ modkey }, "m", function(c)
        c.maximized = not c.maximized
        c:raise()
    end),
    awful.key({ modkey, "Control" }, "m", function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
    end),
    awful.key({ modkey, "Shift" }, "m", function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
    end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys, -- View tag only.
        awful.key({ modkey }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then tag:view_only() end
        end, { description = "view tag #" .. i, group = "tag" }), -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then awful.tag.viewtoggle(tag) end
        end, { description = "toggle tag #" .. i, group = "tag" }), -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:move_to_tag(tag) end
            end
        end, { description = "move focused client to tag #" .. i, group = "tag" }), -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:toggle_tag(tag) end
            end
        end, { description = "toggle focused client on tag #" .. i, group = "tag" }))
end

clientbuttons = gears.table.join(
    awful.button({}, 1, function(c) c:emit_signal("request::activate", "mouse_click", { raise = true }) end),
    awful.button({ modkey }, 1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
            awful.mouse.client.move(c)
        end),
    awful.button({ modkey }, 3,
        function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
            awful.mouse.client.resize(c)
        end))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = { -- All clients will match this rule.
        {
            rule = {},
            properties = {
                border_width = beautiful.border_width,
                border_color = beautiful.border_normal,
                focus = awful.client.focus.filter,
                raise = true,
                keys = clientkeys,
                buttons = clientbuttons,
                screen = awful.screen.preferred,
                placement = awful.placement.no_overlap +
                    awful.placement.no_offscreen
            }
        },

        -- Floating clients.
        {
            rule_any = {
                instance = {
                    "DTA",   -- Firefox addon DownThemAll.
                    "copyq", -- Includes session name in class.
                    "pinentry"
                },
                class = {
                    "Arandr", "Blueman-manager", "Gpick", "Kruler", "MessageWin", -- kalarm.
                    "Sxiv", "Wpa_gui", "veromix", "xtightvncviewer", "confirm",
                    "confirmreset", "dialog", "download", "error", "file_progress",
                    "Gnome-screenshot", "makebranch", "maketag", "notification",
                    "Pavucontrol", "splash", "ssh-askpass", "toolbar"
                },

                -- Note that the name property shown in xprop might be set slightly after creation of the client
                -- and the name shown there might not match defined rules here.
                name = {
                    "Event Tester", -- xev.
                    "Authentication", "branchdialog", "Chat", "pinentry", "Polls" },
                role = {
                    "AlarmWindow",   -- Thunderbird's calendar.
                    "ConfigManager", -- Thunderbird's about:config.
                    "pop-up",        -- e.g. Google Chrome's (detached) Developer Tools.
                    "conversation", "utility", "notificion", "toolbar", "splash", "dialog"
                },
                type = {
                    "dialog",
                }
            },
            properties = {
                floating = true,
                width = "1920" * 0.75,
                height = "1080" * 0.5,
                placement = awful.placement.centered
            }
        },

        -- Rule to make Polybar windows non-focusable
        {
            rule_any = { class = { "Polybar" } },
            properties = {
                focusable = false,
                border_width = 0,
                above = false
            }
        },

        {
            rule_any = {
                type = { "glava" },
                class = { "GLava" }
            },
            properties = {
                floating = true,
                buttons = nil,
                keys = nil,
                focusable = false,
                geometry = { height = 300, width = 2560, y = 1440 - 300 + 16 },
                sticky = true,
                below = true,
                titlebars_enabled = false,
                border_width = 0,
                skip_decoration = true
            }
        },

        -- Rule to fullscreen apps
        {
            rule_any = { class = { "SafeEyes", "feh", "mpv" } },
            properties = { screen = 1, fullscreen = true },
            callback = function(c)
                -- When a fullscreen app is managed, remove the rounded corners
                c.shape = function(cr, w, h)
                    gears.shape.rectangle(cr, w, h)
                end
            end
        },

        {
            rule_any = {
                name = {
                    "firefox",
                    "Tor Browser",
                    "LibreWolf",
                    "qutebrowser",
                    "Vivaldi-stable",
                    "Chromium",
                    "Google-chrome",
                    "Brave-browser"
                },
                -- role = {
                --     "browser"
                -- }
            },
            properties = { tag = beautiful.tag[2], switchtotag = true }
        },

        {
            rule_any = {
                class = {
                    "dolphin",
                    "pcmanfm-qt",
                    "ark",
                    "Nemo",
                    "File-roller",
                    "Thunar"
                }
            },
            properties = { tag = beautiful.tag[3], switchtotag = true }
        },

        {
            rule_any = {
                instance = {
                    "htop",
                },
                class = { "KeePassXC", "VeraCrypt", "tor-browser", "qBittorrent", "htop", "gotop" }
            },
            properties = {
                tag = beautiful.tag[4],
                switchtotag = true
                -- floating = true,
                -- width = "1376",
                -- height = "824",
                -- placement = awful.placement.centered
            }
        },

        {
            rule_any = {
                class = { "Slack", "TelegramDesktop", "discord", "Zoom", "Skype" },
            },
            properties = {
                screen = 1,
                tag = beautiful.tag[5],
                --      floating = function(c)
                --          if c.instance == "telegram-desktop" or c.class == "TelegramDesktop" then
                --              return true
                --              end
                --          return false
                --      end,
                --      width = 420,
                --      height = 900,
                --      placement = awful.placement.right

                switchtotag = true
            },
        },

        {
            rule_any = { class = { "Obsidian" } },
            properties = { screen = 1, tag = beautiful.tag[6], switchtotag = true }
        },

        {
            rule_any = { class = { "Code", "code-oss", "jetbrains-phpstorm", "jetbrains-idea" } },
            properties = { screen = 1, tag = beautiful.tag[8], switchtotag = true }
        },

        -- Fixed terminal geometry for floating terminals
        {
            rule_any = {
                class = {
                    "mpv",
                    "kitty",
                    "st-256color",
                    "st",
                    "URxvt",
                },
            },
            properties = {
                width = awful.screen.focused().geometry.width * 0.45,
                height = awful.screen.focused().geometry.height * 0.5
            }
        }

    },
    -- }}}
    -- {{{ Signals
    -- Signal function to execute when a new client appears.
    client.connect_signal("manage", function(c)
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- if not awesome.startup then awful.client.setslave(c) end

        if awesome.startup and not c.size_hints.user_position and
            not c.size_hints.program_position then
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
        end
    end)

-- Autostart
awful.spawn.with_shell("ksuperkey -e 'Super_L=Alt_L|F1' & ksuperkey -e 'Super_R=Alt_L|F1'")
awful.spawn.with_shell("feh --bg-scale --randomize --no-fehbg ~/Pictures/Wallpapers/*")
-- awful.spawn.with_shell("picom -CGb --config ~/.config/picom.conf")
awful.spawn.with_shell("~/.config/polybar/launch.sh")
awful.spawn.with_shell("~/.config/awesome/scripts/autostart.sh")
awful.spawn.with_shell("~/.config/awesome/scripts/volume.sh")
awful.spawn.with_shell("~/.config/awesome/scripts/brightness.sh")
awful.spawn.with_shell("~/.config/awesome/scripts/battery_monitor.sh")

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Helpers

-- Rounded corners for all windows
client.connect_signal("manage", function(c)
    c.shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 18)
    end
end)

-- If == 1 opened window then floating, else tiled
TileToogledTags = function(t)
    if t.name == beautiful.tag[3] or t.name == beautiful.tag[4] or t.name == beautiful.tag[6] or t.name == beautiful.tag[9] then
        local tab = t
        c_number = tab:clients()
        if #c_number == 1 then
            local c = tab:clients()
            local geom = screen.primary.geometry
            c[1].width = math.ceil(geom.width * 0.80)
            c[1].height = math.ceil(geom.height * 0.85)
            awful.placement.align(c[1], { position = "centered" })
            t.layout = awful.layout.suit.floating
        else
            if #c_number > 1 then
                t.layout = awful.layout.suit.tile
            end
        end
    end
end

FmTag = awful.tag.find_by_name(awful.screen.focused(), beautiful.tag[3])
KeyTag = awful.tag.find_by_name(awful.screen.focused(), beautiful.tag[4])
NoteTag = awful.tag.find_by_name(awful.screen.focused(), beautiful.tag[6])
MediaTag = awful.tag.find_by_name(awful.screen.focused(), beautiful.tag[9])

tag.connect_signal("request::select", function(tag) TileToogledTags(tag) end)
tag.connect_signal("tagged", function() TileToogledTags(FmTag) end)
tag.connect_signal("untagged", function() TileToogledTags(FmTag) end)
tag.connect_signal("tagged", function() TileToogledTags(KeyTag) end)
tag.connect_signal("untagged", function() TileToogledTags(KeyTag) end)
tag.connect_signal("tagged", function() TileToogledTags(NoteTag) end)
tag.connect_signal("untagged", function() TileToogledTags(NoteTag) end)
tag.connect_signal("tagged", function() TileToogledTags(MediaTag) end)
tag.connect_signal("untagged", function() TileToogledTags(MediaTag) end)

-- Run garbage collector regularly to prevent memory leaks
local function perform_garbage_collection()
    collectgarbage("incremental", 150, 600, 0)
end

gears.timer {
    timeout = 60,
    autostart = true,
    callback = function() perform_garbage_collection() end
}

-- Comand to show app name
-- xprop | grep WM_CLASS
