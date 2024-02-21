function ColorMyPencils(color)
       color = color or "iceberg"
       vim.cmd.colorscheme(color)
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

require("nvim-highlight-colors").turnOff()
require("nvim-highlight-colors").turnOn()
require("nvim-highlight-colors").toggle()


ColorMyPencils()
