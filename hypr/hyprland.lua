-- TODO: work on hypridle and hyprlock
-- TODO: do the md for the repo

local vars = require("variables")

local scripts = vars.scripts

----------------
--- MONITORS ---
----------------

hl.monitor({
    output = "DP-6",
    mode = "2560x1440@239.97",
    position = "1200x0",
    scale = 1,
    bitdepth = 10,
    cm = "srgb",
    vrr = 0,
})

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

-----------------
--- AUTOSTART ---
-----------------

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("/usr/bin/easyeffects --gapplication-service")
    hl.exec_cmd("udiskie")
    hl.exec_cmd("fcitx5")
    -- hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("kanshi")
    hl.exec_cmd("sddm")
    hl.exec_cmd("sleep 1; xremap $HOME/.config/xremap/xonfig.yml")
    hl.exec_cmd("sleep 1; " .. scripts .. "/waybar.sh")

    -- hl.exec_cmd("rm -r $HOME/Pictures/.float_images/*")
    hl.exec_cmd(scripts .. "/dynamic_floats.sh leftover")
    hl.exec_cmd("rm -r " .. scripts .. "/vertical_temp")
end)

-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------

hl.env("EDITOR", "nvim")
hl.env("FILEMANAGER", "/usr/local/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh")

hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", "24")

-- hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
-- hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
-- hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
-- hl.env("QT_STYLE_OVERRIDE", "kvantum")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")

hl.env("ADW_DISABLE_PORTAL", "1")
hl.env("GTK_THEME", "Orchis-Grey-Dark")

-- exec-once=systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_QPA_PLATFORMTHEME

hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "breeze-dark"')     -- for GTK3 apps
hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"') -- for GTK4 apps

-----------------
--- VARIABLES ---
-----------------

hl.config({
    general = {
        gaps_in = -1,
        gaps_out = 6,

        border_size = 3,

        -- col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col = {
            active_border = { colors = { "rgba(ffffffee)" }, angle = 45 },
            inactive_border = "rgba(90909088)",
        },

        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding = 0,

        -- Change transparency of focused and unfocused windows
        active_opacity = 1.0,
        inactive_opacity = 1.0,

        dim_strength = 0.2,

        shadow = {
            enabled = false,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        blur = {
            enabled = false,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        -- pseudotile = true -- Master switch for pseudotiling. Enabling is bound to mod + P in the keybinds section below
        preserve_split = true, -- You probably want this
    },

    -- master = {
    --     new_is_master = true,
    -- },

    misc = {
        force_default_wallpaper = 0,      -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = false,    -- If true disables the random hyprland logo / anime girl background. :(
    },

    xwayland = {
        force_zero_scaling = true,
    },

    input = {
        kb_layout = "us, us, us",
        kb_variant = ", colemak_dh_ortho, colemak_dh",
        kb_options = "grp:win_space_toggle", --, ctrl:nocaps
        kb_rules = "",

        repeat_rate = 35,
        repeat_delay = 250,

        follow_mouse = 1,
        numlock_by_default = false,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
            middle_button_emulation = true,
        },
    },

    gestures = {
        workspace_swipe_touch = true,
        workspace_swipe_cancel_ratio = 0.03,
    },

    cursor = {
        inactive_timeout = 0.2,
        min_refresh_rate = 60,
    },
})

hl.curve("myBezier", {
    type = "bezier",
    points = { { 0.03, 1 }, { 0.05, 1.0 } },
})

hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier", style = "popin 80%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "myBezier", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 2, bezier = "myBezier", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = false })

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

-- Example per-device config
hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

require("hypr_keybinds")
require("window_rules")
