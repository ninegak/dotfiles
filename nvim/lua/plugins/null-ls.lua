return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls") -- still `null-ls` for compatibility

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier,
      },
    })

    vim.keymap.set("n", "<leader>p", function()
      vim.lsp.buf.format({ async = true })
    end, { noremap = true, silent = true })
  end,
}

