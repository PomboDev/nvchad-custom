local M = {}

M.conform = {

}

M.lint = {
  
}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "luau",
    "c",
    "rust",
    "markdown",
    "markdown_inline",
  },
  indent = {
    enable = true,
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "luau-lsp",
    "stylua",

    -- c/cpp stuff
    "clangd",
    "clang-format",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = false,
      },
    },
  },
}

return M
