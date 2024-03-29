local status_ok, su = pcall(require, "nvim-search-and-replace")
if not status_ok then
    return
end

su.setup({
    -- file patters to ignore
    ignore = {'**/node_modules/**', '**/.git/**',  '**/.gitignore', '**/.gitmodules','build/**'},

    -- save the changes after replace
    update_changes = false,

    -- keymap for search and replace
    -- replace_keymap = '<leader>gr',

    -- keymap for search and replace ( this does not care about ignored files )
    -- replace_all_keymap = '<leader>gR',

    -- keymap for search and replace
    -- replace_and_save_keymap = '<leader>gu',

    -- keymap for search and replace ( this does not care about ignored files )
    -- replace_all_and_save_keymap = '<leader>gU',
})
