local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {
  {
    "lopi-py/luau-lsp.nvim",
    opts = function(_, opts)
      local neoconf = require "neoconf"
      neoconf.setup()

      local vs_settings = neoconf.get "vscode"
      if vs_settings and vs_settings["luau-lsp"] then
        local luau = vs_settings["luau-lsp"]

        local function camel_to_snake(camel)
          return camel:gsub("%u", "_%1"):lower()
        end

        local function convert_keys_to_snake_case(inputTable)
          local outputTable = {}
          for key, value in pairs(inputTable) do
            local snakeKey = camel_to_snake(key)
            outputTable[snakeKey] = value
          end
          return outputTable
        end

        if luau.types then
          opts.types = convert_keys_to_snake_case(luau.types)
        end

        if luau.fflags then
          opts.fflags = convert_keys_to_snake_case(luau.fflags)
        end

        if luau.sourcemap then
          opts.sourcemap = convert_keys_to_snake_case(luau.sourcemap)
        end

        opts.server = {
          settings = luau
        }
      end
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
