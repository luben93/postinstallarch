local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
--local menubar       = require("menubar")
local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget



local function run_once(cmd)
    local xresources_name = "awesome.started"
    local xresources = awful.util.pread("xrdb -query")
    if not xresources:match(xresources_name) then
        -- Execute once for X server
        os.execute(cmd)
        -- lang = 'us'
    end
    awful.util.spawn_with_shell("xrdb -merge <<< " .. "'" .. xresources_name .. ": true'")
end

run_once("dex -ae awesome")

terminal   = "termite"


-- [[ ALSA volume control
local mediakeys = {
awful.key({  }, "XF86AudioRaiseVolume",
function ()
    os.execute(string.format("amixer set %s 1%%+", volume.channel))
    volume.update()
end),
awful.key({  }, "XF86AudioLowerVolume",
function ()
    os.execute(string.format("amixer set %s 1%%-", volume.channel))
    volume.update()
end),
awful.key({  }, "XF86AudioMute",
function ()
    os.execute(string.format("amixer set %s toggle", volume.channel))
    volume.update()
end),
awful.key({ altkey, "Control" }, "m",
function ()
    os.execute(string.format("amixer set %s 100%%", volume.channel))
    volume.update()
end),

awful.key({  }, "XF86AudioPlay",
function ()
    awful.util.spawn_with_shell('playerctl play-pause')
    --awful.util.spawn_with_shell("mpc toggle || ncmpc toggle || pms toggle")
    mpdwidget.update()
end),
awful.key({ altkey, "Control" }, "Down",
function ()
    awful.util.spawn_with_shell("mpc stop || ncmpc stop || pms stop")
    mpdwidget.update()
end),
awful.key({ }, "XF86AudioPrev",
function ()
    awful.util.spawn_with_shell('playerctl previous')
    --awful.util.spawn_with_shell("mpc prev || ncmpc prev || pms prev")
    mpdwidget.update()
end),
awful.key({  }, "XF86AudioNext",
function ()
    awful.util.spawn_with_shell('playerctl next')
    --awful.util.spawn_with_shell("mpc next || ncmpc next || pms next")
    mpdwidget.update()
end)}
local global = root.keys()
root.keys(global + mediakeys)
-- ]]



local sloppyfocus_last = {c=nil}
    client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    client.connect_signal("mouse::enter", function(c)
         if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
             -- Skip focusing the client if the mouse wasn't moved.
             if c ~= sloppyfocus_last.c then
                 client.focus = c
                 sloppyfocus_last.c = c
             end
         end
    end)
end)

