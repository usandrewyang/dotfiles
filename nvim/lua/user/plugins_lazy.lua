-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    return
end

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

lazy.setup({
    -- My plugins here
    { "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" },  -- Useful lua functions used by lots of plugins
    { "windwp/nvim-autopairs", },  -- Autopairs, integrates with both cmp and treesitter
    { "numToStr/Comment.nvim", tag = "v0.7.0" },
    { "JoosepAlviste/nvim-ts-context-commentstring", commit = "32d9627123321db65a4f158b72b757bcaef1a3f4" },
    { "nvim-tree/nvim-web-devicons" },
    { "kyazdani42/nvim-tree.lua", commit = "7282f7de8aedf861fe0162a559fc2b214383c51c" },

    { "akinsho/bufferline.nvim", tag = "v4.3.0" },
    { "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" },
    { "nvim-lualine/lualine.nvim", commit = "a52f078026b27694d2290e34efa61a6e4a690621" },
    { "akinsho/toggleterm.nvim", commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda" },
    { "ahmedkhalf/project.nvim", commit = "628de7e433dd503e782831fe150bb750e56e55d6" },
    { "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" },
    { "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" },
    { "goolord/alpha-nvim", commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31" },

    -- Colorschemes
    { "folke/tokyonight.nvim", commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764" },
    { "lunarvim/darkplus.nvim", commit = "13ef9daad28d3cf6c5e793acfc16ddbf456e1c83" },

    -- cmp plugins
    { "hrsh7th/nvim-cmp", commit = "b0dff0ec4f2748626aae13f011d1a47071fe9abc" },         -- The completion plugin
    { "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" },       -- buffer completions
    { "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" },         -- path completions
    { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }, -- snippet completions
    { "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" },
    { "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" },

    -- snippets
    { "L3MON4D3/LuaSnip", commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84" },             --snippet engine
    { "rafamadriz/friendly-snippets", commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1" }, -- a bunch of snippets to use

    -- LSP
    -- use { "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" } -- simple to use language server installer
    { "neovim/nvim-lspconfig", commit = "f11fdff7e8b5b415e5ef1837bdcdd37ea6764dda" }, -- enable LSP
    { "williamboman/mason.nvim", commit = "bfc5997e52fe9e20642704da050c415ea1d4775f" },
    { "williamboman/mason-lspconfig.nvim", commit = "0eb7cfefbd3a87308c1875c05c3f3abac22d367c" },
    { "jose-elias-alvarez/null-ls.nvim", commit = "c0c19f32b614b3921e17886c541c13a72748d450" }, -- for formatters and linters
    { "RRethy/vim-illuminate", commit = "a2e8476af3f3e993bb0d6477438aad3096512e42" },
    {
      "j-hui/fidget.nvim",
      tag = "legacy",
      event = "LspAttach",
      opts = {
        -- options
      },
    },
    -- Telescope
    { "nvim-telescope/telescope.nvim", tag = "0.1.1", dependencies = { "nvim-lua/plenary.nvim" } },

    {
        "tom-anders/telescope-vim-bookmarks.nvim", commit = "92498cbf7c127dea37c3d27117b60dd7ab9baef4",
        dependencies = { { "MattesGroeger/vim-bookmarks", tag = "1.3.0" } }
    },

    -- Treesitter
    { "nvim-treesitter/nvim-treesitter", tag = "v0.9.0" },

    -- Git
    { "lewis6991/gitsigns.nvim", tag = "v0.6" },

    -- DAP
    -- { "mfussenegger/nvim-dap", commit = "6b12294a57001d994022df8acbe2ef7327d30587" },
    -- { "rcarriga/nvim-dap-ui", commit = "1cd4764221c91686dcf4d6b62d7a7b2d112e0b13" },
    -- { "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" },

    -- Cscope
    "dhananjaylatkar/cscope_maps.nvim",
    -- -- Which key
    "folke/which-key.nvim",

    "gelguy/wilder.nvim",    -- 更加智能的命令窗口
    "romgrk/fzy-lua-native", -- wilder.nvim 的依赖
    "rmagatti/auto-session", -- 打开 vim 的时候，自动回复上一次打开的样子

    -- clipboard support
    { "ojroques/nvim-osc52" },

    -- better diff
    -- { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },

    {"kazhala/close-buffers.nvim"},
    {"simrat39/symbols-outline.nvim"},
    -- { "dinhhuy258/git.nvim" },

    {"fedepujol/move.nvim"},
    { "kylechui/nvim-surround", tag = "v2.1.1" },-- Use for stability; omit to use `main` branch for the latest features

    -- highlight active window
    {
        "levouh/tint.nvim",
        config = function ()
            require('tint').setup()
        end
    },

    {
        "utilyre/barbecue.nvim",
        tag = "v1.2.0",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
    },
})

