return {
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline", -- use the bottom placement
      },
      views = {
        cmdline = {
          position = {
            row = -1, -- -1 means bottom of the screen
            col = "50%", -- center horizontally
          },
          size = {
            width = "100%",
            height = "auto",
          },
        },
      },
    },
  },
}
