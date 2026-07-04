-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	hl.exec_cmd("systemctl --user start hyprland-session.target")
	hl.exec_cmd("hyprpm reload")

	hl.exec_cmd("vicinae server")

	hl.exec_cmd("qs -c noctalia-shell")

	hl.exec_cmd("snappy-switcher --daemon")
end)
