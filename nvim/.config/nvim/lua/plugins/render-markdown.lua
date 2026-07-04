return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-mini/mini.nvim",
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    preset = "lazy",
    latex = {
      enabled = true,
      inline = true,
      block = true,
      highlight = "RenderMarkdownMath",
      position = "center",
      top_pad = 0,
      bottom_pad = 0,
    },
  },
}
