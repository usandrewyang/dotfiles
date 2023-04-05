require "user.impatient"
require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.autocommands"
require "user.colorscheme"
require "user.cmp"
require "user.telescope"
require "user.gitsigns"
require "user.treesitter"
require "user.treesitter-context"
require "user.autopairs"
require "user.comment"
require "user.nvim-tree"
require "user.bufferline"
require "user.auto-session" -- Save all open buffers as a session
require "user.lualine"

-- The following plugin will mess up the current working directory
-- which will cause cscope stops working.
-- require "user.project"

require "user.illuminate"
require "user.indentline"
require "user.alpha"

-- Note: Lsp conflicts with cscope
require "user.lsp"
-- require "user.dap"
require "user.cscope"
require "user.which-key"
require "user.wilder"

-- nvim-osc52
require "user.nvim-osc52"
require "user.diffview"

require "user.close-buffers"
require "user.git"
require "user.symbols-outline"

require "move"
