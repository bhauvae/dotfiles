return {
  "3rd/image.nvim",
  build = false,
  ft = { "markdown", "html" }, -- only load for relevant filetypes
  opts = {
    processor = "magick_cli",

    -- backend: "kitty" is the best if you're on Kitty terminal
    backend = "kitty",

    -- tmux fixes
    tmux_show_only_in_active_window = true,

    -- clear images when editor loses focus
    editor_only_render_when_focused = true,

    -- prevent images rendering under popups like nvim-cmp
    window_overlap_clear_enabled = true,
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif" },

    integrations = {
      markdown = {
        enabled = true,
        -- only render image your cursor is on (better perf, less clutter)
        only_render_image_at_cursor = true,
        -- clear image when you enter insert mode (avoids overlap with typed text)
        clear_in_insert_mode = true,
        -- show images in floating markdown preview windows too
        floating_windows = true,
        -- look for images in these locations
        download_remote_images = true,
      },
      html = {
        enabled = false, -- enable if you edit HTML with images
      },
    },

    hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
  },
}
