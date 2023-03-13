local status_ok, cscope_maps = pcall(require, "cscope_maps")
if not status_ok then
  return
end

cscope_maps.setup({
  disable_maps = false, -- true disables my keymaps, only :Cscope will be loaded
  cscope = {
    db_file = "./cscope.out", -- location of cscope db file
  },
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
