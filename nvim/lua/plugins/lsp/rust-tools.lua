return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        "simrat39/rust-tools.nvim", -- 🦀 Rust extras
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- 🦀 Rust (with rust-tools)
        local rt = require("rust-tools")
        rt.setup({
            tools = {
                inlay_hints = {
                    auto = true,             -- automatically show inlay hints
                    only_current_line = false,
                    show_parameter_hints = true,
                    parameter_hints_prefix = "<- ",
                    other_hints_prefix = "=> ",
                },
            },
            server = {
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = { allFeatures = true },
                        check = { command = "clippy" }, -- modern replacement for checkOnSave
                    },
                },
                on_attach = function(_, bufnr)
                    local opts = { buffer = bufnr }
                    vim.keymap.set("n", "<leader>rr", rt.runnables.runnables, opts)
                    vim.keymap.set("n", "<leader>rd", rt.debuggables.debuggables, opts)

                    -- optional: manual inlay hints control
                    vim.keymap.set("n", "<leader>rh", function()
                        require("rust-tools").inlay_hints.set()
                    end, opts)
                    vim.keymap.set("n", "<leader>rH", function()
                        require("rust-tools").inlay_hints.unset()
                    end, opts)
                end,
            },
        })
    end,
}

