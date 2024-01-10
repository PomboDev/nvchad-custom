local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {
  {
    "lopi-py/luau-lsp.nvim",
    init = function()
      require("neoconf").setup()

      require("mason-lspconfig").setup_handlers {
        luau_lsp = function()
          require("luau-lsp.server").setup {
            filetypes = { "luau" },
            settings = {
              -- sourcemap = {
              --   enable = true, -- enable sourcemap generation
              --   autogenerate = true, -- auto generate sourcemap with rojo's sourcemap watcher
              -- },
              -- types = {
              --   roblox = true, -- enable roblox api
              -- },
            },
          }
        end,
      }
    end,
    opts = function (_, opts)
      
      opts.server = {
        root_dir = function()
          -- temporary solution
          return vim.loop.cwd()
        end,
        filetypes = { "luau" }, -- default is { "luau" }
        capabilities = vim.lsp.protocol.make_client_capabilities(), -- just an example
        settings = {
          ["luau-lsp"] = {
            completion = {
              imports = {
                enabled = true,
              },
            },
          },
        },
      }
    end,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "nvim-lua/plenary.nvim",
      "folke/neoconf.nvim",
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
    dependencies = {
      "lopi-py/luau-lsp.nvim",
    },
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    -- event = "BufWritePre"
    config = function()
      require "custom.configs.conform"
    end,
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        luau = { "selene" },
      },
    },
  },
}

return plugins
