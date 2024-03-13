local wk = require 'which-key'

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
    name = 'Color',
  },
  h = {
    name = 'Help',
    s = { 'Source-file' },
  },
  t = {
    name = 'Tab',
  },
  p = {
    name = 'Project Harpoon',
  },
  s = {
    name = 'Session',
    m = { 'Session Meny' },
    c = { 'Change Current Word Globally' },
  },
}, { prefix = '<leader>' })
