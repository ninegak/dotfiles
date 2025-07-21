return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { hl = "GitGutterAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                    change = { hl = "GitGutterChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
                    delete = { hl = "GitGutterDelete", text = "-", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                    topdelete = { hl = "GitGutterDelete", text = "-", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                    changedelete = { hl = "GitGutterChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
                },
                current_line_blame = true,
                current_line_blame_opts = {
                    delay = 500,
                    virt_text_pos = 'eol', -- or 'right_align'
                },
            })
        end,
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "sindrets/diffview.nvim",
        },
        vim.keymap.set("n", "<leader>gl", "<cmd>Gitsigns blame_line<CR>")
    }
}

