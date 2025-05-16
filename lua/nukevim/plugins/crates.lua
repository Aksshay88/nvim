-- crates.lua
local crates = require("crates")

crates.setup({
  null_ls = {
    enable = true,  -- Enable null-ls integration
    name = "crates.nvim"
  },
  -- You can add more configuration options here as needed
})

-- You can also set up additional keymaps here if you prefer
