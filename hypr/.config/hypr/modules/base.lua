-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Force all apps to use Wayland.
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- Allow better support for screen sharing (Google Meet, Discord, etc).
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us",

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			-- Use natural (inverse) scrolling.
			natural_scroll = true,

			-- Use two-finger clicks for right-click instead of lower-right corner.
			clickfinger_behavior = true,

			-- Control the speed of your scrolling.
			scroll_factor = 0.4,

			-- Enable the touchpad while typing.
			disable_while_typing = true,

			-- Left-click-and-drag with three fingers.
			-- drag_3fg = 1,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.config({
	cursor = {
		hide_on_key_press = true,
		hide_on_touch = true,
	},
})

-----------------------
---- LOOK AND FEEL ----
-----------------------
-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 0,
		gaps_out = 0,

		border_size = 2,

		col = {
			active_border = { colors = { "rgba(33ccffee)" } },
			inactive_border = "rgba(595959aa)",
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		blur = {
			enabled = true,
			size = 2,
			passes = 4,
			noise = 0.1,
			brightness = 1.0,
			contrast = 1.0,
		},
	},

	animations = {
		enabled = true,
	},
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
	master = {
		new_status = "master",
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

---------------------
---- KEYBINDINGS ----
---------------------

-- Main modifier
local mainMod = "SUPER"

-- Applications (adjust to taste)
local terminal = "ghostty"
local browser = "zen-browser"
local noteApp = "obsidian"
local officeSuite = "onlyoffice"
local fileManager = terminal .. " -e " .. "yazi"
local altFileManager = "nautilus"
local editor = "code"
local altEditor = terminal .. " -e " .. "nvim"
local calculator = "gnome-calculator"
local launcher = "walker"
local musicPlayer = "pear-desktop"

-- Waybar (toggle)
local barToggleCmd = "killall waybar || waybar"

-- Worspace Overview
local quickshellOverview = "qs ipc -c overview call overview toggle"
-- Clipboard UI (needs cliphist + wofi)
local cliphistCmd = "cliphist list | wofi -dmenu | cliphist decode | wl-copy"

-- Color picker (needs hyprpicker)
local colorPickerCmd = "hyprpicker -a"

-----------------------
-- Application binds --
-----------------------

hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser)) -- [CS] Launch browser

hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(noteApp)) -- [CS] Launch note-taking app

hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd(officeSuite)) -- [CS] Launch office suite

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager)) -- [CS] Launch file manager

hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(altFileManager)) -- [CS] Launch alternate file manager

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal)) -- [CS] Launch terminal

hl.bind(mainMod .. " + BACKSPACE", hl.dsp.exec_cmd(editor)) -- [CS] Launch editor

hl.bind(mainMod .. " + SHIFT + BACKSPACE", hl.dsp.exec_cmd(altEditor)) -- [CS] Launch alternate editor

-------------------
-- UI / launcher --
-------------------

hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(launcher)) -- [CS] Application launcher

hl.bind(mainMod .. " + CTRL + B", hl.dsp.exec_cmd(barToggleCmd)) -- [CS] Toggle waybar

hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(cliphistCmd)) -- [CS] Clipboard manager

hl.bind(mainMod .. " + SHIFT + ALT + M", hl.dsp.exec_cmd("hyprshade toggle")) -- [CS] Toggle screen shader (night mode)

-- Cycle workspaces
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd(quickshellOverview)) -- [CS] Workspace Overview

-------------------
-- Window control --
-------------------

hl.bind(mainMod .. " + Q", hl.dsp.window.close()) -- [CS] Kill active window

hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill()) -- [CS] Kill active window process (all instances)

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" })) -- [CS] Toggle fullscreen

hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })) -- [CS] Toggle maximized

hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" })) -- [CS] Toggle floating for active window

hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("hyprctl dispatch workspaceopt allfloat")) -- [CS] Toggle all windows floating in current workspace

hl.bind(mainMod .. " + SHIFT + O", hl.dsp.layout("togglesplit")) -- [CS] Toggle split orientation

hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.center({})) -- [CS] Center active window

-- “Always on top” via pin toggle
hl.bind(mainMod .. " + ALT + T", hl.dsp.window.pin({})) -- [CS] Toggle pin (acts like always-on-top)

----------------------------
-- Focus & move with keys --
----------------------------

-- Focus with arrows
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" })) -- [CS] Focus window left

hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" })) -- [CS] Focus window right

hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" })) -- [CS] Focus window up

hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" })) -- [CS] Focus window down

-- Focus with Vim keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" })) -- [CS] Focus window left (H)

hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" })) -- [CS] Focus window right (L)

hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" })) -- [CS] Focus window up (K)

hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" })) -- [CS] Focus window down (J)

-- Move window with arrows
hl.bind(mainMod .. " + SHIFT + LEFT", hl.dsp.window.move({ direction = "left" })) -- [CS] Move window left

hl.bind(mainMod .. " + SHIFT + RIGHT", hl.dsp.window.move({ direction = "right" })) -- [CS] Move window right

hl.bind(mainMod .. " + SHIFT + UP", hl.dsp.window.move({ direction = "up" })) -- [CS] Move window up

hl.bind(mainMod .. " + SHIFT + DOWN", hl.dsp.window.move({ direction = "down" })) -- [CS] Move window down

-- Move window with Vim keys
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" })) -- [CS] Move window left (H)

hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" })) -- [CS] Move window right (L)

hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" })) -- [CS] Move window up (K)

hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" })) -- [CS] Move window down (J)

-----------------------
-- Mouse-based moves --
-----------------------

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" })) -- [CS] Scroll forward through workspaces
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" })) -- [CS] Scroll backward through workspaces

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true }) -- [CS] Drag window with mouse

hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- [CS] Resize window with mouse

-----------------
-- Resize mode --
-----------------

-- Enter resize submap
hl.bind(mainMod .. " + CTRL + R", hl.dsp.submap("resize")) -- [CS] Enter resize mode

hl.define_submap("resize", function()
	-- Arrow keys
	hl.bind("right", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true }) -- [CS] Resize window wider (Right)

	hl.bind("left", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true }) -- [CS] Resize window narrower (Left)

	hl.bind("up", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true }) -- [CS] Resize window taller (Up)

	hl.bind("down", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true }) -- [CS] Resize window shorter (Down)

	-- Vim keys
	hl.bind("L", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true }) -- [CS] Resize window wider (L)

	hl.bind("H", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true }) -- [CS] Resize window narrower (H)

	hl.bind("K", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true }) -- [CS] Resize window taller (K)

	hl.bind("J", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true }) -- [CS] Resize window shorter (J)

	-- Exit resize mode
	hl.bind("ESCAPE", hl.dsp.submap("reset")) -- [CS] Exit resize mode
end)

----------------
-- Grouping   --
----------------

hl.bind(mainMod .. " + G", hl.dsp.group.toggle({})) -- [CS] Toggle window group

hl.bind(mainMod .. " + CTRL + G", hl.dsp.group.lock_active({ action = "toggle" })) -- [CS] Toggle lock for active group

-----------------------
-- Swapping windows  --
-----------------------

-- Swap with arrows
hl.bind(mainMod .. " + ALT + left", hl.dsp.window.swap({ direction = "left" })) -- [CS] Swap window left

hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "right" })) -- [CS] Swap window right

hl.bind(mainMod .. " + ALT + up", hl.dsp.window.swap({ direction = "up" })) -- [CS] Swap window up

hl.bind(mainMod .. " + ALT + down", hl.dsp.window.swap({ direction = "down" })) -- [CS] Swap window down

-- Swap with Vim keys
hl.bind(mainMod .. " + ALT + H", hl.dsp.window.swap({ direction = "left" })) -- [CS] Swap window left (H)

hl.bind(mainMod .. " + ALT + L", hl.dsp.window.swap({ direction = "right" })) -- [CS] Swap window right (L)

hl.bind(mainMod .. " + ALT + K", hl.dsp.window.swap({ direction = "up" })) -- [CS] Swap window up (K)

hl.bind(mainMod .. " + ALT + J", hl.dsp.window.swap({ direction = "down" })) -- [CS] Swap window down (J)

----------------
-- Workspaces --
----------------

-- Focus / move to numbered workspaces (1–10)
for i = 1, 10 do
	local key = i % 10 -- 10 -> 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i })) -- [CS] Focus workspace " .. i

	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = true })) -- [CS] Move window to workspace " .. i .. " and follow
end

-- Move window to workspace on current monitor, silently (r~N)
hl.bind(mainMod .. " + ALT + 1", hl.dsp.window.move({ workspace = "r~1", follow = false })) -- [CS] Send window silently to workspace 1 on this monitor

hl.bind(mainMod .. " + ALT + 2", hl.dsp.window.move({ workspace = "r~2", follow = false })) -- [CS] Send window silently to workspace 2 on this monitor

hl.bind(mainMod .. " + ALT + 3", hl.dsp.window.move({ workspace = "r~3", follow = false })) -- [CS] Send window silently to workspace 3 on this monitor

hl.bind(mainMod .. " + ALT + 4", hl.dsp.window.move({ workspace = "r~4", follow = false })) -- [CS] Send window silently to workspace 4 on this monitor

hl.bind(mainMod .. " + ALT + 5", hl.dsp.window.move({ workspace = "r~5", follow = false })) -- [CS] Send window silently to workspace 5 on this monitor

hl.bind(mainMod .. " + ALT + 6", hl.dsp.window.move({ workspace = "r~6", follow = false })) -- [CS] Send window silently to workspace 6 on this monitor

hl.bind(mainMod .. " + ALT + 7", hl.dsp.window.move({ workspace = "r~7", follow = false })) -- [CS] Send window silently to workspace 7 on this monitor

hl.bind(mainMod .. " + ALT + 8", hl.dsp.window.move({ workspace = "r~8", follow = false })) -- [CS] Send window silently to workspace 8 on this monitor

hl.bind(mainMod .. " + ALT + 9", hl.dsp.window.move({ workspace = "r~9", follow = false })) -- [CS] Send window silently to workspace 9 on this monitor

hl.bind("ALT + Tab", hl.dsp.focus({ workspace = "m+1" })) -- [CS] Focus next workspace

hl.bind("ALT + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" })) -- [CS] Focus previous workspace

hl.bind(mainMod .. " + CTRL + Tab", hl.dsp.focus({ workspace = "previous" })) -- [CS] Focus Former workspace

hl.bind(mainMod .. " + CTRL + H", hl.dsp.focus({ workspace = "m-1" })) -- [CS] Focus previous workspace (CTRL+H)

hl.bind(mainMod .. " + CTRL + L", hl.dsp.focus({ workspace = "m+1" })) -- [CS] Focus next workspace (CTRL+L)

-- Scroll wheel workspace switching
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" })) -- [CS] Focus next empty-or-current workspace (mouse wheel down)

hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" })) -- [CS] Focus previous empty-or-current workspace (mouse wheel up)

-- Next empty workspace
hl.bind(mainMod .. " + CTRL + down", hl.dsp.focus({ workspace = "empty" })) -- [CS] Focus next empty workspace

----------------------------
-- Special workspaces / scratchpads
----------------------------

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("scratchpad")) -- [CS] Toggle scratchpad
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:scratchpad" })) -- [CS] Shift current window to scratchpad

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})

-- LAYER RULES

hl.layer_rule({
	name = "walker-blur",
	match = { namespace = "^walker$" },
	no_anim = true,
	blur = true,
})

hl.layer_rule({
	name = "overview",
	match = { namespace = "^quickshell.*$" },
	no_anim = true,
	blur = true,
})

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	hl.exec_cmd("elephant")
	hl.exec_cmd("walker --gapplication-service")

	hl.exec_cmd("qs -c overview")
end)

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		focus_on_activate = true,
		disable_splash_rendering = true,
		disable_scale_notification = true,
		anr_missed_pings = 3,
		on_focus_under_fullscreen = 1,
		force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
	},

	xwayland = {
		force_zero_scaling = true,
	},

	ecosystem = {
		no_update_news = true,
	},
})
