return {
  "CRAG666/code_runner.nvim",
  config = function()
    require("code_runner").setup({
      -- This is the key setting for Code Runner specifically
      startinsert = true,

      filetype = {
        python = "cd $dir && python3 -u $fileName",
        java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
      },
      float = {
        border = "rounded",
        -- ... rest of your visual settings
      },
    })

    -- Keymaps
    vim.keymap.set("n", "<leader>r", ":w | RunFile <CR>", { desc = "Run File" })
  end,
}
