return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        -- Keep all default blink.cmp behaviors active
        preset = "default",

        -- Bind Tab to accept the current suggestion instantly
        ["<Tab>"] = { "select_and_accept", "fallback" },

        -- Unbind Enter entirely so it only creates standard newlines
        ["<CR>"] = {},
      },
    },
  },
}
