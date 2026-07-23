local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-----------------
---- DESKTOP ----
-----------------

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
-- local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)

hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
)

-- Window actions
hl.bind(mainMod .. " + V", hl.dsp.window.float { action = "toggle" })
hl.bind(mainMod .. " + CTRL + V", hl.dsp.window.pin())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen { mode = "fullscreen", action = "toggle" })
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen { mode = "maximized", action = "toggle" })
hl.bind(mainMod .. " + CTRL + F", hl.dsp.window.fullscreen_state { internal = 0, client = 2, action = "toggle" })
hl.bind(mainMod .. " + O", hl.dsp.layout "togglesplit") -- dwindle only

-- Move focus with mainMod + vim style binds
hl.bind(mainMod .. " + H", hl.dsp.focus { direction = "left" })
hl.bind(mainMod .. " + L", hl.dsp.focus { direction = "right" })
hl.bind(mainMod .. " + K", hl.dsp.focus { direction = "up" })
hl.bind(mainMod .. " + J", hl.dsp.focus { direction = "down" })

-- Move windows with mainMod + vim style binds
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move { direction = "left" })
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move { direction = "right" })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move { direction = "up" })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move { direction = "down" })

-- Workspace actions
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.workspace.swap_monitors { monitor1 = "DP-2", monitor2 = "DP-3" })

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus { workspace = i })
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move { workspace = i })
end

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special "magic")
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move { workspace = "special:magic" })

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus { workspace = "e+1" })
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus { workspace = "e-1" })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize windows with mainMod + vim style keybinds
-- hl.bind(mainMod .. " + ALT + H", hl.dsp.window.resize { x = "-5%", y = 0, true })
-- hl.bind(mainMod .. " + ALT + L", hl.dsp.window.resize { x = "5%", y = 0, true })
-- hl.bind(mainMod .. " + ALT + K", hl.dsp.window.resize { x = 0, y = "-5%", true })
-- hl.bind(mainMod .. " + ALT + J", hl.dsp.window.resize { x = 0, y = "5%", true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+",
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-",
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle",
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd "brightnessctl -e4 -n2 set 5%+", { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd "brightnessctl -e4 -n2 set 5%-", { locked = true, repeating = true })

-- Requires playerctl
-- hl.bind("XF86AudioNext", hl.dsp.exec_cmd "playerctl next", { locked = true })
-- hl.bind("XF86AudioPause", hl.dsp.exec_cmd "playerctl play-pause", { locked = true })
-- hl.bind("XF86AudioPlay", hl.dsp.exec_cmd "playerctl play-pause", { locked = true })
-- hl.bind("XF86AudioPrev", hl.dsp.exec_cmd "playerctl previous", { locked = true })

------------------
---- PROGRAMS ----
------------------

local PROGRAMS = {
	file_manager = "thunar",
	terminal = "ghostty +new-window",
}

---@param command string
---@return HL.Dispatcher
local function exec(command)
	return hl.dsp.exec_cmd("uwsm app -- " .. command)
end

hl.bind(mainMod .. " + Q", exec(PROGRAMS.terminal))
hl.bind(mainMod .. " + E", exec(PROGRAMS.file_manager))

-- Screenshot
hl.bind(mainMod .. " + SHIFT + P", exec "~/.local/share/scripts/hyprland/screenshot.sh")
hl.bind(mainMod .. " + CTRL + P", exec "~/.local/share/scripts/hyprland/screenshot_area.sh")

-- Caelestia
hl.bind(mainMod .. " + SUPER_L", hl.dsp.global "caelestia:launcher", { ignore_mods = true, release = true })

hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd "pkill fuzzel || caelestia clipboard")
hl.bind(mainMod .. " + CTRL + SHIFT + L", hl.dsp.exec_cmd "pkill fuzzel || caelestia clipboard -d")
hl.bind(mainMod .. " + Period", hl.dsp.exec_cmd "pkill fuzzel || caelestia emoji -p")

-- Passthrough
hl.bind("SHIFT + CTRL + F12", hl.dsp.pass { window = "class:^(com\\.obsproject\\.Studio)$" })
