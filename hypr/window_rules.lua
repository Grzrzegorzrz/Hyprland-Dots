local vars = require("variables")

local function anchored(value)
    return "^(" .. value .. ")$"
end

hl.window_rule({
    name = "windowrule-1",
    match = { class = anchored("wayland") },
    no_blur = false,
})

hl.window_rule({
    name = "windowrule-2",
    match = { class = anchored("feh") },
    float = true,
    move = { "cursor_x-(window_w*1)", "cursor_y-(window_h*1)" },
})

hl.window_rule({
    name = "windowrule-3",
    match = { class = anchored("org.kde.kalk") },
    float = true,
    size = { "monitor_w*0.17", "monitor_h*0.4" },
})

hl.window_rule({
    name = "windowrule-4",
    match = { class = anchored("qalculate-gtk") },
    float = true,
})

hl.window_rule({
    name = "windowrule-5",
    match = { class = anchored("flameshot") },
    no_anim = true,
})

hl.window_rule({
    name = "windowrule-6",
    match = { class = "(flameshot)", title = "(flameshot)" },
    move = { 0, 0 },
    float = true,
})

hl.window_rule({
    name = "windowrule-7",
    match = { class = anchored(vars.terminal), title = anchored("terminal filechooser") },
    float = true,
    size = { "monitor_w*0.6", "monitor_h*0.65" },
})

hl.window_rule({
    name = "windowrule-8",
    match = { class = anchored(vars.discord) },
    workspace = "special:discord",
})

hl.window_rule({
    name = "windowrule-9",
    match = { class = anchored(vars.terminal), title = anchored(vars.top) },
    workspace = "special:top",
})

hl.window_rule({
    name = "windowrule-10",
    match = { class = ".*" }, -- You'll probably like this.
    suppress_event = "maximize",
})

-- Launch programs when an empty special workspace is created.
local workspace_programs = {
    ["special:email"] = { command = vars.email },
    ["special:discord"] = { command = vars.discord },
    ["special:spotify"] = { command = vars.spotify },
    ["special:top"] = { command = vars.top },
    ["special:terminal"] = { command = vars.terminal, float = true },
}

hl.on("workspace.created", function(workspace)
    local program = workspace_programs[workspace.name]
    if not program or not workspace.is_empty then
        return
    end

    hl.exec_cmd(program.command, {
        workspace = workspace.name .. " silent",
        float = program.float,
    })
end)

-- dynamically added float rules
hl.window_rule({
    name = "windowrule-11",
    match = { class = anchored("zen"), initial_title = anchored("Parent process Browser Console") },
    float = true,
})

hl.window_rule({
    name = "windowrule-12",
    match = { class = anchored("zen"), initial_title = anchored("Library") },
    float = true,
})

hl.window_rule({
    name = "windowrule-13",
    match = { class = anchored("zen"), initial_title = anchored("Picture-in-Picture") },
    float = true,
})

hl.window_rule({
    name = "windowrule-14",
    match = { class = anchored("zen"), initial_title = anchored("") },
    float = true,
})

hl.window_rule({
    name = "windowrule-15",
    match = { class = anchored("flameshot"), initial_title = anchored("Configuration") },
    float = true,
})

hl.window_rule({
    name = "windowrule-16",
    match = { class = anchored("flameshot"), initial_title = anchored("flameshot-pin") },
    float = true,
})

hl.window_rule({
    name = "anki_browser_float",
    match = { class = anchored("anki"), initial_title = anchored("Anki") },
    float = true,
})

hl.window_rule({
    name = "anki_card_edit_float",
    match = { class = anchored("anki"), initial_title = anchored("Current") },
    float = true,
})

require("window_rules_dynamic")
