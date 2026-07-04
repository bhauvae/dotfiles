return {
  "folke/snacks.nvim",
  opts = {
    image = {},
    dashboard = {
      enabled = true,
      formats = {
        key = function(item)
          return {
            { "[", hl = "special" },
            { item.key, hl = "key" },
            { "]", hl = "special" },
          }
        end,
      },
      sections = {
        { section = "recent_files", limit = 5, padding = 1 },
        { title = "Sessions", padding = 1 },
        { section = "projects", padding = 1 },
        { title = "Bookmarks", padding = 1 },
        { section = "keys" },
      },
    },
  },
}
