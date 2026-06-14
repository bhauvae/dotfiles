return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  opts = {
    legacy_commands = false,
    ui = {
      enable = true,
    },
    workspaces = {
      {
        name = "notes",
        path = "~/Documents/Notes/",
      },
    },
  },
}
