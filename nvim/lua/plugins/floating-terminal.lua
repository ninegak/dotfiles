return {
    {
        dir = ".",
        name = "user/floating-terminal",
        lazy = false,
        config = function()
            vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>")

            local state = {
                floating = {
                    buf = -1,
                    win = -1,
                },
            }

            local function OpenFloatingWindow(opts)
                opts = opts or {}

                local ui = vim.api.nvim_list_uis()[1]
                local width = opts.width or math.floor(ui.width * 0.8)
                local height = opts.height or math.floor(ui.height * 0.8)
                local col = math.floor((ui.width - width) / 2)
                local row = math.floor((ui.height - height) / 2)

                local buf = state.floating.buf

                if buf == -1 or not vim.api.nvim_buf_is_valid(buf) then
                    buf = vim.api.nvim_create_buf(false, true)
                    vim.api.nvim_buf_call(buf, function()
                        vim.api.nvim_command("terminal zsh")
                    end)
                    state.floating.buf = buf
                end

                local win = vim.api.nvim_open_win(buf, true, {
                    relative = "editor",
                    width = width,
                    height = height,
                    col = col,
                    row = row,
                    style = "minimal",
                    border = "rounded",
                })

                vim.cmd("startinsert")

                state.floating.win = win
            end

            local function toggle_terminal()
                if not vim.api.nvim_win_is_valid(state.floating.win) then
                    OpenFloatingWindow()
                else
                    vim.api.nvim_win_hide(state.floating.win)
                end
            end

            vim.api.nvim_create_user_command("FloatTerminal", toggle_terminal, {})
            vim.keymap.set({ "n", "t" }, "<space>tm", toggle_terminal)
        end,
    },
}
