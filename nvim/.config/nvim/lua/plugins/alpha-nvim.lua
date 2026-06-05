return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-mini/mini.icons",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local theta = require("alpha.themes.theta")
    theta.header.val = {
      "neovim",
    }

    require("alpha").setup(theta.config)
  end,
}
