-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	use("wbthomason/packer.nvim")

	use("nvim-lua/plenary.nvim") -- lua functions that many plugins use
	use("mbbill/undotree") -- lua functions that is used for the undotree plugin

use {
    "nvzone/typr",
    requires = { "nvzone/volt" },
    config = function()
    end,
    cmd = { "Typr", "TyprStats" }
}
    use({
  "jackMort/ChatGPT.nvim", -- ChatGPT plugin
  config = function()
    require("nukevim.plugins.chatgpt")
  end,
  requires = {
    "MunifTanjim/nui.nvim", -- UI components
    "nvim-lua/plenary.nvim", -- Common Lua functions
    "folke/trouble.nvim", -- Diagnostics list
    "nvim-telescope/telescope.nvim", -- Fuzzy finder integration
  },
})
    use {
  'xeluxee/competitest.nvim',
  requires = 'MunifTanjim/nui.nvim',
  config = function()
    require('competitest').setup()
  end
}
use {
    "nvimtools/none-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" }
}
use {'nvim-telescope/telescope-ui-select.nvim' }
use {'ThePrimeagen/harpoon' }
use({
    "kdheepak/lazygit.nvim",
    requires = {
        "nvim-lua/plenary.nvim",
    },
})
    use {
  'tpope/vim-dadbod',
  requires = {
    'kristijanhusak/vim-dadbod-ui', -- Optional UI for vim-dadbod
  },
  config = function()
    vim.g.dadbod_ui = 1  -- Enable the UI for vim-dadbod
    -- Set a default database connection (optional)
    -- vim.g.dadbod_connection = "postgresql://user:pass@localhost/dbname"
  end
}
    use({
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",  -- If you have `nvim-treesitter` installed
  requires = {
    "nvim-lua/plenary.nvim",  -- Required for functionality
    "MunifTanjim/nui.nvim",   -- Required for UI components
    "nvim-telescope/telescope.nvim", -- Required for the picker
  },
})
-- install without yarn or npm
use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
})

use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
use {
    'MeanderingProgrammer/render-markdown.nvim',
    requires = {
        { 'nvim-treesitter/nvim-treesitter' }, -- Required dependency
        { 'echasnovski/mini.nvim', opt = true }, -- Optional: mini.nvim suite
        { 'nvim-tree/nvim-web-devicons', opt = true }, -- Optional: icons support
    },
}
        use({
        "David-Kunz/gen.nvim",
        config = {
            showbar = true,
        },
    })

    use("rcarriga/nvim-notify") --nvim-notify

	use("ellisonleao/gruvbox.nvim")

	use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

	use("szw/vim-maximizer") --maximizes and restores current window

    use ("AlexvZyl/nordic.nvim")

    use("folke/tokyonight.nvim")
	-- essential plugins
	use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
    use("github/copilot.vim")
	use("inkarkat/vim-ReplaceWithRegister") -- replace with register contents using motion (gr + motion)

	use("numToStr/Comment.nvim") -- commenting with gc

	use("nvim-tree/nvim-tree.lua") -- file explorer

	use("nvim-tree/nvim-web-devicons") -- vs-code like icons

	use("nvim-lualine/lualine.nvim") -- lualine

	-- fuzzy finding w/ telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder
	use("BurntSushi/ripgrep")
	use("sharkdp/fd")


    use({"epwalsh/obsidian.nvim",
  tag = "*", -- Use the latest stable release
  requires = { "nvim-lua/plenary.nvim" }, -- Dependency
})
    use({
  "folke/noice.nvim",  -- Install Noice plugin
  event = "VimEnter",   -- Or use "VeryLazy" if you want lazy loading
  dependencies = {
    "MunifTanjim/nui.nvim",  -- Required for Noice
    "rcarriga/nvim-notify",  -- Optional, for notification support
  },
  config = function()
    require("nukevim.plugins.noice").setup()  -- Call the setup function for Noice
  end,
})

	--	 autocompletion
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system path

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- managing & installing lsp servers, linters & formatters
	use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	use("neovim/nvim-lspconfig") -- easily configure language servers
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	use({ "glepnir/lspsaga.nvim", branch = "main" })
	use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	-- formatting & linting
	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- treesitter configuration
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

	-- discord
	use("andweeb/presence.nvim")

	-- alpha
	use({
		"goolord/alpha-nvim",
		config = function()
			require("alpha").setup(require("alpha.themes.dashboard").config)
		end,
	})

	-- transparent BG
	use("xiyaowong/transparent.nvim")
    use("wakatime/vim-wakatime")

	-- weather
	use("bitspaceorg/weather-reporto.nvim")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
