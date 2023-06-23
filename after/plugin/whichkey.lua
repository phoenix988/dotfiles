local wk = require("which-key")

wk.register({
  f = {
    name = "Find Files", -- optional group name
    g = {"Grep for string"}
  },
  n = {
    name = "File Tree"
  },
  o = {
    name = "Org Mode"
  },


}, { prefix = "<leader>" })
