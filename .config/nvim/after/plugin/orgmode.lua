-- Load custom treesitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop,
  -- highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    -- Required for spellcheck, some LaTex highlights and
    -- code block highlights that do not have ts grammar
    additional_vim_regex_highlighting = { 'org' },
  },
  ensure_installed = { 'org' }, -- Or run :TSUpdate org
}

require('orgmode').setup {
  org_agenda_files = { '~/Dropbox/org/*', '~/my-orgs/**/*' },
  org_default_notes_file = '~/Dropbox/org/refile.org',
}

require('neorg').setup {
  load = {
    ['core.defaults'] = {},  -- Loads default behaviour
    ['core.concealer'] = {}, -- Adds pretty icons to your documents
    ['core.dirman'] = {      -- Manages Neorg workspaces
      config = {
        workspaces = {
          notes = '~/notes',
        },
      },
    },
  },
}

-- Create tangle command for org files
function Tangle_files()
  -- Get the current buffer's path
  local current_file = vim.api.nvim_buf_get_name(0)

  -- Execute the org-babel-tangle command in Emacs
  local command = 'silent !emacsclient -e \'(org-babel-tangle-file "' .. current_file .. '")\''
  local match = string.match(current_file, 'org')

  if match == 'org' then
    print(current_file .. ' tangled')
    vim.api.nvim_command(command)
  else
    print(current_file .. ' is not an org document')
  end
end

-- Register the command
vim.cmd 'command! OrgTangle lua Tangle_files()'
