local noice_setup = {}

function noice_setup.setup()
  require("noice").setup({
    -- Add any options here to customize Noice
    lsp = {
      progress = { enabled = true },
      override = {
        -- Override LSP functions to integrate with Noice
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = false, -- Use a classic bottom cmdline for search
      command_palette = true, -- Position the cmdline like a palette
      long_message_to_split = true, -- Long messages go into a split
      inc_rename = false, -- Disable inc_rename if not needed
      lsp_doc_border = true, -- Add a border to hover documentation
    },
  })
end

return noice_setup

