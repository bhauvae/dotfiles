
---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_options = "compose:caps", -- ,grp:alts_toggle


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
    action = "workspace"
})

hl.config({
    cursor = {
        hide_on_key_press = true,
        hide_on_touch = true,
    },
})


