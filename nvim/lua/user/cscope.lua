local status_ok, cscope_maps = pcall(require, "cscope_maps")
if not status_ok then
    return
end

-- print status_ok
-- vim.print(status_ok)
-- vim.print('test')

cscope_maps.setup({
  -- maps related defaults
  disable_maps = false, -- "true" disables default keymaps
  skip_input_prompt = false, -- "true" doesn't ask for input

  -- cscope related defaults
  cscope = {
    -- location of cscope db file
    db_file = "./cscope.out",
    -- cscope executable
    exec = "cscope", -- "cscope" or "gtags-cscope"
    -- choose your fav picker
    picker = "quickfix", -- "telescope", "fzf-lua" or "quickfix"
    -- "true" does not open picker for single result, just JUMP
    skip_picker_for_single_result = false, -- "false" or "true"
    -- these args are directly passed to "cscope -f <db_file> <args>"
    db_build_cmd_args = { "-bqkv" },
    -- statusline indicator, default is cscope executable
    statusline_indicator = nil,
  }
})
-- Cscope
-- Shorten function name
-- local keymap = vim.keymap.set
-- keymap("n", "<leader>cs", ":cs find s <C-R>=expand('<cword>')<CR><CR>", { silent = true })
-- keymap("n", "<leader>cg", ":cs find g <C-R>=expand('<cword>')<CR><CR>", { silent = true })
-- keymap("n", "<leader>cc", ":cs find c <C-R>=expand('<cword>')<CR><CR>", { silent = true})
-- keymap("n", "<leader>ct", ":cs find t <C-R>=expand('<cword>')<CR><CR>", { silent = true})
-- keymap("n", "<leader>ce", ":cs find e <C-R>=expand('<cword>')<CR><CR>", { silent = true})
-- keymap("n", "<leader>cf", ":cs find f <C-R>=expand('<cword>')<CR><CR>", { silent = true})
-- keymap("n", "<leader>ci", ":cs find i <C-R>=expand('<cword>')<CR><CR>", { silent = true})
-- keymap("n", "<leader>cd", ":cs find d <C-R>=expand('<cword>')<CR><CR>", { silent = true})
