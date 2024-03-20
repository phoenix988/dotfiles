local wk = require 'which-key'

-- Sets some Descriptions for keychords
wk.register({
  f = {
    name = 'Find Files', -- optional group name
    g = { 'Grep for string' },
    F = { 'Format file' },
  },
  n = {
    name = 'File Tree',
  },
  o = {
    name = 'Org Mode',
  },
  b = {
    name = 'Buffers',
  },
  g = {
    name = 'Git',
  },
  c = {
    name = 'Code',
  },
  h = {
    name = 'Help meny and Harpoon',
    s = { 'Source-file' },
  },
  t = {
    name = 'Tab',
  },
  p = {
    name = 'Project Harpoon',
  },
  s = {
    name = 'Sessions',
    m = { 'Session Meny' },
  },
  w = {
    name = 'Word Navigation',
  },
}, { prefix = '<leader>' })
