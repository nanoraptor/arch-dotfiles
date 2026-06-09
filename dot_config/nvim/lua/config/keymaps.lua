-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Move Lines (Removed '==' to stop auto-indenting)
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>", { desc = "Move Up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" }) -- Visual mode usually handles indent better, but you can remove '=gv' here too if needed
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

local map = vim.keymap.set

-- Set the group name for Which-Key
local wk = require("which-key")
wk.add({
  { "<leader>L", group = "LeetCode" },
})

-- Define the actual shortcuts
map("n", "<leader>Lh", "<cmd>Leet<cr>", { desc = "Dashboard" })
map("n", "<leader>Ll", "<cmd>Leet list<cr>", { desc = "List Problems" })
map("n", "<leader>Li", "<cmd>Leet info<cr>", { desc = "Problem info" })
map("n", "<leader>Ld", "<cmd>Leet desc<cr>", { desc = "Description Toggle" })
map("n", "<leader>Lt", "<cmd>Leet tabs<cr>", { desc = "Tabs" })
map("n", "<leader>Lr", "<cmd>Leet run<cr>", { desc = "Run Code" })
map("n", "<leader>Ls", "<cmd>Leet submit<cr>", { desc = "Submit Code" })
