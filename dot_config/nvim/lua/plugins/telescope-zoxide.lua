return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "jvgrootveld/telescope-zoxide",
  },
  keys = {
    { "<leader>fz", "<cmd>Telescope zoxide list<cr>", desc = "Zoxide" },
  },
  -- We use 'config' here to ensure the extension loads AFTER setup
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts) -- Load LazyVim's default Telescope options
    telescope.load_extension("zoxide") -- Load the extension
  end,
}
