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

-- Install plugins here
require('lazy').setup({

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {
    'NeogitOrg/neogit',
    config = true,
  },

  {
    'kdheepak/lazygit.nvim',
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },

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

  -- Buffer list
  'roblillack/vim-bufferlist',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Wilder vim
  {
    'gelguy/wilder.nvim',
    config = function()
      -- config goes here
    end,
  },
  -- Dashboard settings
  {
    'goolord/alpha-nvim', -- Using alpha as my dashboard
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    event = 'VimEnter',
    opts = function()
      local setlogo = require 'karl.dash'
      local dashboard = require 'alpha.themes.dashboard'
      local myConfig = '/home/karl/.config/nvim/init.lua'

      -- Import my custom function to set the logo
      local logo = setlogo()
      dashboard.section.header.val = vim.split(logo, '\n')
      dashboard.section.buttons.val = {
        dashboard.button('f', ' ' .. ' Find file', ':Telescope find_files <CR>'),
        dashboard.button('n', ' ' .. ' New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('r', ' ' .. ' Recent files', ':Telescope oldfiles <CR>'),
        dashboard.button('g', ' ' .. ' Find text', ':Telescope live_grep <CR>'),
        dashboard.button('c', ' ' .. ' Config', ':e' .. myConfig .. '<CR>'),
        dashboard.button('s', ' ' .. ' Restore Session', [[:LoadSession <cr>]]),
        dashboard.button('l', '󰒲 ' .. ' Lazy', ':Lazy<CR>'),
        dashboard.button('q', ' ' .. ' Quit', ':qa<CR>'),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = 'AlphaButtons'
        button.opts.hl_shortcut = 'AlphaShortcut'
      end
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'AlphaReady',
          callback = function()
            require('lazy').show()
          end,
        })
      end

      require('alpha').setup(dashboard.opts)

      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyVimStarted',
        callback = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = '⚡ Neovim loaded ' .. stats.count .. ' plugins in ' .. ms .. 'ms'
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  }, -- End of dashboard config

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  { 'VonHeikemen/lsp-zero.nvim',        dependencies = { 'neovim/nvim-lspconfig' } },
  { 'williamboman/mason-lspconfig.nvim' },
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',       opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },
  { 'hrsh7th/cmp-nvim-lsp' },     -- Required
  { 'hrsh7th/cmp-buffer' },       -- Optional
  { 'hrsh7th/cmp-path' },         -- Optional
  { 'saadparwaiz1/cmp_luasnip' }, -- Optional
  { 'hrsh7th/cmp-nvim-lua' },     -- Optional

  -- Snippets
  { 'L3MON4D3/LuaSnip' },             -- Required
  { 'rafamadriz/friendly-snippets' }, -- Optional
  -- End of Lsp configuration

  -- Highlight colors inside of vim
  { 'brenoprata10/nvim-highlight-colors' },

  -- Orgmode
  { 'nvim-orgmode/orgmode' },

  -- Save as sudo
  { 'lambdalisue/suda.vim' },

  { 'akinsho/toggleterm.nvim' },

  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',

    opts = {},
  },

  { -- Some more themes
    'navarasu/onedark.nvim',
    'phoenix988/iceberg.nvim',
    'rose-pine/neovim',
    'Mofiqul/dracula.nvim',
    'folke/tokyonight.nvim',
    'shaunsingh/nord.nvim',
    'ribru17/bamboo.nvim',
    'rmehri01/onenord.nvim',
    'catppuccin/nvim',
  },

  { 'zaldih/themery.nvim' },

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

  --{ -- Add indentation guides even on blank lines
  --  'lukas-reineke/indent-blankline.nvim',
  --  -- Enable `lukas-reineke/indent-blankline.nvim`
  --  -- See `:help indent_blankline.txt`
  --  opts = {
  --    char = '┊',
  --    show_trailing_blankline_indent = false,
  --  },
  --},

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',                      opts = {} },

  -- Quickly navigate files
  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim',              version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'smartpde/telescope-recent-files' },
  { 'nvim-telescope/telescope-file-browser.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

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

  -- Harpoon
  { 'ThePrimeagen/harpoon' },

  -- Vifm/yazi file manager
  { 'vifm/vifm.vim' },
  { 'DreamMaoMao/yazi.nvim' },

  -- Undotree to see history of a file
  { 'mbbill/undotree' },

  -- File Trees
  -- Neotree
  { 'nvim-tree/nvim-web-devicons' },
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim' },
  },
  -- Neovim tree
  { 'nvim-tree/nvim-tree.lua' },

  -- Which key gives hint about keybindings
  { 'folke/which-key.nvim' },

  -- Barbar better tabs
  { 'romgrk/barbar.nvim',      dependencies = { 'nvim-web-devicons' } },

  -- Lastplace remeber your last posisition
  { 'ethanholz/nvim-lastplace' },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  -- Vimwiki
  { 'chipsenkbeil/vimwiki.nvim' },

  -- nvim-compe lsp plugin
  { 'hrsh7th/nvim-compe' },

  -- None ls
  { 'nvimtools/none-ls.nvim' },

  -- Git copilot
  { 'github/copilot.vim' },

  -- Auto Sessions
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        auto_sessions_supress_dirs = { '~/', '~/Downloads', '~/Documents' },
        session_lents = {
          buftypes_to_ignore = {},
          load_on_setup = true,
          theme_conf = { border = true },
          previewer = false,
        },
      }
    end,
  },

  -- Oil
  { 'stevearc/oil.nvim' },

  -- Tmux navigator
  { 'christoomey/vim-tmux-navigator' },

  -- Silicon snapshot
  { 'michaelrommel/nvim-silicon',    lazy = true, cmd = 'Silicon' },

  -- DAP Debuggers
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'mfussenegger/nvim-dap-python',
    },
  },
}, {})
