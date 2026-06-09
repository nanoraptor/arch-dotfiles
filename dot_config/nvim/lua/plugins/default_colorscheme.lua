-- return {
--   -- Override LazyVim's colorscheme and configure tokyonight for transparency.
--   {
--     "folke/tokyonight.nvim",
--     lazy = false, -- Load this plugin immediately
--     priority = 1000, -- Ensure it loads before other themes
--     opts = {
--       style = "moon", -- The specific style you want
--       transparent = true, -- Enable overall transparency
--       styles = {
--         sidebars = "transparent", -- Make sidebars transparent
--         floats = "transparent", -- Make floating windows transparent
--       },
--     },
--     config = function(_, opts)
--       require("tokyonight").setup(opts)
--       vim.cmd.colorscheme("tokyonight-moon")
--     end,
--   },
--
--   -- Override LazyVim's default colorscheme setting.
--   -- This is important to ensure your theme is used.
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "tokyonight-moon",
--     },
--   },
-- }
-- return {
--   {
--     "catppuccin/nvim",
--     lazy = false,
--     priority = 1000,
--     opts = {
--       flavour = "mocha",
--       transparent_background = true,
--
--       integrations = {
--         neotree = true,
--         telescope = true,
--         notify = false,
--         mini = true,
--         snacks = true,
--       },
--       -- NEW: Custom Highlights to brighten line numbers
--       custom_highlights = function(colors)
--         return {
--           -- "LineNr" controls the relative/inactive line numbers.
--           -- "colors.overlay1" is brighter than the default "surface1".
--           LineNr = { fg = colors.overlay1 },
--
--           -- Optional: You can make the current line number ("CursorLineNr")
--           -- a specific color (like Lavender) if you want it to pop more.
--           CursorLineNr = { fg = colors.lavender, style = { "bold" } },
--         }
--       end,
--     },
--     config = function(_, opts)
--       require("catppuccin").setup(opts)
--       vim.cmd.colorscheme("catppuccin-mocha")
--
--       -- NUCLEAR OVERRIDE v3
--       -- Now targets Titles and Headers specifically
--       vim.api.nvim_create_autocmd("ColorScheme", {
--         pattern = "*",
--         callback = function()
--           local hl_groups = {
--             -- 1. Main Backgrounds
--             "Normal",
--             "NormalNC",
--             "NormalFloat",
--             "FloatBorder",
--
--             -- 2. Generic Titles (The "Files", "LICENSE", "Documents.iml" fix)
--             "FloatTitle",
--             "Title",
--
--             -- 3. Telescope Specific Titles
--             "TelescopeTitle",
--             "TelescopePromptTitle",
--             "TelescopePreviewTitle",
--             "TelescopeResultsTitle",
--             "TelescopeNormal",
--             "TelescopeBorder",
--
--             -- 4. Neo-tree Specific (The "Explorer" fix)
--             "NeoTreeNormal",
--             "NeoTreeNormalNC",
--             "NeoTreeTitleBar", -- Often responsible for the "Explorer" header
--             "NeoTreeFloatTitle",
--             "NeoTreeWinSeparator",
--             "NeoTreeEndOfBuffer",
--
--             -- 5. Snacks / Other
--             "SnacksDashboardNormal",
--             "SnacksDashboardHeader",
--             "WhichKeyFloat",
--           }
--
--           for _, name in ipairs(hl_groups) do
--             -- Force background to NONE for all these groups
--             vim.cmd(string.format("highlight %s ctermbg=NONE guibg=NONE", name))
--           end
--         end,
--       })
--
--       -- Force the update immediately
--       vim.cmd("doautocmd ColorScheme")
--     end,
--   },
--
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "catppuccin-mocha",
--     },
--   },
-- }
return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,

      integrations = {
        neotree = true,
        telescope = true,
        notify = false,
        mini = true,
        snacks = true,
      },
      -- NEW: Custom Highlights to brighten line numbers AND fix the StatusLine
      custom_highlights = function(colors)
        return {
          -- 1. Line Numbers (Your existing config)
          LineNr = { fg = colors.overlay1 },
          CursorLineNr = { fg = colors.lavender, style = { "bold" } },

          -- 2. STATUS LINE TINT (The Fix)
          -- transparent_background removes the bg by default. We force it back here.
          -- 'colors.mantle' is a dark tint slightly different from your terminal bg.
          -- You can try 'colors.crust' (darker) or 'colors.surface0' (lighter) if you prefer.
          StatusLine = {
            bg = colors.surface0,
          },
          StatusLineNC = {
            bg = colors.surface0,
          },
        }
      end,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-mocha")

      -- NUCLEAR OVERRIDE v3
      -- Now targets Titles and Headers specifically
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          local hl_groups = {
            -- 1. Main Backgrounds
            "Normal",
            "NormalNC",
            "NormalFloat",
            "FloatBorder",

            -- 2. Generic Titles
            "FloatTitle",
            "Title",

            -- 3. Telescope Specific Titles
            "TelescopeTitle",
            "TelescopePromptTitle",
            "TelescopePreviewTitle",
            "TelescopeResultsTitle",
            "TelescopeNormal",
            "TelescopeBorder",

            -- 4. Neo-tree Specific
            "NeoTreeNormal",
            "NeoTreeNormalNC",
            "NeoTreeTitleBar",
            "NeoTreeFloatTitle",
            "NeoTreeWinSeparator",
            "NeoTreeEndOfBuffer",

            -- 5. Snacks / Other
            "SnacksDashboardNormal",
            "SnacksDashboardHeader",
            "WhichKeyFloat",
          }

          for _, name in ipairs(hl_groups) do
            -- Force background to NONE for all these groups
            vim.cmd(string.format("highlight %s ctermbg=NONE guibg=NONE", name))
          end
        end,
      })

      -- Force the update immediately
      vim.cmd("doautocmd ColorScheme")
    end,
  },

  -- LazyVim Config
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },

  -- NEW: Lualine Configuration to create a Solid Bar
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Remove the "bubble" shapes to make it a solid bar
      -- opts.options.section_separators = ""
      -- opts.options.component_separators = "|"

      -- Ensure it uses the theme modifications we made above
      opts.options.theme = "catppuccin"
    end,
  },
}
