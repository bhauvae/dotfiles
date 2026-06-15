return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    default = {
      -- KEY FIX: assets/ will be relative to the .md file, not nvim cwd
      relative_to_current_file = true,
      dir_path = "assets",

      -- keep extension and timestamp-based naming
      extension = "png",
      file_name = "%Y-%m-%d-%H-%M-%S",
      use_absolute_path = false,

      -- show the full assets path in the prompt so you know where it's saving
      prompt_for_file_name = true,
      show_dir_path_in_prompt = true, -- helpful for confirming the path

      -- template defaults (fine as-is)
      relative_template_path = true,
      use_cursor_in_template = true,
      insert_mode_after_paste = true,
      insert_template_after_cursor = true,

      -- copy pasted images into assets/ (important for non-clipboard sources)
      copy_images = true,
      download_images = true,

      -- optional: compress images on save (requires ImageMagick)
      -- process_cmd = "convert - -quality 85 -",

      -- drag and drop (works great on Hyprland/Wayland + Kitty)
      drag_and_drop = {
        enabled = true,
        insert_mode = false,
      },
    },

    filetypes = {
      markdown = {
        url_encode_path = true,
        template = "![$CURSOR]($FILE_PATH)",
        download_images = true,
      },
    },
  },
}
