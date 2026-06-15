return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  opts = {
    legacy_commands = false,
    ui = {
      enable = false,
    },
    workspaces = {
      {
        name = "notes",
        path = "~/Documents/Notes/",
      },
    },
  },
}
