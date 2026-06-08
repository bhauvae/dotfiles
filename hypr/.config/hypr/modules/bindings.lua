-- bindings.lua
-- Hyprland Lua keybinds with dispatcher objects and Noctalia shell IPC.

----------------------------
-- Helpers / base commands
----------------------------

-- simple wrapper for exec
local function cmd(s)
	return hl.dsp.exec_cmd(s)
end

-- Noctalia IPC helper (qs -c noctalia-shell ipc call [args...])
local function noct(target_and_fn)
	return hl.dsp.exec_cmd("qs -c noctalia-shell ipc call " .. target_and_fn)
end

-- simple notification helper
local function notify(text)
	hl.notification.create({
		text = text,
		timeout = 2500,
	})
end

----------------------------
-- Variables
----------------------------

local mainMod = "SUPER"
local terminal = "kitty"
local browser = "qutebrowser"
local noteApp = "neovim"
local officeSuite = "onlyoffice"
local fileManager = terminal .. " -e yazi"
local altFileManager = "nautilus"
local altEditor = "neovim"
local editor = terminal .. " -e nvim"
local calculator = "gnome-calculator"
local launcher = "tofi-drun --drun-launch=true"
local musicPlayer = "pear-desktop"

-- Noctalia workspace overview plugin.[web:78]
local quickshellOverview = "qs ipc -c overview call overview toggle"

----------------------------
-- Layout toggle helpers
----------------------------

-- Toggle between dwindle and scrolling layouts with a notification.[web:129][web:138][web:139]
local function toggle_layout_dwindle_scrolling()
	local current = hl.get_config("general.layout")
	local new_layout

	if current == "scrolling" then
		new_layout = "dwindle"
	else
		new_layout = "scrolling"
	end

	hl.config({
		general = {
			layout = new_layout,
		},
	})

	notify("Layout: " .. new_layout)
end

----------------------------
-- Application launchers
----------------------------

hl.bind(mainMod .. " + B", cmd(browser), { description = "Launch browser (" .. browser .. ")" })

hl.bind(mainMod .. " + E", cmd(fileManager), { description = "Launch primary file manager (" .. fileManager .. ")" })

hl.bind(
	mainMod .. " + SHIFT + E",
	cmd(altFileManager),
	{ description = "Launch alternate file manager (" .. altFileManager .. ")" }
)

hl.bind(mainMod .. " + RETURN", cmd(terminal), { description = "Launch terminal (" .. terminal .. ")" })

hl.bind(mainMod .. " + BACKSPACE", cmd(editor), { description = "Launch primary editor (" .. editor .. ")" })

hl.bind(
	mainMod .. " + SHIFT + BACKSPACE",
	cmd(altEditor),
	{ description = "Launch alternate editor (" .. altEditor .. ")" }
)

hl.bind(mainMod .. " + SHIFT + M", cmd(musicPlayer), { description = "Launch music player (" .. musicPlayer .. ")" })

----------------------------
-- Scratchpad / special workspace
----------------------------

-- Focus scratchpad special workspace.
hl.bind(
	"SUPER + grave",
	hl.dsp.workspace.toggle_special("scratchpad"),
	{ description = "Focus scratchpad special workspace" }
)

-- Move active window to scratchpad (and follow it).
hl.bind(
	mainMod .. " + SHIFT + grave",
	hl.dsp.window.move({ workspace = "special:scratchpad", follow = true }),
	{ description = "Move focused window to scratchpad workspace" }
)

----------------------------
-- UI / launcher
----------------------------

-- External app launcher.
hl.bind(mainMod .. " + SPACE", cmd(launcher), { description = "Open app launcher" })

-- Vicinae main panel toggle.
hl.bind("ALT + space", cmd("vicinae toggle"), { description = "Toggle Vicinae main panel" })

-- Clipboard history via Vicinae.
hl.bind(
	"SUPER + V",
	cmd("vicinae 'vicinae://launch/clipboard/history?toggle=true'"),
	{ description = "Toggle Vicinae clipboard history" }
)

-- SUPER+SHIFT+V: Noctalia audio panel toggle.[web:90]
hl.bind(mainMod .. " + SHIFT + V", noct("plugin:clipper toggle"), { description = "Toggle Noctalia volume panel" })

-- Workspace overview (Noctalia plugin).[web:78]
hl.bind(mainMod .. " + TAB", cmd(quickshellOverview), { description = "Toggle workspace overview" })

----------------------------
-- Noctalia shell functions
----------------------------

-- Ctrl+Alt+Delete → Noctalia session menu (lock/suspend etc.).[web:89]
hl.bind(
	"CTRL + ALT + DELETE",
	noct("sessionMenu toggle"),
	{ description = "Open Noctalia session menu (lock and suspend)" }
)

-- SUPER+/ → Noctalia keybind cheatsheet panel (if plugin present).
hl.bind(
	mainMod .. " + Slash",
	cmd("vicinae 'vicinae://launch/@sovereign/store.vicinae.hypr-keybinds/hyprland-keybinds'"),
	{ description = "Toggle Noctalia keybind cheatsheet" }
)

----------------------------
-- Window control
----------------------------

-- Soft close / kill active window.[web:110]
hl.bind(mainMod .. " + Q", hl.dsp.window.close(), { description = "Close focused window (graceful)" })

hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill(), { description = "Kill focused window (force)" })

-- Fullscreen / maximized.[web:125][web:135]
hl.bind(
	mainMod .. " + F",
	hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
	{ description = "Toggle fullscreen for focused window" }
)
hl.bind(
	mainMod .. " + SHIFT + F",
	hl.dsp.window.fullscreen_state({ internal = 0, client = 2, action = "toggle" }),
	{ description = "Toggle special fullscreen within the tile" }
)

hl.bind(
	mainMod .. " + M",
	hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }),
	{ description = "Toggle maximized (tiling-maximize) for focused window" }
)

-- Floating toggle.[web:129]
hl.bind(
	mainMod .. " + T",
	hl.dsp.window.float({ action = "toggle" }),
	{ description = "Toggle floating for focused window" }
)

-- All-float workspace (use legacy dispatcher via exec, rare operation).[web:104]
hl.bind(
	mainMod .. " + SHIFT + T",
	cmd("hyprctl dispatch 'workspaceopt allfloat'"),
	{ description = "Toggle all-float option for current workspace" }
)

-- Dwindle: toggle split at focused node.[web:121]
hl.bind(
	mainMod .. " + SHIFT + S",
	hl.dsp.layout("togglesplit"),
	{ description = "Dwindle: toggle split orientation at focused node" }
)

-- Center window.
hl.bind(
	mainMod .. " + SHIFT + C",
	hl.dsp.window.move({ x = 0, y = 0, center = true }),
	{ description = "Center focused window on screen" }
)

-- Pin / unpin window.[web:129]
hl.bind(
	mainMod .. " + ALT + T",
	hl.dsp.window.pin({ action = "toggle" }),
	{ description = "Toggle pin for focused window" }
)

----------------------------
-- Focus navigation
----------------------------

-- Arrow keys.
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }), { description = "Focus window to the left" })

hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }), { description = "Focus window to the right" })

hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }), { description = "Focus window above" })

hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }), { description = "Focus window below" })

-- Vim-style HJKL.
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }), { description = "Focus window left (H)" })

hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }), { description = "Focus window right (L)" })

hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }), { description = "Focus window up (K)" })

hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }), { description = "Focus window down (J)" })

----------------------------
-- Move windows (group-aware)
----------------------------

-- Move active window or group in direction (movewindoworgroup equivalent).[web:102]
local function move_window_group(dir)
	return hl.dsp.window.move({ direction = dir, group_aware = true })
end

hl.bind(mainMod .. " + SHIFT + left", move_window_group("left"), { description = "Move window/group left" })

hl.bind(mainMod .. " + SHIFT + right", move_window_group("right"), { description = "Move window/group right" })

hl.bind(mainMod .. " + SHIFT + up", move_window_group("up"), { description = "Move window/group up" })

hl.bind(mainMod .. " + SHIFT + down", move_window_group("down"), { description = "Move window/group down" })

hl.bind(mainMod .. " + SHIFT + H", move_window_group("left"), { description = "Move window/group left (H)" })

hl.bind(mainMod .. " + SHIFT + L", move_window_group("right"), { description = "Move window/group right (L)" })

hl.bind(mainMod .. " + SHIFT + K", move_window_group("up"), { description = "Move window/group up (K)" })

hl.bind(mainMod .. " + SHIFT + J", move_window_group("down"), { description = "Move window/group down (J)" })

----------------------------
-- Mouse-based move / resize
----------------------------

-- Use mouse binds via dispatcher helpers.[web:13]
hl.bind(
	mainMod .. " + mouse:272",
	hl.dsp.window.drag(),
	{ mouse = true, description = "Drag focused window with mouse (LMB)" }
)

hl.bind(
	mainMod .. " + mouse:273",
	hl.dsp.window.resize(),
	{ mouse = true, description = "Resize focused window with mouse (RMB)" }
)

----------------------------
-- Manual sizing (was binde)
----------------------------
local resizeUnit = 100
hl.bind(
	mainMod .. " + minus",
	hl.dsp.window.resize({ x = -resizeUnit, y = 0, relative = true }),
	{ repeating = true, description = "Shrink window horizontally by " .. resizeUnit }
)

hl.bind(
	mainMod .. " + equal",
	hl.dsp.window.resize({ x = resizeUnit, y = 0, relative = true }),
	{ repeating = true, description = "Grow window horizontally by " .. resizeUnit }
)

hl.bind(
	mainMod .. " + SHIFT + minus",
	hl.dsp.window.resize({ x = 0, y = -resizeUnit, relative = true }),
	{ repeating = true, description = "Shrink window vertically by " .. resizeUnit }
)

hl.bind(
	mainMod .. " + SHIFT + equal",
	hl.dsp.window.resize({ x = 0, y = resizeUnit, relative = true }),
	{ repeating = true, description = "Grow window vertically by " .. resizeUnit }
)

----------------------------
-- Grouping
----------------------------

hl.bind(mainMod .. " + G", hl.dsp.group.toggle({}), { description = "Toggle group for focused window" })

hl.bind(
	mainMod .. " + SHIFT + G",
	hl.dsp.group.lock_active({ action = "toggle" }),
	{ description = "Toggle lock on current group" }
)

----------------------------
-- Swapping windows
----------------------------

hl.bind(
	mainMod .. " + ALT + left",
	hl.dsp.window.swap({ direction = "left" }),
	{ description = "Swap window with neighbor to the left" }
)

hl.bind(
	mainMod .. " + ALT + right",
	hl.dsp.window.swap({ direction = "right" }),
	{ description = "Swap window with neighbor to the right" }
)

hl.bind(
	mainMod .. " + ALT + up",
	hl.dsp.window.swap({ direction = "up" }),
	{ description = "Swap window with neighbor above" }
)

hl.bind(
	mainMod .. " + ALT + down",
	hl.dsp.window.swap({ direction = "down" }),
	{ description = "Swap window with neighbor below" }
)

hl.bind(mainMod .. " + ALT + H", hl.dsp.window.swap({ direction = "left" }), { description = "Swap window left (H)" })

hl.bind(mainMod .. " + ALT + L", hl.dsp.window.swap({ direction = "right" }), { description = "Swap window right (L)" })

hl.bind(mainMod .. " + ALT + K", hl.dsp.window.swap({ direction = "up" }), { description = "Swap window up (K)" })

hl.bind(mainMod .. " + ALT + J", hl.dsp.window.swap({ direction = "down" }), { description = "Swap window down (J)" })

----------------------------
-- Workspace navigation
----------------------------

-- Alt+Tab: snappy-switcher.
hl.bind("ALT + Tab", cmd("snappy-switcher next"), { description = "Snappy-switcher: next window" })

hl.bind("ALT + SHIFT + Tab", cmd("snappy-switcher prev"), { description = "Snappy-switcher: previous window" })

-- Previous / relative / empty workspaces.[web:111][web:130]
hl.bind(
	mainMod .. " + CTRL + Tab",
	hl.dsp.focus({ workspace = "previous" }),
	{ description = "Focus previous workspace" }
)

hl.bind(
	mainMod .. " + CTRL + H",
	hl.dsp.focus({ workspace = "m-1" }),
	{ description = "Focus workspace -1 on current monitor (m-1)" }
)

hl.bind(
	mainMod .. " + CTRL + L",
	hl.dsp.focus({ workspace = "m+1" }),
	{ description = "Focus workspace +1 on current monitor (m+1)" }
)

hl.bind(
	mainMod .. " + CTRL + down",
	hl.dsp.focus({ workspace = "empty" }),
	{ description = "Focus next empty workspace" }
)

-- e+1 / e-1 navigation.
hl.bind(
	mainMod .. " + Page_Down",
	hl.dsp.focus({ workspace = "e+1" }),
	{ description = "Focus next empty workspace (Page Down)" }
)

hl.bind(
	mainMod .. " + Page_Up",
	hl.dsp.focus({ workspace = "e-1" }),
	{ description = "Focus previous empty workspace (Page Up)" }
)

hl.bind(mainMod .. " + U", hl.dsp.focus({ workspace = "e+1" }), { description = "Focus next empty workspace (U)" })

hl.bind(mainMod .. " + I", hl.dsp.focus({ workspace = "e-1" }), { description = "Focus previous empty workspace (I)" })

hl.bind(
	mainMod .. " + SHIFT + U",
	hl.dsp.window.move({ workspace = "e+1", follow = true }),
	{ description = "Move window to next empty workspace and follow" }
)

hl.bind(
	mainMod .. " + SHIFT + I",
	hl.dsp.window.move({ workspace = "e-1", follow = true }),
	{ description = "Move window to previous empty workspace and follow" }
)

----------------------------
-- Workspace mouse wheel
----------------------------

-- Move window between workspaces using mouse wheel (relative empty).[web:13][web:116]
hl.bind(
	mainMod .. " + CTRL + mouse_down",
	hl.dsp.window.move({ workspace = "e+1", follow = true }),
	{ mouse = true, description = "Move window to next empty workspace (mouse wheel down)" }
)

hl.bind(
	mainMod .. " + CTRL + mouse_up",
	hl.dsp.window.move({ workspace = "e-1", follow = true }),
	{ mouse = true, description = "Move window to previous empty workspace (mouse wheel up)" }
)

----------------------------
-- Numbered workspaces
----------------------------

-- mainMod + [1–10] focus; SHIFT moves window.[web:130][web:116]
for i = 1, 10 do
	local key = i % 10 -- 10 → 0

	hl.bind(
		mainMod .. " + " .. key,
		hl.dsp.focus({ workspace = i }),
		{ description = "Focus workspace " .. tostring(i) }
	)

	hl.bind(
		mainMod .. " + SHIFT + " .. key,
		hl.dsp.window.move({ workspace = i, follow = true }),
		{ description = "Move window to workspace " .. tostring(i) .. " and follow" }
	)
end

----------------------------
-- Relative workspaces (silent send)
----------------------------

-- Send window to relative workspace (monitor-local) without following.
for i = 1, 9 do
	hl.bind(
		mainMod .. " + ALT + " .. i,
		hl.dsp.window.move({ workspace = "r~" .. i, follow = false }),
		{ description = "Send window silently to relative workspace r~" .. i }
	)
end

----------------------------
-- Move to workspace / monitor helpers
----------------------------

-- Relative workspaces on current monitor (m±1) for the window.[web:116][web:120]
hl.bind(
	mainMod .. " + CTRL + up",
	hl.dsp.window.move({ workspace = "m-1", follow = true }),
	{ description = "Move window to previous workspace on current monitor and follow" }
)

hl.bind(
	mainMod .. " + CTRL + U",
	hl.dsp.window.move({ workspace = "m+1", follow = true }),
	{ description = "Move window to next workspace on current monitor and follow" }
)

hl.bind(
	mainMod .. " + CTRL + I",
	hl.dsp.window.move({ workspace = "m-1", follow = true }),
	{ description = "Move window to previous workspace on current monitor and follow (I)" }
)

-- Focus other monitors.[web:129][web:116]
hl.bind(mainMod .. " + CTRL + left", hl.dsp.focus({ monitor = "-1" }), { description = "Focus previous monitor" })

hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ monitor = "+1" }), { description = "Focus next monitor" })

hl.bind(mainMod .. " + CTRL + J", hl.dsp.focus({ monitor = "+1" }), { description = "Focus next monitor (J)" })

hl.bind(mainMod .. " + CTRL + K", hl.dsp.focus({ monitor = "-1" }), { description = "Focus previous monitor (K)" })

-- Move window between monitors (follow). [web:120]
hl.bind(
	mainMod .. " + SHIFT + CTRL + left",
	hl.dsp.window.move({ monitor = "-1", follow = true }),
	{ description = "Move window to previous monitor and follow" }
)

hl.bind(
	mainMod .. " + SHIFT + CTRL + right",
	hl.dsp.window.move({ monitor = "+1", follow = true }),
	{ description = "Move window to next monitor and follow" }
)

hl.bind(
	mainMod .. " + SHIFT + CTRL + down",
	hl.dsp.window.move({ monitor = "+1", follow = true }),
	{ description = "Move window to next monitor and follow (down)" }
)

hl.bind(
	mainMod .. " + SHIFT + CTRL + up",
	hl.dsp.window.move({ monitor = "-1", follow = true }),
	{ description = "Move window to previous monitor and follow (up)" }
)

hl.bind(
	mainMod .. " + SHIFT + CTRL + H",
	hl.dsp.window.move({ monitor = "-1", follow = true }),
	{ description = "Move window to previous monitor and follow (H)" }
)

hl.bind(
	mainMod .. " + SHIFT + CTRL + J",
	hl.dsp.window.move({ monitor = "+1", follow = true }),
	{ description = "Move window to next monitor and follow (J)" }
)

hl.bind(
	mainMod .. " + SHIFT + CTRL + K",
	hl.dsp.window.move({ monitor = "-1", follow = true }),
	{ description = "Move window to previous monitor and follow (K)" }
)

hl.bind(
	mainMod .. " + SHIFT + CTRL + L",
	hl.dsp.window.move({ monitor = "+1", follow = true }),
	{ description = "Move window to next monitor and follow (L)" }
)

-- First/last window on workspace.
hl.bind(
	mainMod .. " + Home",
	hl.dsp.focus({ window = "first" }),
	{ description = "Focus first window on current workspace" }
)

hl.bind(
	mainMod .. " + End",
	hl.dsp.focus({ window = "last" }),
	{ description = "Focus last window on current workspace" }
)

----------------------------
-- Column / layout helpers
----------------------------

-- Dwindle layout preselect (bsp-like split). [web:143]
hl.bind(mainMod .. " + bracketleft", hl.dsp.layout("preselect l"), { description = "Dwindle: preselect split left" })

hl.bind(mainMod .. " + bracketright", hl.dsp.layout("preselect r"), { description = "Dwindle: preselect split right" })

-- Scrolling layout helpers: move/tune columns.[web:139][web:136]
hl.bind("SUPER + period", hl.dsp.layout("move +col"), { description = "Scrolling: move view to next column (+col)" })

hl.bind("SUPER + comma", hl.dsp.layout("move -col"), { description = "Scrolling: move view to previous column (-col)" })

hl.bind(
	"SUPER + SHIFT + period",
	hl.dsp.layout("swapcol r"),
	{ description = "Scrolling: swap column with right neighbor" }
)

hl.bind(
	"SUPER + SHIFT + comma",
	hl.dsp.layout("swapcol l"),
	{ description = "Scrolling: swap column with left neighbor" }
)

----------------------------
-- Layout toggle keybinds
----------------------------

-- Toggle dwindle/scrolling with notification.[web:138][web:139]
hl.bind("SUPER + P", function()
	toggle_layout_dwindle_scrolling()
end, { description = "Toggle layout between dwindle and scrolling (with notification)" })

-- Optional explicit dwindle and scrolling setters (kept separate to avoid conflicts). [web:138][web:145]
hl.bind("SUPER + SHIFT + P", function()
	hl.config({ general = { layout = "dwindle" } })
	notify("Layout: dwindle")
end, { description = "Set layout to dwindle (with notification)" })

hl.bind("SUPER + ALT + P", function()
	hl.config({ general = { layout = "scrolling" } })
	notify("Layout: scrolling")
end, { description = "Set layout to scrolling (with notification)" })

----------------------------
-- Screenshots (Noctalia plugin)
----------------------------

-- Noctalia screenshot plugin IPC.[web:83]
hl.bind(
	"Print",
	noct("plugin:screenshot takeScreenshot region"),
	{ description = "Screenshot current screen (Noctalia screenshot plugin)" }
)
hl.bind(
	"SUPER + Print",
	noct("plugin:screen-toolkit toggle"),
	{ description = "Screenshot current screen (Noctalia screenshot plugin)" }
)

----------------------------
-- Audio controls (Noctalia System Controls)
----------------------------

-- Output volume.[web:82][web:90][web:13]
hl.bind(
	"XF86AudioRaiseVolume",
	noct("volume increase"),
	{ locked = true, repeating = true, description = "Raise output volume (Noctalia)" }
)

hl.bind(
	"XF86AudioLowerVolume",
	noct("volume decrease"),
	{ locked = true, repeating = true, description = "Lower output volume (Noctalia)" }
)

hl.bind("XF86AudioMute", noct("volume muteOutput"), { locked = true, description = "Toggle output mute (Noctalia)" })

-- Microphone mute.[web:90]
hl.bind(
	"XF86AudioMicMute",
	noct("volume muteInput"),
	{ locked = true, description = "Toggle microphone mute (Noctalia)" }
)

-- Media transport via playerctl.[web:13]
hl.bind("XF86AudioPause", cmd("playerctl play-pause"), { locked = true, description = "Play/Pause media (playerctl)" })

hl.bind(
	"XF86AudioPlay",
	cmd("playerctl play-pause"),
	{ locked = true, description = "Play/Pause media (playerctl, Play key)" }
)

hl.bind("XF86AudioPrev", cmd("playerctl previous"), { locked = true, description = "Previous track (playerctl)" })

hl.bind("XF86AudioNext", cmd("playerctl next"), { locked = true, description = "Next track (playerctl)" })

----------------------------
-- Brightness controls (Noctalia)
----------------------------

-- Noctalia brightness IPC.[web:94][web:91]
hl.bind(
	"XF86MonBrightnessUp",
	noct("brightness increase"),
	{ locked = true, repeating = true, description = "Increase display brightness (Noctalia)" }
)

hl.bind(
	"XF86MonBrightnessDown",
	noct("brightness decrease"),
	{ locked = true, repeating = true, description = "Decrease display brightness (Noctalia)" }
)

-- end bindings.lua
