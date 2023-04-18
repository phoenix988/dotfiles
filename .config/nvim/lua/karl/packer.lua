local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system{
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim", 
    install_path, 
    }
    print "Installing packer close and reopen Neovim..."
	vim.cmd([[packadd packer.nvim]])
end

vim.cmd [[
  augroup packer_user_config
    autocmd! 
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end  
]]




local status_ok, packer = pcall(require, "packer")
if not status_ok then 
    return
end    


-- Have Packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
       end,
    },
 }


return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

-- Install telescopes to navigate recentfiles and have a file explorer in vim
use {
   'nvim-telescope/telescope.nvim', tag = '0.1.1',
   requires = { {'nvim-lua/plenary.nvim'} }
}
use {"smartpde/telescope-recent-files"}
use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
}

-- Install prefefered colorschemes
use({ 'shaunsingh/nord.nvim', as = 'nord' })
use({ 'rose-pine/neovim', as = 'rose-pine' })

-- Tresitter to improve colors in your files
use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
use('nvim-treesitter/playground')

-- Harpoon to quickly navigate commonly used files
use('ThePrimeagen/harpoon')

use {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }


-- Vifm inside of vim
use("vifm/vifm.vim")

-- Whichkey to see all your keybinding when you press the leaderkey
-- Similar to emacs
use("folke/which-key.nvim")

-- Undotree to see what you have done to the file
use('mbbill/undotree')


use 'nvim-tree/nvim-web-devicons'

-- Tabs
 use {'romgrk/barbar.nvim', requires = 'nvim-web-devicons'}

-- Fancy status line for neovim
use {
  'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
}

-- Terminal for vim
use {"akinsho/toggleterm.nvim", tag = '*', config = function()
  require("toggleterm").setup()
end}

-- Lsp for neovim for autocompletion and alot of other things
use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v1.x',
  requires = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {                                      -- Optional
      'williamboman/mason.nvim',
      run = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},         -- Required
    {'hrsh7th/cmp-nvim-lsp'},     -- Required
    {'hrsh7th/cmp-buffer'},       -- Optional
    {'hrsh7th/cmp-path'},         -- Optional
    {'saadparwaiz1/cmp_luasnip'}, -- Optional
    {'hrsh7th/cmp-nvim-lua'},     -- Optional

    -- Snippets
    {'L3MON4D3/LuaSnip'},             -- Required
    {'rafamadriz/friendly-snippets'}, -- Optional
  }
}

-- Startscreen for neovim
use {
  'glepnir/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      -- config
    }
  end,
  requires = {'nvim-tree/nvim-web-devicons'}
}

-- Lastplace to remember old location since you left the file last time
use('ethanholz/nvim-lastplace')

-- Orgmode for neovim not as good as emacs though
use('nvim-orgmode/orgmode')

-- Highlight colors inside of vim
use('brenoprata10/nvim-highlight-colors')

-- git client for vim
use("jreybert/vimagit")
use('tpope/vim-fugitive')

-- Save files as sudo
use('lambdalisue/suda.vim')

if packer_bootstrap then
		packer.sync()
	end

end)
