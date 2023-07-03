local wk = require("which-key")

wk.register({
  f = {
    name = "Find Files", -- optional group name
    g = {"Grep for string"},
    v = {"Built-in-explorer"},
  },
  n = {
    name = "File Tree"
  },
  o = {
    name = "Org Mode"
  },
  b = {
    name = "Buffers"
  },
  g = {
    name = "Git"
  },
  c = {
    name = "Color"
  },
  h = {
    name = "Help",
    s = {"Source-file"},
  },
  a = {
    name = "Add-Harpoon"
  },
  t = {
    name = "Tab"
  },

}, { prefix = "<leader>" })
