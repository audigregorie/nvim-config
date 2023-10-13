--[[
===================================================
==================== Init File ====================
--]]

-- ##### Globals ######
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- # Vimwiki #
vim.g.vimwiki_list = { { path = "~/vimwiki", syntax = "markdown", ext = ".md" } }
vim.g.mkdp_echo_preview_url = 0

-- ##### Plugins #####
-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

	-- # Git related plugins #
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	-- # Detect tabstop and shiftwidth automatically #
	"tpope/vim-sleuth",

	-- # LSP #
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
		},
	},

	-- # Nvim-cmp #
	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",

			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",

			-- Adds a number of user-friendly snippets
			"rafamadriz/friendly-snippets",
		},
	},

	-- # Shows available keybindings #
	{ "folke/which-key.nvim", opts = {} },

	-- # Git Signs #
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				vim.keymap.set(
					"n",
					"<leader>gp",
					require("gitsigns").prev_hunk,
					{ buffer = bufnr, desc = "[G]o to [P]revious Hunk" }
				)
				vim.keymap.set(
					"n",
					"<leader>gn",
					require("gitsigns").next_hunk,
					{ buffer = bufnr, desc = "[G]o to [N]ext Hunk" }
				)
				vim.keymap.set(
					"n",
					"<leader>ph",
					require("gitsigns").preview_hunk,
					{ buffer = bufnr, desc = "[P]review [H]unk" }
				)
			end,
		},
	},

	-- ## Colorschemes ##

	-- # Onedark #
	-- {
	-- 	-- Theme inspired by Atom
	-- 	"navarasu/onedark.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("onedark")
	-- 	end,
	-- },

	-- # Onedarkpro #
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
		config = function()
			vim.cmd.colorscheme("onedark")
		end,
	},

	-- # Electron #
	-- {
	-- 	"ivanlhz/vim-electron",
	-- 	priority = 1000, -- Ensure it loads first
	-- 	config = function()
	-- 		vim.cmd.colorscheme("electron")
	-- 	end,
	-- },

	-- # Tokyonight #
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("tokyonight")
	-- 	end,
	-- },

	-- # Catppuccin #
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("tokyonight")
	-- 	end,
	-- },

	-- # Lualine #
	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = false,
				-- theme = "tokyonight",
				-- theme = "electron",
				theme = "onedark",
				component_separators = "|",
				section_separators = "",
			},
		},
	},

	-- # Indent Blankline #
	{
		-- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help indent_blankline.txt`
		opts = {
			char = "┊",
			show_trailing_blankline_indent = false,
		},
	},

	-- # Comment #
	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	-- # Telescope #
	{
		-- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
	},

	-- # Treesitter #
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},

	-- # Dap #
	{
		-- Debug
		-- Shows how to use the DAP plugin to debug your code.
		-- Primarily focused on configuring the debugger for Go, but can
		-- be extended to other languages as well.
		-- NOTE: Yes, you can install new plugins here!
		"mfussenegger/nvim-dap",
		-- NOTE: And you can specify dependencies as well
		dependencies = {
			-- Creates a beautiful debugger UI
			"rcarriga/nvim-dap-ui",

			-- Installs the debug adapters for you
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",

			-- Add your own debuggers here
			"leoluz/nvim-dap-go",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("mason-nvim-dap").setup({
				-- Makes a best effort to setup the various debuggers with
				-- reasonable debug configurations
				automatic_setup = true,

				-- You can provide additional configuration to the handlers,
				-- see mason-nvim-dap README for more information
				handlers = {},

				-- You'll need to check that you have the required things installed
				-- online, please don't ask me how to install them :)
				ensure_installed = {
					-- Update this to ensure that you have the debuggers for the langs you want
					"delve",
				},
			})

			-- Basic debugging keymaps, feel free to change to your liking!
			vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
			vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
			vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
			vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>B", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Debug: Set Breakpoint" })

			-- Dap UI setup
			-- For more information, see |:help nvim-dap-ui|
			dapui.setup({
				-- Set icons to characters that are more likely to work in every terminal.
				--    Feel free to remove or use ones that you like more! :)
				--    Don't feel like these are good choices.
				icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
				controls = {
					icons = {
						pause = "⏸",
						play = "▶",
						step_into = "⏎",
						step_over = "⏭",
						step_out = "⏮",
						step_back = "b",
						run_last = "▶▶",
						terminate = "⏹",
						disconnect = "⏏",
					},
				},
			})

			-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
			vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close

			-- Install golang specific config
			require("dap-go").setup()
		end,
	},

	-- ##### Custom Plugins #####

	-- # Telescope File Browser #
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},

	-- # Autopairs #
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},

	-- # Browser Bookmarks #
	{
		"dhruvmanila/browser-bookmarks.nvim",
		version = "*",
		opts = {
			selected_browser = "brave",
		},
	},

	-- # Cheatsheet #
	{
		"doctorfree/cheatsheet.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			local ctactions = require("cheatsheet.telescope.actions")
			require("cheatsheet").setup({
				bundled_cheetsheets = {
					enabled = { "default", "lua", "markdown", "regex", "netrw", "unicode" },
					disabled = { "nerd-fonts" },
				},
				bundled_plugin_cheatsheets = {
					enabled = {
						"auto-session",
						"goto-preview",
						"octo.nvim",
						"telescope.nvim",
						"vim-easy-align",
						"vim-sandwich",
					},
					disabled = { "gitsigns" },
				},
				include_only_installed_plugins = true,
				telescope_mappings = {
					["<CR>"] = ctactions.select_or_fill_commandline,
					["<A-CR>"] = ctactions.select_or_execute,
					["<C-Y>"] = ctactions.copy_cheat_value,
					["<C-E>"] = ctactions.edit_user_cheatsheet,
				},
			})
		end,
	},

	-- # Colorizer #
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				tailwind = true,
				-- mode = "foreground",
				-- mode = "background",
				mode = "virtualtext",
			},
		},
	},

	-- # Neo-tree #
	{
		"nvim-neo-tree/neo-tree.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({})
		end,
	},

	-- # Neoclip #
	{
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("neoclip").setup()
		end,
	},

	-- # Prettier #
	{
		"MunifTanjim/prettier.nvim",
	},

	-- # Tailiscope (plugin for tailwind cheatsheet) #
	{
		"danielvolchek/tailiscope.nvim",
		-- If you have tailwind lsp you can setup on attach
		-- if client.name == "tailwindcss" then
		--   require('telescope').load_extension('tailiscope')
		--   vim.keymap.set("n", "<leader>fw", "<cmd>Telescope tailiscope<cr>")
	},

	-- # Tailwindcss Colorizer Cmp #
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		config = true,
	},

	-- # Trouble #
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
		},
	},

	-- # Vim Surround #
	{
		-- Vim-surround provides mappings to easily delete, change and add such surroundings in pairs
		-- ie. parentheses, brackets, quotes, XML tags, and more.
		"tpope/vim-surround",
	},
	--[[
	[ ysw' ] -- Surround a word with single quotes

	[ ys3w{ ] -- Surround 3 word with { Hello-World }

	[ ds" ] -- Delete surrounding double quotes "

	[ cs"' ] -- Change surrounding double quotes " to single quotes '

	[ cs"' ] -- "Hello" -> 'Hello'

	[ ds" ] -- "Hello" -> Hello

	[ ysiw' ] -- Hello -> 'Hello'

	[ ysiw{ ] -- Hello -> { Hello } World

	[ yss( ] -- Hello World -> ( Hello World )

	[ ysiw} ] -- Hello -> {Hello} World

	[ yss) ] -- Hello World -> (Hello World)

	[ vfec{} + Esc p ] -- props.name -> {} -> {props.name}
	--]]

	-- # Vim px to rem #
	{
		"Oldenborg/vim-px-to-rem",
		-- :Rem
	},

	-- # Null-ls #
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
		},
	},

	-- # Mason Null-ls #
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
	},

	-- # Vim Tmux Navigator #
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},

	-- # Lazygit #
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").load_extension("lazygit")
		end,
	},

	-- # Floaterm #
	{
		"voldikss/vim-floaterm",
	},

	-- # Toggleterm #
	{
		"akinsho/toggleterm.nvim",
		version = "",
		config = true,
	},

	-- # Transparent #
	{
		"xiyaowong/transparent.nvim",
	},

	-- # Telescope UI Select #
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},

	-- # Firenvim #
	{
		-- nvim embedded in the browser
		"glacambre/firenvim",

		-- Lazy load firenvim
		-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
		lazy = not vim.g.started_by_firenvim,
		build = function()
			vim.fn["firenvim#install"](0)
		end,
	},

	-- # Rest #
	{
		-- Rest api
		"rest-nvim/rest.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("rest-nvim").setup({
				-- Open request results in a horizontal split
				result_split_horizontal = false,
				-- Keep the http file buffer above|left when split horizontal|vertical
				result_split_in_place = false,
				-- Skip SSL verification, useful for unknown certificates
				skip_ssl_verification = false,
				-- Encode URL before making request
				encode_url = true,
				-- Highlight request on run
				highlight = {
					enabled = true,
					timeout = 150,
				},
				result = {
					-- toggle showing URL, HTTP info, headers at top the of result window
					show_url = true,
					-- show the generated curl command in case you want to launch
					-- the same request via the terminal (can be verbose)
					show_curl_command = false,
					show_http_info = true,
					show_headers = true,
					-- executables or functions for formatting response body [optional]
					-- set them to false if you want to disable them
					formatters = {
						json = "jq",
						html = function(body)
							return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
						end,
					},
				},
				-- Jump to request line on run
				jump_to_request = false,
				env_file = ".env",
				custom_dynamic_variables = {},
				yank_dry_run = true,
			})
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "http",
				callback = function()
					local buff = tonumber(vim.fn.expand("<abuf>"), 10)
					vim.keymap.set("n", "<leader>rn", require("rest-nvim").run, { noremap = true, buffer = buff })
					vim.keymap.set("n", "<leader>rl", require("rest-nvim").last, { noremap = true, buffer = buff })
					vim.keymap.set("n", "<leader>rp", function()
						require("rest-nvim").run(true)
					end, { noremap = true, buffer = buff })
				end,
			})
		end,
	},
	-- oil
	-- (Edit file explorer in neovim buffer)
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- # Chatgpt #
	-- {
	-- Needs credit card
	-- 	"jackMort/ChatGPT.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("chatgpt").setup({
	-- 			api_key_cmd = "pass show openai",
	-- 		})
	-- 	end,
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 	},
	-- },
}, {})

-- ##### Options #####
-- See :help options
vim.opt.autoindent = true
vim.opt.laststatus = 2
vim.opt.shell = "zsh"
-- vim.opt.title = true
vim.opt.backspace = { "indent", "eol", "start" } -- allows <backspace> to function as we expect
vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 0 -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
-- vim.opt.fileencoding = "UTF-8"                   -- the encoding written to a file
-- vim.opt.fillchars = 'eob: ' -- Remove "~" from empty lines
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.iskeyword:append("-") -- hyphenated words recognized by searches
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.showmode = false -- hide -- NORMAL --  -- INSERT --, mode
vim.opt.showtabline = 0 -- always show tabs
vim.opt.background = "dark"
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion (4000ms default)
vim.opt.writebackup = false -- if a file is being edited or was written to file with another program, it is not allowed to be edited
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.cursorline = true -- highlight the current line
vim.opt.cursorlineopt = "number"
vim.opt.number = true -- set numbered lines
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.numberwidth = 1 -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = true -- display lines as one long line
vim.opt.linebreak = true -- companion to wrap, don't split words
vim.opt.scrolloff = 15 -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 10 -- minimal number of screen columns either side of cursor if wrap is `false`
-- vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.whichwrap = "bs<>[]hl" -- which "horizontal" keys are allowed to travel to prev/next line
-- vim.opt.guicursor = "" -- guicursor as a block instead of a line
vim.opt.shortmess:append("c") -- don't give |ins-completion-menu| messages
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- don't insert the current comment leader automatically for...
-- ...auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.

-- ##### Keymaps #####
-- See `:help vim.keymap.set()`
-- Remap space key as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- -- Remap write file (save)
-- vim.keymap.set("n", ":w", ":update<CR>")
--
-- -- Remap write file and quit
-- vim.keymap.set("n", ":wq", ":wq<CR>")
--
-- -- Remap quit
-- vim.keymap.set("n", ":q", ":q<CR>")
--
-- -- Remap force quit
-- vim.keymap.set("n", ":q!", ":q!<CR>")

-- Remap to go into normal mode
vim.keymap.set("i", "jk", "<ESC>") -- 'jk' to go into normal mode
vim.keymap.set("i", "kj", "<ESC>") -- 'kj' to go into normal mode

--
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap to delete character without clipboard copying
vim.keymap.set("n", "x", '"_x')

-- Remap to clear highlight from search
vim.keymap.set("n", "<leader>nh", ":nohl<CR>")

-- Remap split windows vertically and horizontally
vim.keymap.set("n", "<leader>|", "<C-w>v")
vim.keymap.set("n", "<leader>_", "<C-w>s")

-- Remap close current split
vim.keymap.set("n", "<leader>x", ":close<CR>")

-- Remap to move highlighted text up and down
vim.keymap.set("v", "<S-j>", ":m '>+1<CR>gv-gv")
vim.keymap.set("v", "<S-k>", ":m '<-2<CR>gv-gv")

-- Remap to indent and outdent lines or blocks of code
vim.keymap.set("n", "<Tab>", ">>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", "<<", { noremap = true, silent = true })
vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

-- Remap paste last thing yanked not deleted
vim.keymap.set("n", "<,p>", "0p", { noremap = true, silent = true })

-- Rempa to jump up and down while keeping the cursor in the center of the screen
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })

-- Highlight over and paste while keeping yanked item
vim.keymap.set("x", "<leader>p", '"_dP', { noremap = true, silent = true })

-- Setting "Q" to nothing, dangerous button
vim.keymap.set("n", "Q", "<nop>")

-- Next and previous buffer
vim.keymap.set("n", "<leader>[", ":bprevious<CR>")
vim.keymap.set("n", "<leader>]", ":bnext<CR>")

vim.keymap.set("n", "gx", ":!open <c-r><c-a><CR>")

-- Keep cursor in the center of the scrren
vim.api.nvim_set_keymap("n", "<Leader>zz", [[:let &scrolloff=999-&scrolloff<CR>]], { noremap = true, silent = true })

-- ##### Augroups #####
-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- ##### Configure Plugins #####
-- # Configure Telescope #
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
	defaults = {
		layout_strategy = "vertical",
		layout_config = { height = 0.95, width = 0.6, prompt_position = "top" },
		mappings = {
			i = {
				["<C-u>"] = require("telescope.actions").preview_scrolling_up, -- scroll up in preview
				["<C-d>"] = require("telescope.actions").preview_scrolling_down, -- scroll down in preview
				["<C-k>"] = require("telescope.actions").move_selection_previous, -- move to prev result
				["<C-j>"] = require("telescope.actions").move_selection_next, -- move to next result
				["<C-/>"] = require("telescope.actions").which_key, -- which key cheatsheet
				["<C-x>"] = require("telescope.actions").delete_buffer, -- delete buffer
				-- ['<C-|>'] = require('telescope.actions').select_horizontal(), -- open selected file in a horzontal split
				-- ['<C-_>'] = require('telescope.actions').select_vertical(), -- open selected file in a vertical split
			},
			n = {
				["<C-u>"] = require("telescope.actions").preview_scrolling_up, -- scroll up in preview
				["<C-d>"] = require("telescope.actions").preview_scrolling_down, -- scroll down in preview
				["k"] = require("telescope.actions").move_selection_previous, -- move to prev result
				["j"] = require("telescope.actions").move_selection_next, -- move to next result
				["<C-/>"] = require("telescope.actions").which_key, -- which key cheatsheet
				["<C-x>"] = require("telescope.actions").delete_buffer, -- delete buffer
				["gg"] = require("telescope.actions").move_to_top, -- move to the top of the page
				["G"] = require("telescope.actions").move_to_bottom, -- move to the bottom of the page
				-- ['<C-|>'] = require('telescope.actions').select_horizontal(), -- open selected file in a horizontal split
				-- ['<C-_>'] = require('telescope.actions').select_vertical(), -- open selected file in a vertical split
			},
		},
	},
	pickers = {
		find_files = {
			-- theme = "ivy",
		},
		buffer = {
			sort_mru = true,
		},
		grep_string = {
			word_match = "-w",
		},
	},
	extensions = {
		file_browser = {
			-- theme = "ivy",
			mappings = {
				i = {
					["<C-n>"] = require("telescope._extensions.file_browser.actions").create,
					["<C-t>"] = require("telescope._extensions.file_browser.actions").rename,
					["<C-l>"] = require("telescope._extensions.file_browser.actions").change_cwd,
					["<C-h>"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
					["<C-.>"] = require("telescope._extensions.file_browser.actions").toggle_hidden,
					["<C-x>"] = require("telescope._extensions.file_browser.actions").remove,
					-- ['<C-|>'] = require('telescope.actions').select_horizontal(), -- open selected file in a horizontal split
					-- ['<C-_>'] = require('telescope.actions').select_vertical(), -- open selected file in a vertical split
				},
				n = {
					["<C-n>"] = require("telescope._extensions.file_browser.actions").create,
					["<C-t>"] = require("telescope._extensions.file_browser.actions").rename,
					["l"] = require("telescope._extensions.file_browser.actions").change_cwd,
					["h"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
					["<C-.>"] = require("telescope._extensions.file_browser.actions").toggle_hidden,
					["<C-x>"] = require("telescope._extensions.file_browser.actions").remove,
					-- ['<C-|>'] = require('telescope.actions').select_horizontal(), -- open selected file in a horizontal split
					-- ['<C-_>'] = require('telescope.actions').select_vertical(), -- open selected file in a vertical split
				},
			},
		},
		bookmarks = {
			selected_browser = "brave",
			-- full_path = false,
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				-- even more opts
			}),
		},
	},
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- Enable telescope ui select
pcall(require("telescope").load_extension("ui-select"))

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>bb", require("telescope.builtin").buffers, { desc = "[S]earch [B]uffers" })
vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })
vim.keymap.set("n", "<leader>qf", require("telescope.builtin").quickfix, { desc = "[Q]uick [F]ix" })

pcall(require("telescope").load_extension("file_browser"))
vim.keymap.set("n", "<leader>ff", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

pcall(require("telescope").load_extension("neoclip"))
vim.keymap.set("n", "<leader>nc", ":Telescope neoclip<CR>")

pcall(require("telescope").load_extension("bookmarks"))
vim.keymap.set("n", "<leader>bm", ":Telescope bookmarks<CR>")

pcall(require("telescope").load_extension("cheatsheet"))
vim.keymap.set("n", "<leader>ch", ":Cheatsheet<CR>")

pcall(require("telescope").load_extension("tailiscope"))
vim.keymap.set("n", "<leader>tw", ":Telescope tailiscope<CR>")

pcall(require("telescope").load_extension("lazygit"))
vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>")

-- # Configure Treesitter #
-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup({
	autotag = {
		enable = true,
		enable_rename = true,
		enable_close = true,
		enable_close_on_slash = true,
		filetypes = { "html", "xml" },
	},

	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = {
		"markdown",
		"c",
		"cpp",
		"go",
		"http",
		"lua",
		"python",
		"rust",
		"tsx",
		"typescript",
		"vimdoc",
		"vim",
		"css",
		"html",
		"javascript",
		"json",
	},

	-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
	auto_install = false,

	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<M-space>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	},
})

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- # Configure LSP #
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	-- nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
	angularls = {},
	cssls = {
		settings = {
			css = {
				validate = true,
				lint = {
					unknownAtRules = "ignore",
				},
			},
			scss = {
				validate = true,
				lint = {
					unknownAtRules = "ignore",
				},
			},
			less = {
				validate = true,
				lint = {
					unknownAtRules = "ignore",
				},
			},
		},
	},
	emmet_language_server = {},
	emmet_ls = {},
	html = { filetypes = { "html", "twig", "hbs" } },
	jsonls = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
	pyright = {},
	tailwindcss = {
		settings = {
			css = {
				validate = true,
				lint = {
					unknownAtRules = "ignore",
				},
			},
			scss = {
				validate = true,
				lint = {
					unknownAtRules = "ignore",
				},
			},
			less = {
				validate = true,
				lint = {
					unknownAtRules = "ignore",
				},
			},
		},
	},
	tsserver = {},
	vimls = {},
}

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		})
	end,
})

-- # Configure Nvim-cmp #
-- See `:help cmp`
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp", priority = 1000 }, -- lsp
		{ name = "luasnip", priority = 750 }, -- snippets
		{ name = "path", priority = 250 }, -- file system

		-- { name = "nvim_lsp", priority = 1000 }, -- lsp
		-- { name = "luasnip", priority = 750 }, -- snippets
		-- { name = "buffer", priority = 500 }, -- text within current buffer
		-- { name = "path", priority = 250 }, -- file system paths
	},
})

-- # Configrue Prettier #
local prettier = require("prettier")
--
prettier.setup({
	bin = "prettier", -- or `'prettierd'` (v0.23.3+)
	filetypes = {
		"css",
		"graphql",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"less",
		-- "markdown",
		"scss",
		"typescript",
		"typescriptreact",
		"yaml",
	},
	-- cli_options = {
	-- 	arrow_parens = "always",
	-- 	bracket_spacing = true,
	-- 	bracket_same_line = true,
	-- 	embedded_language_formatting = "auto",
	-- 	html_whitespace_sensitivity = "css",
	-- 	end_of_line = "lf",
	-- 	print_width = 160,
	-- 	prose_wrap = "preserve",
	-- 	quote_props = "as-needed",
	-- 	semi = false,
	-- 	single_attribute_per_line = true,
	-- 	single_quote = true,
	-- 	tab_width = 2,
	-- 	trailing_comma = "none",
	-- 	use_tabs = false,
	-- 	vue_indent_script_and_style = false,
	-- 	config_precedence = "prefer-file",
	-- },
	-- 	["null-ls"] = {
	-- 		condition = function()
	-- 			return prettier.config_exists({
	-- 				-- if `false`, skips checking `package.json` for `"prettier"` key
	-- 				check_package_json = true,
	-- 			})
	-- 		end,
	-- 		runtime_condition = function(params)
	-- 			-- return false to skip running prettier
	-- 			return true
	-- 		end,
	-- 		timeout = 5000,
	-- 	},
})

-- # Configure Mason Null-ls #
-- IS NOT WORKING!!!
require("mason-null-ls").setup({
	ensure_installed = { "prettierd", "stylua", "jq" },
	automatic_installation = true,
})

-- # Configure Null-ls #
local null_ls = require("null-ls")

-- local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
-- local event = "BufWritePre" -- or "BufWritePost"
-- local async = event == "BufWritePost"

null_ls.setup({
	-- on_attach = function(client, bufnr)
	-- 	if client.supports_method("textDocument/formatting") then
	-- 		vim.keymap.set("n", "<Leader>f", function()
	-- 			vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
	-- 		end, { buffer = bufnr, desc = "[lsp] format" })
	--
	-- 		-- 		-- format on save
	-- 		vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
	-- 		vim.api.nvim_create_autocmd(event, {
	-- 			buffer = bufnr,
	-- 			group = group,
	-- 			callback = function()
	-- 				vim.lsp.buf.format({ bufnr = bufnr, async = async })
	-- 			end,
	-- 			desc = "[lsp] format on save",
	-- 		})
	-- 	end
	--
	-- 	if client.supports_method("textDocument/rangeFormatting") then
	-- 		vim.keymap.set("x", "<Leader>f", function()
	-- 			vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
	-- 		end, { buffer = bufnr, desc = "[lsp] format" })
	-- 	end
	-- end,
	sources = {
		-- null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.prettier.with({
			filetypes = { "html", "json", "yaml", "javascript", "typescript", "css", "sass", "scss" },
		}),
		null_ls.builtins.formatting.stylua,
	},
})
-- Format on save
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

-- ## Colorscheme Loader ##
-- setup must be called before loading
-- vim.cmd([[colorscheme onedark]])
-- vim.cmd([[colorscheme tokyonight]])
-- vim.cmd([[colorscheme electron]])
-- vim.cmd([[colorscheme catppuccin]])

-- # Configure Colorscheme Tokyonight #
-- require("tokyonight").setup({
--   style = "storm",
-- })

-- # Configure Colorscheme Catccuppin #
-- require("catppuccin").setup({
-- 	flavour = "frappe", -- latte, frappe, macchiato, mocha
-- 	background = { -- :h background
-- 		-- light = "latte",
-- 		-- dark = "mocha",
-- 	},
-- 	transparent_background = false, -- disables setting the background color.
-- })

-- # Configure Trouble #
vim.keymap.set("n", "<leader>xx", function()
	require("trouble").open()
end)
vim.keymap.set("n", "<leader>xw", function()
	require("trouble").open("workspace_diagnostics")
end)
vim.keymap.set("n", "<leader>xd", function()
	require("trouble").open("document_diagnostics")
end)
vim.keymap.set("n", "<leader>xf", function()
	require("trouble").open("quickfix")
end)
vim.keymap.set("n", "<leader>xl", function()
	require("trouble").open("loclist")
end)
vim.keymap.set("n", "gR", function()
	require("trouble").open("lsp_references")
end)

-- # Configure Toggleterm #
local toggleterm = require("toggleterm")

toggleterm.setup({
	-- size can be a number or function which is passed the current terminal
	size = 40,
	open_mapping = [[<c-\>]],
	hide_numbers = true, -- hide the number column in toggleterm buffers
	direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
	close_on_exit = true, -- close the terminal window when the process exits
	float_opts = {
		border = "curved", -- 'single' | 'double' | 'shadow' | 'curved' |
	},
})

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "kj", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _lazygit_toggle()
	lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

-- # Configure Browser Bookmarks #
vim.keymap.set("n", "<leader>bm", require("browser_bookmarks").select, {
	desc = "Fuzzy search browser bookmarks",
})

-- # Configure Oil (File explorer) #
require("oil").setup({
	win_options = {
		signcolumn = "yes",
	},
	-- keymaps = {
	--    ["g?"] = "actions.show_help",
	--    ["<CR>"] = "actions.select",
	--    ["<C-s>"] = "actions.select_vsplit",
	--    ["<C-h>"] = "actions.select_split",
	--    ["<C-t>"] = "actions.select_tab",
	--    ["<C-p>"] = "actions.preview",
	--    ["<C-c>"] = "actions.close",
	--    ["<C-l>"] = "actions.refresh",
	--    ["-"] = "actions.parent",
	--    ["_"] = "actions.open_cwd",
	--    ["`"] = "actions.cd",
	--    ["~"] = "actions.tcd",
	--    ["gs"] = "actions.change_sort",
	--    ["gx"] = "actions.open_external",
	--    ["g."] = "actions.toggle_hidden",
	--  },
	keymaps = {
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<C-5>"] = "actions.select_vsplit",
		["<C-7"] = "actions.select_split",
		["<C-t>"] = "actions.select_tab",
		["<C-p>"] = "actions.preview",
		["<C-c>"] = "actions.close",
		["<C-n>"] = "actions.refresh",
		["<C-h>"] = "actions.parent",
		["_"] = "actions.open_cwd",
		["`"] = "actions.cd",
		["~"] = "actions.tcd",
		["gs"] = "actions.change_sort",
		["gx"] = "actions.open_external",
		["g."] = "actions.toggle_hidden",
	},
	use_default_keymaps = false,
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- vim.keymap.set("n", "<C-m>", "<CMD>Oil<CR>", { desc = "Open parent directory" })
