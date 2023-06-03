-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  "jreybert/vimagit",

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Wilder vim
{
  'gelguy/wilder.nvim',
  config = function()
    -- config goes here
  end,
},
  -- Startscreen
  {"mhinz/vim-startify"},

 { "startup-nvim/startup.nvim",
  dependencies = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"} },

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
 { 'VonHeikemen/lsp-zero.nvim', dependencies = {'neovim/nvim-lspconfig'} },
 {'williamboman/mason-lspconfig.nvim'},
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },
    {'hrsh7th/cmp-nvim-lsp'},     -- Required
    {'hrsh7th/cmp-buffer'},       -- Optional
    {'hrsh7th/cmp-path'},         -- Optional
    {'saadparwaiz1/cmp_luasnip'}, -- Optional
    {'hrsh7th/cmp-nvim-lua'},     -- Optional

  -- Snippets
    {'L3MON4D3/LuaSnip'},             -- Required
    {'rafamadriz/friendly-snippets'}, -- Optional


  -- Highlight colors inside of vim
   {'brenoprata10/nvim-highlight-colors'},

 -- Orgmode
   { 'nvim-orgmode/orgmode' },

  -- Save as sudo
   {'lambdalisue/suda.vim'},

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  { -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'iceberg'
    end,
  },

  { -- Some more themes
 -- 'cocopon/iceberg.vim',
  'phoenix988/iceberg.nvim',
  'rose-pine/neovim',
  'Mofiqul/dracula.nvim',
  'folke/tokyonight.nvim',
  'shaunsingh/nord.nvim',
  'ribru17/bamboo.nvim',
  },

  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'smartpde/telescope-recent-files'},
  { 'nvim-telescope/telescope-file-browser.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

 -- Harpoon
  { 'ThePrimeagen/harpoon' },
 -- Vifm file manager
  { 'vifm/vifm.vim' },
 -- Undotree to see history of a file
  { 'mbbill/undotree' },

 -- Neotree
  {'nvim-tree/nvim-web-devicons'},
  { 'nvim-neo-tree/neo-tree.nvim', dependencies = { "nvim-lua/plenary.nvim",
                                                    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
                                                    "MunifTanjim/nui.nvim", } },

  { 'nvim-tree/nvim-tree.lua' },



 -- Which key gives hint about keybindings
  { 'folke/which-key.nvim' },


 -- Barbar better tabs
  { 'romgrk/barbar.nvim', dependencies = { 'nvim-web-devicons' } },

 -- Lastplace remeber your last posisition
  {'ethanholz/nvim-lastplace'},

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ":TSUpdate",
  },

    {
      "kylechui/nvim-surround",
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
  },


}, {})
