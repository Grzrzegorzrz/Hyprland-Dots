local vars = require("variables")

local mod = "SUPER"
local scripts = vars.scripts

local function exec(command)
    return hl.dsp.exec_cmd(command)
end

local function zoom_by(factor)
    local current = hl.get_config("cursor.zoom_factor")
    local zoom = math.max(1, math.min(3, current * factor))
    hl.config({ cursor = { zoom_factor = zoom } })
end

local function zoom_reset()
    hl.config({ cursor = { zoom_factor = 1 } })
end

-- rofi
hl.bind("Super_L", exec('pkill rofi || rofi -show drun -drun-display-format "{name}"'), { release = true })
hl.bind(mod .. " + F", exec("pkill rofi || rofi -show window"))
hl.bind(mod .. " + R", exec("pkill rofi || rofi -show recursivebrowser"))

-- Window modifiers
hl.bind(mod .. " + A", hl.dsp.window.fullscreen())
hl.bind(mod .. " + Q", hl.dsp.window.close())
-- hl.bind(mod .. " + O", hl.dsp.layout("togglesplit"))
-- hl.bind(mod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind("CTRL + ALT + F", exec(scripts .. "/float_resize.sh"))

-- Screenshot to clipboard, display, then region
hl.bind("ALT + S", exec("flameshot gui"))
hl.bind(mod .. " + S", exec("grim - | wl-copy")) -- idk if this works for multi monitors
hl.bind(mod .. " + SHIFT + S", exec("grim"))     -- idk if this works for multi monitors

-- # Backup
-- hl.bind(mod .. " + S", exec("hyprshot -m output --clipboard-only"))
-- hl.bind("ALT + S", exec("hyprshot -m region --clipboard-only"))

-- Screenshot then float it
hl.bind("CTRL + ALT + S", exec(scripts .. "/dynamic_floats.sh"))

-- Applications
hl.bind("CTRL + ALT + Semicolon", exec(vars.terminal))
hl.bind("CTRL + ALT + Slash", exec(vars.fileManager))
hl.bind("CTRL + ALT + N", exec("kitty -e nvim")) -- for nvim image support
hl.bind("CTRL + ALT + B", exec(vars.browser))
hl.bind("CTRL + ALT + W", exec(scripts .. "/waybar.sh"))
hl.bind("CTRL + ALT + C", exec(vars.calculator))
hl.bind("XF86Calculator", exec(vars.calculator))

hl.bind("CTRL + ALT + Return", exec(scripts .. "/border_mode.sh"))
hl.bind("CTRL + ALT + backslash", exec(scripts .. "/background_fade.sh"))

-- Window resizing
hl.bind(mod .. " + CTRL + right", hl.dsp.window.resize({ x = 200, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + CTRL + left", hl.dsp.window.resize({ x = -200, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -200, relative = true }), { repeating = true })
hl.bind(mod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 200, relative = true }), { repeating = true })

hl.bind(mod .. " + SHIFT + right", hl.dsp.window.resize({ x = 80, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + SHIFT + left", hl.dsp.window.resize({ x = -80, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -80, relative = true }), { repeating = true })
hl.bind(mod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 80, relative = true }), { repeating = true })

-- hl.bind("SHIFT + ALT + right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
-- hl.bind("SHIFT + ALT + left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
-- hl.bind("SHIFT + ALT + up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
-- hl.bind("SHIFT + ALT + down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })

-- hl.bind(mod .. " + code:119", exec("hyprctl switchxkblayout at-translated-set-2-keyboard next")) -- change between colemak dh and qwerty

-- Audio
hl.bind("XF86AudioRaiseVolume", exec("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", exec("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("XF86AudioMute", exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

hl.bind("CTRL + XF86AudioRaiseVolume", exec("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 1%+"), { repeating = true })
hl.bind("CTRL + XF86AudioLowerVolume", exec("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 1%-"), { repeating = true })
hl.bind("CTRL + XF86AudioMute", exec("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 140%-"))

-- Mic
hl.bind("XF86AudioMicMute", exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("CTRL + ALT + XF86AudioRaiseVolume", exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SOURCE@ 5%+"), { repeating = true })
hl.bind("CTRL + ALT + XF86AudioLowerVolume", exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SOURCE@ 5%-"), { repeating = true })

-- Brightness
hl.bind("XF86MonBrightnessDown", exec("brightnessctl set 5%-"))
hl.bind("XF86MonBrightnessUp", exec("brightnessctl set 5%+"))

hl.bind("CTRL + XF86MonBrightnessDown", exec("brightnessctl set 1%-"))
hl.bind("CTRL + XF86MonBrightnessUp", exec("brightnessctl set 1%+"))

-- Zoom
hl.bind("ALT + equal", function() zoom_by(1.1) end, { repeating = true })
hl.bind("ALT + minus", function() zoom_by(0.9) end, { repeating = true })
hl.bind("ALT + KP_Add", function() zoom_by(1.1) end, { repeating = true })
hl.bind("ALT + KP_Subtract", function() zoom_by(0.9) end, { repeating = true })

hl.bind("CTRL + ALT + minus", zoom_reset)
hl.bind("CTRL + ALT + KP_Subtract", zoom_reset)
hl.bind("ALT + 0", zoom_reset)

-- change float rule
hl.bind("CTRL + ALT + grave", exec(scripts .. "/add_floating_rule.sh"))
-- hl.bind("CTRL + ALT + asciitilde", exec(scripts .. "/remove_floating_rule.sh"))

-- Switch workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind("CTRL + ALT + " .. key, hl.dsp.focus({ workspace = i }))
end

-- Switch vertical workspaces
for i = 1, 9 do
    hl.bind("CTRL + ALT + SHIFT + " .. i, hl.dsp.focus({ workspace = "special:vertical." .. i }))
end
hl.bind("CTRL + ALT + SHIFT + 0", hl.dsp.workspace.toggle_special("void"))
hl.bind("CTRL + ALT + SHIFT + 0", hl.dsp.workspace.toggle_special("void"))

-- Move active window
for i = 1, 10 do
    local key = i % 10
    hl.bind(mod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move active window to vertical
for i = 1, 9 do
    hl.bind(mod .. " + CTRL + SHIFT + " .. i, hl.dsp.window.move({ workspace = "special:vertical." .. i }))
end
-- HACK: use the move script
hl.bind(mod .. " + CTRL + SHIFT + 0", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mod .. " + CTRL + SHIFT + 0", hl.dsp.window.move({ workspace = "r-1" }))

-- Primary special workspace
hl.bind("CTRL + ALT + E", hl.dsp.workspace.toggle_special("e"))
hl.bind(mod .. " + E", exec(scripts .. "/special_workspace_move.sh -e"))
hl.bind(mod .. " + CTRL + E", exec(scripts .. "/special_workspace_move.sh -e"))

-- Secondary special workspace
hl.bind("CTRL + ALT + I", hl.dsp.workspace.toggle_special("special"))
hl.bind(mod .. " + I", exec(scripts .. "/special_workspace_move.sh"))
hl.bind(mod .. " + CTRL + I", exec(scripts .. "/special_workspace_move.sh"))

-- Discord workspace
hl.bind("CTRL + ALT + D", hl.dsp.workspace.toggle_special("discord"))
hl.bind(mod .. " + D", exec(scripts .. "/special_workspace_move.sh -d"))
hl.bind(mod .. " + CTRL + D", exec(scripts .. "/special_workspace_move.sh -d"))

-- Email workspace
hl.bind("CTRL + ALT + U", hl.dsp.workspace.toggle_special("email"))
hl.bind(mod .. " + U", exec(scripts .. "/special_workspace_move.sh -u"))
hl.bind(mod .. " + CTRL + U", exec(scripts .. "/special_workspace_move.sh -u"))

-- Spotify workspace
hl.bind("CTRL + ALT + M", hl.dsp.workspace.toggle_special("spotify"))
hl.bind(mod .. " + M", exec(scripts .. "/special_workspace_move.sh -s"))
hl.bind(mod .. " + CTRL + M", exec(scripts .. "/special_workspace_move.sh -s"))

-- Slack workspace (not in use rn)
hl.bind("CTRL + ALT + A", hl.dsp.workspace.toggle_special("slack"))

-- Top workspace
hl.bind("CTRL + ALT + T", hl.dsp.workspace.toggle_special("top"))
hl.bind(mod .. " + T", exec(scripts .. "/special_workspace_move.sh -t"))
hl.bind(mod .. " + CTRL + T", exec(scripts .. "/special_workspace_move.sh -t"))

-- Misc workspace
hl.bind("CTRL + ALT + period", hl.dsp.workspace.toggle_special("background"))
hl.bind(mod .. " + period", exec(scripts .. "/special_workspace_move.sh -g"))
hl.bind(mod .. " + CTRL + period", exec(scripts .. "/special_workspace_move.sh -g"))

-- terminal workspace
hl.bind("CTRL + ALT + Apostrophe", hl.dsp.workspace.toggle_special("terminal"))

-- Move window
hl.bind(mod .. " + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. " + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + J", hl.dsp.window.move({ direction = "down" }))

-- Move floating window
hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ x = -80, y = 0, relative = true }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ x = 80, y = 0, relative = true }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ x = 0, y = -80, relative = true }))
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({ x = 0, y = 80, relative = true }))

hl.bind(mod .. " + SHIFT + b", hl.dsp.window.move({ x = -300, y = 0, relative = true }))
hl.bind(mod .. " + SHIFT + f", hl.dsp.window.move({ x = 300, y = 0, relative = true }))
hl.bind(mod .. " + SHIFT + p", hl.dsp.window.move({ x = 0, y = -200, relative = true }))
hl.bind(mod .. " + SHIFT + n", hl.dsp.window.move({ x = 0, y = 200, relative = true }))

-- Move through workspaces
hl.bind("CTRL + ALT + l", hl.dsp.focus({ workspace = "r+1" }))
hl.bind("CTRL + ALT + h", hl.dsp.focus({ workspace = "r-1" }))
hl.bind("CTRL + ALT + j", exec(scripts .. "/vertical_workspaces.sh -1"))
hl.bind("CTRL + ALT + k", exec(scripts .. "/vertical_workspaces.sh 1"))

-- Exits out of special workspace
hl.bind("CTRL + ALT + space", hl.dsp.workspace.toggle_special("void"))
hl.bind("CTRL + ALT + space", hl.dsp.workspace.toggle_special("void"))
hl.bind("CTRL + ALT + SHIFT + space", hl.dsp.workspace.toggle_special("void"))
hl.bind("CTRL + ALT + SHIFT + space", hl.dsp.workspace.toggle_special("void"))

-- Move windows to other workspaces
hl.bind(mod .. " + CTRL + l", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mod .. " + CTRL + h", hl.dsp.window.move({ workspace = "r-1" }))
hl.bind(mod .. " + CTRL + j", exec(scripts .. "/vertical_workspaces.sh --move -1"))
hl.bind(mod .. " + CTRL + k", exec(scripts .. "/vertical_workspaces.sh --move 1"))

-- Move/resize windows with mod + LMB/RMB and dragging
hl.bind(mod .. " + mouse:272", hl.dsp.window.resize(), { mouse = true })
hl.bind(mod .. " + CTRL + mouse:272", hl.dsp.window.drag(), { mouse = true })

-- Cycle windows
hl.bind("ALT + Tab", hl.dsp.window.cycle_next())
hl.bind("ALT + SHIFT + Tab", hl.dsp.window.cycle_next({ next = false }))

-- Window focus
hl.bind("ALT + h", hl.dsp.focus({ direction = "left" }))
hl.bind("ALT + l", hl.dsp.focus({ direction = "right" }))
hl.bind("ALT + k", hl.dsp.focus({ direction = "up" }))
hl.bind("ALT + j", hl.dsp.focus({ direction = "down" }))
