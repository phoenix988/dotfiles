local lsp = require 'lsp-zero'

lsp.preset 'recommended'

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps { buffer = bufnr }
end)

require('mason').setup {}
require('mason-lspconfig').setup {
  ensure_installed = {'tsserver', 'eslint', 'lua_ls', 'ansiblels', 'bashls', 'yamlls', 'pylsp'},
  handlers = {
    lsp.default_setup,
  },
  opts = {
    auto_install = true,
  },
}

-- When you don't have mason.nvim installed
-- You'll need to list the servers installed in your system
lsp.setup_servers { 'tsserver', 'eslint', 'lua_ls', 'ansiblels', 'bashls', 'yamlls' }

lsp.set_preferences {
  sign_icons = {},
}

local cmp = require 'cmp'
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings {
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm { select = true },
  ['<C-Space>'] = cmp.mapping.complete(),
}

-- Nvim-cmp setup
cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
  }),
}

-- Code action
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

lsp.setup()



