-- Init Lua filE

-- ========================================
-- # CONFIGURE GLOBALS
-- ========================================
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
-- Sets <space> as the global leader key for general mappings
vim.g.mapleader = " "
-- Sets <space> as the local leader key for buffer-local mappings
vim.g.maplocalleader = " "

-- Configure undotree plugin settings
vim.g.undotree_WindowLayout = 2       -- Sets the layout of the undotree window
vim.g.undotree_SplitWidth = 35        -- Sets the width of the undotree window
vim.g.undotree_SetFocusWhenToggle = 1 -- Focuses the undotree window when toggled
vim.g.undotree_DiffpanelHeight = 25   -- Sets the height of the diff panel in the undotree window

-- Disable automatic embedding of taskpipe plugin
vim.g.tpipeline_autoembed = 0


-- ========================================
-- # CONFIGURE PLUGINS
-- ========================================
-- Install package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		-- latest stable release
		"--branch=stable",
		lazypath,
	})
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
	-- ## CONFIGURE COLORSCHEMES
	-- Vydark
	-- {
	-- 	"vyshane/vydark-vim-color",
	-- 	config = function()
	-- 		vim.cmd [[colorscheme vydark]]
	-- 	end
	-- },

	-- Monochrome
	-- {
	-- 	'kdheepak/monochrome.nvim',
	-- 	config = function()
	-- 		vim.cmd [[colorscheme monochrome]]
	-- 	end
	-- },

	-- Vscode
	-- {
	-- 	"Mofiqul/vscode.nvim",
	-- 	name = "vscode",
	-- 	-- priority = 1000,
	-- 	config = function()
	-- 		vim.cmd [[colorscheme vscode]]
	-- 	end
	-- },	

	-- Arctic (vscode)
	-- {
	-- 	"rockyzhang24/arctic.nvim",
	-- 	dependencies = { "rktjmp/lush.nvim" },
	-- 	name = "arctic",
	-- 	-- priority = 1000,
	-- 	config = function()
	-- 		vim.cmd [[colorscheme arctic]]
	-- 	end
	-- },

	-- Onedark
	-- {
	-- 	"navarasu/onedark.nvim",
	-- 	name = "onedark",
	-- 	-- Ensure it loads first
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd [[colorscheme onedark]]
	-- 	end,
	-- },

	-- Onedarkpro
	-- {
	-- 	"olimorris/onedarkpro.nvim",
	-- 	name = "onedarkpro",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd [[colorscheme onedark]]
	-- 	end,
	-- },

	-- Electron
	-- {
	-- 	"ivanlhz/vim-electron",
	-- 	name = "electron",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd [[colorscheme electron]]
	-- 	end,
	-- },

	-- Tokyonight
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	name = "tokyonight",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd [[colorscheme tokyonight]]
	-- 	end,
	-- },

	-- Catppuccin
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd [[colorscheme catppuccin]]
	-- 	end,
	-- },

	-- Nightfox
	-- {
	-- 	"EdenEast/nightfox.nvim",
	-- 	name = "nightfox",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd [[colorscheme nightfox]]
	-- 	end,
	-- },

	-- Nordic
	-- {
	-- 	"AlexvZyl/nordic.nvim",
	-- 	name = "nordic",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd [[colorscheme nordic]]
	-- 	end,
	-- },

	-- Tokyodark
	-- {
	-- 	"tiagovla/tokyodark.nvim",
	-- 	opts = {
	-- 		-- custom options here
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("tokyodark").setup(opts) -- calling setup is optional
	-- 		vim.cmd [[colorscheme tokyodark]]
	-- 	end,
	-- },


	-- Nvim-tree
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			vim.g.loaded_netrw = 1                  -- Disable netrw at the very start of your init.lua
			vim.g.loaded_netrwPlugin = 1            -- Disable netrwPlugin at the very start of your init.lua
			vim.g.nvim_tree_highlight_opened_files = 1 -- Enable highlighting of opened files in nvim-tree
			vim.g.nvim_tree_highlight_modified = 1  -- Enable highlighting of modified files in nvim-tree

			-- Standard left positioned nvim-tree window
			require("nvim-tree").setup({
				diagnostics = {
					enable = true,
					show_on_dirs = true,
					icons = {
						hint = "",
						info = "",
						warning = "",
						error = "",
					},
				},
				sort_by = "case_sensitive",
				view = {
					width = 55,
					-- relativenumber = true,
					-- side = "left",
					side = "right",
					signcolumn = "yes",
				},
				log = {
					enable = true,
					truncate = true,
					types = {
						diagnostics = true,
					},
				},
				actions = {
					open_file = {
						quit_on_open = true,
					},
				},
				renderer = {
					group_empty = true,
					root_folder_label = ":~:s?$?/..?",
					indent_width = 2,
					special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
					symlink_destination = true,
					highlight_git = false,
					highlight_diagnostics = true,
					highlight_opened_files = "name",
					highlight_modified = "none",
					highlight_bookmarks = "none",
					highlight_clipboard = "none",
					indent_markers = {
						enable = true,
						inline_arrows = true,
						icons = {
							-- corner = "└",
							corner = " ",
							edge = "│ ",
							item = "│ ",
							-- bottom = "─",
							bottom = " ",
							none = " ",
						},
					},
					icons = {
						web_devicons = {
							file = {
								enable = true,
								color = true,
							},
							folder = {
								enable = true,
								color = true,
							},
						},
						show = {
							file = true,
							folder = true,
							folder_arrow = true,
							git = true,
							modified = true,
							diagnostics = true,
							bookmarks = true,
						},
						glyphs = {
							default = "",
							symlink = "",
							bookmark = "󰆤",
							modified = "●",
							folder = {
								arrow_closed = "",
								-- arrow_closed = "●",
								arrow_open = "",
								-- arrow_open = "○",
								default = "",
								-- open = "",
								open = "",
								-- empty = "",
								empty = "○",
								empty_open = "",
								symlink = "",
								symlink_open = "",
							},
						},
					},
				},
				filters = {
					-- show hidden files using 'shift + h'
					dotfiles = false,
				},
			})
			vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Open Nvim Tree" })
		end,
	},


	-- LSP
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim",       tag = "legacy", opts = {} },
			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
		},
		config = function()
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
				nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
				nmap("<leader>gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				nmap("<leader>td", vim.lsp.buf.type_definition, "Type [D]efinition")
				nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols,
					"[D]ocument [S]ymbols")
				nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols,
					"[W]orkspace [S]ymbols")
				-- See `:help K` for why this keymap
				nmap("<leader>sd", vim.lsp.buf.signature_help, "Signature Documentation")
				nmap("<leader>hd", vim.lsp.buf.hover, "Hover Documentation")
				-- nmap("K", vim.lsp.buf.signature_help, "Signature Documentation")
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

			-- Change the Diagnostic symbols in the sign column (gutter)
			-- (not in youtube nvim video)
			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			--  Add any additional override configuration in the following tables. They will be passed to
			--  the `settings` field of the server config. You must look up that documentation yourself.
			--
			--  If you want to override the default filetypes that your language server will attach to you can
			--  define the property 'filetypes' to the map in question.
			local servers = {
				angularls = {
					cmd = { "ngserver", "--stdio", "--tsProbeLocations", "", "--ngProbeLocations", "" },
					filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
				},
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
						-- Disable missing fields warning messages
						diagnostics = { disable = "missing-fields" },
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
				tsserver = {
					cmd = { "typescript-language-server", "--stdio" },
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
					},
				},
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
		end,
	},



	-- Treesitter
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		config = function()
			-- See `:help nvim-treesitter`
			require("nvim-treesitter.configs").setup({
				-- Add languages to be installed here that you want installed for treesitter
				ensure_installed = {
					"markdown",
					"c",
					"cpp",
					"go",
					"http",
					"lua",
					"xml",
					"http",
					"json",
					"graphql",
					"python",
					"rust",
					"tsx",
					"typescript",
					"vimdoc",
					"vim",
					"css",
					"html",
					"javascript",
				},
				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,
				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = false,
				-- List of parsers to ignore installing (or "all")
				ignore_install = {},
				modules = {},
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
				autotag = {
					enable = true,
					enable_rename = true,
					enable_close = true,
					enable_close_on_slash = true,
					filetypes = { "html", "xml" },
				},
				textobjects = {
					select = {
						enable = true,
						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,
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
						-- whether to set jumps in the jumplist
						set_jumps = true,
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
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,
				{ desc = "Go to previous diagnostic message" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
			vim.keymap.set("n", "<leader>r", vim.diagnostic.open_float,
				{ desc = "Open floating diagnostic message" })
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
		end,
	},


	-- Nvim-cmp
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
		config = function()
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
				completion = { completeopt = "menu,menuone,noinsert", },
				mapping = cmp.mapping.preset.insert({
					-- ["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					-- ["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true, }),
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
					{ name = "nvim_lsp" },
					{ name = "codeium" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "buffer", },
				},
				-- formatting = {
				-- 	format = require('lspkind').cmp_format({
				-- 		mode = "symbol",
				-- 		maxwidth = 50,
				-- 		ellipsis_char = '...',
				-- 		symbol_map = { Codeium = "", }
				-- 	})
				-- }
			})
		end,
	},


	-- Tailwindcss Colorizer Cmp
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		dependencies = { "hrsh7th/nvim-cmp" },
		config = true,
	},


	-- Null-ls
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim", },
		config = function()
			-- Load null-ls
			local null_ls = require("null-ls")

			-- Configure null-ls
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettier.with({
						-- Conditionally enable Prettier formatting based on the presence of .prettierrc file
						condition = function(utils)
							return utils.root_has_file({ ".prettierrc" })
						end,
					}),
				},
			})

			-- Apply formatting on save
			vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
		end,
	},


	-- Mason Null-ls
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason.nvim", "jose-elias-alvarez/null-ls.nvim", },
		config = function()
			-- Load mason-null-ls and configure it
			require("mason-null-ls").setup({
				-- Ensure the specified language servers are installed
				ensure_installed = { "prettier", "stylua", "jq" },
				-- Automatically install missing language servers
				automatic_installation = true,
			})
		end,
	},


	-- Vim-commentary
	{
		"tpope/vim-commentary",
		-- Keymaps :
		-- [ gcc ] to comment out a line in one go
		-- [ gcap ] to comment out a paragraph
	},


	-- Autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},


	-- Trouble	
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {},
		config = function()
			local trouble = require("trouble")

			-- Key mapping to open trouble
			vim.keymap.set("n", "<leader>xx", function()
				trouble.open()
			end)

			-- Key mapping to open workspace diagnostics
			vim.keymap.set("n", "<leader>xw", function()
				trouble.open("workspace_diagnostics")
			end)

			-- Key mapping to open document diagnostics
			vim.keymap.set("n", "<leader>xd", function()
				trouble.open("document_diagnostics")
			end)

			-- Key mapping to open quickfix
			vim.keymap.set("n", "<leader>xf", function()
				trouble.open("quickfix")
			end)

			-- Key mapping to open location list
			vim.keymap.set("n", "<leader>xl", function()
				trouble.open("loclist")
			end)

			-- Key mapping to open LSP references
			vim.keymap.set("n", "gR", function()
				trouble.open("lsp_references")
			end)
		end,
	},


	-- Lualine
	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		opts = {
			-- theme = "tokyonight",
			-- theme = "electron",
			-- theme = "ayu_mirage",
			-- theme = "onedark",
		},
		config = function()
			local function getShitDone()
				return [[Get Shit Done.]]
			end

			local function pipe()
				return [[ | ]]
			end

			local colors = {
				blue   = '#80a0ff',
				cyan   = '#79dac8',
				black  = '#080808',
				white  = '#c6c6c6',
				red    = '#ff5189',
				violet = '#d183e8',
				-- grey   = '#303030',
				tan    = '#D2B48C',
				grey   = '#1C1C1C',
			}

			local bubbles_theme = {
				normal = {
					a = { fg = colors.black, bg = colors.tan },
					b = { fg = colors.white, bg = colors.grey },
					c = { fg = colors.white },
				},
				insert = { a = { fg = colors.black, bg = colors.blue } },
				visual = { a = { fg = colors.black, bg = colors.cyan } },
				replace = { a = { fg = colors.black, bg = colors.red } },
				inactive = {
					a = { fg = colors.white, bg = colors.black },
					b = { fg = colors.white, bg = colors.black },
					c = { fg = colors.white },
				},
			}

			require("lualine").setup({
				options = {
					theme = bubbles_theme,
					icons_enabled = true,
					-- component_separators = "|",
					component_separators = " ",
					section_separators = { left = '', right = '' },
					-- section_separators = { left = "", right = "" },
					-- section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = false,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "diff", { pipe }, "diagnostics" },
					lualine_c = { '%=', "branch", "filename" },
					-- lualine_x = { { getShitDone }, "encoding", "fileformat", "filetype" },
					lualine_x = { "rest" },
					lualine_y = { { getShitDone }, "progress" },
					-- lualine_y = { { getShitDone }, "encoding", "fileformat", "filetype", "progress" },
					-- lualine_z = { "location" },
					lualine_z = {
						{ 'location', separator = { right = '' }, left_padding = 2 },
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			})
		end,
	},


	-- Git related plugins
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-rhubarb" },


	-- Detect tabstop and shiftwidth automatically
	{ "tpope/vim-sleuth" },


	-- Git Signs
	{
		-- Plugin for git related signs and utilities
		"lewis6991/gitsigns.nvim",
		opts = {
			-- Configuration options for git signs
			signs = {
				add = { text = "+" }, -- Sign for added lines
				change = { text = "~" }, -- Sign for changed lines
				delete = { text = "_" }, -- Sign for deleted lines
				topdelete = { text = "‾" }, -- Sign for top-deleted lines
				changedelete = { text = "~" }, -- Sign for changed/deleted lines
			},
			-- Function to attach gitsigns key mappings
			on_attach = function(bufnr)
				-- Key mapping to go to previous hunk
				vim.keymap.set(
					"n",
					"<leader>gp",
					require("gitsigns").prev_hunk,
					{ buffer = bufnr, desc = "[G]o to [P]revious Hunk" }
				)
				-- Key mapping to go to next hunk
				vim.keymap.set(
					"n",
					"<leader>gn",
					require("gitsigns").next_hunk,
					{ buffer = bufnr, desc = "[G]o to [N]ext Hunk" }
				)
				-- Key mapping to preview hunk
				vim.keymap.set(
					"n",
					"<leader>ph",
					require("gitsigns").preview_hunk,
					{ buffer = bufnr, desc = "[P]review [H]unk" }
				)
			end,
		},
	},


	-- Indent Blankline
	{
		-- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		opts = { char = "│", show_trailing_blankline_indent = false, },
	},


	-- Shows available keybindings
	{ "folke/which-key.nvim",          opts = {} },


	-- Telescope
	{
		-- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system requirements installed.
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- NOTE: If you are having trouble with this installation,
				-- refer to the README for telescope-fzf-native for more instructions.
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		config = function()
			require("telescope").setup({
				defaults = {
					layout_strategy = "vertical",
					layout_config = {
						height = 0.95,
						width = 0.6,
						prompt_position = "top",
						mirror = true,
					},
					mappings = {
						i = {
							["<C-u>"] = require("telescope.actions").preview_scrolling_up, -- scroll up in preview
							["<C-d>"] = require("telescope.actions").preview_scrolling_down, -- scroll down in preview
							["<C-k>"] = require("telescope.actions").move_selection_previous, -- move to prev result
							["<C-j>"] = require("telescope.actions").move_selection_next, -- move to next result
							["<C-;>"] = require("telescope.actions").which_key,        -- which key cheatsheet
							["<C-x>"] = require("telescope.actions").delete_buffer,    -- delete buffer
							-- ['<C-|>'] = require('telescope.actions').select_horizontal(), -- open selected file in a horzontal split
							-- ['<C-_>'] = require('telescope.actions').select_vertical(), -- open selected file in a vertical split
						},
						n = {
							["<C-u>"] = require("telescope.actions").preview_scrolling_up, -- scroll up in preview
							["<C-d>"] = require("telescope.actions").preview_scrolling_down, -- scroll down in preview
							["k"] = require("telescope.actions").move_selection_previous, -- move to prev result
							["j"] = require("telescope.actions").move_selection_next, -- move to next result
							["<C-;>"] = require("telescope.actions").which_key,       -- which key cheatsheet
							["<C-x>"] = require("telescope.actions").delete_buffer,   -- delete buffer
							["gg"] = require("telescope.actions").move_to_top,        -- move to the top of the page
							["G"] = require("telescope.actions").move_to_bottom,      -- move to the bottom of the page
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
						-- theme = "dropdown",
						-- layout_strategy = "horizontal",
						-- layout_config = { height = 0.7, width = 0.8, prompt_position = "bottom" },
						mappings = {
							i = {
								["<C-n>"] = require("telescope._extensions.file_browser.actions").create,
								["<C-r>"] = require("telescope._extensions.file_browser.actions").rename,
								["<C-l>"] = require("telescope._extensions.file_browser.actions").change_cwd,
								["<C-h>"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
								["<C-.>"] = require("telescope._extensions.file_browser.actions").toggle_hidden,
								["<C-x>"] = require("telescope._extensions.file_browser.actions").remove,
								-- ['<C-|>'] = require('telescope.actions').select_horizontal(), -- open selected file in a horizontal split
								-- ['<C-_>'] = require('telescope.actions').select_vertical(), -- open selected file in a vertical split
							},
							n = {
								["<C-n>"] = require("telescope._extensions.file_browser.actions").create,
								["<C-r>"] = require("telescope._extensions.file_browser.actions").rename,
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

			-- See `:help telescope.builtin`
			vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles,
				{ desc = "[?] Find recently opened files" })
			vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers,
				{ desc = "[ ] Find existing buffers" })

			-- You can pass additional configuration to telescope to change theme, layout, etc.
			vim.keymap.set("n", "<leader>/",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find(require(
						"telescope.themes").get_dropdown({
						winblend = 10, previewer = false, }))
				end, { desc = "[/] Fuzzily search in current buffer" })

			vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files,
				{ desc = "Search [G]it [F]iles" })
			vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files,
				{ desc = "[F]ind [F]iles" })
			vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags,
				{ desc = "[F]ind [H]elp" })
			vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string,
				{ desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep,
				{ desc = "[F]ind by [G]rep" })
			vim.keymap.set("n", "<leader>wd", require("telescope.builtin").diagnostics,
				{ desc = "[W]orkspace [D]iagnostics" })
			vim.keymap.set("n", "<leader>sb", require("telescope.builtin").buffers,
				{ desc = "[S]earch [B]uffers" })
			vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols,
				{ desc = "[D]ocument [S]ymbols" })
			vim.keymap.set("n", "<leader>qf", require("telescope.builtin").quickfix,
				{ desc = "[Q]uick [F]ix" })
			vim.keymap.set("n", "<leader>gb", require("telescope.builtin").git_bcommits,
				{ desc = "[G]it [B]commits" })

			-- Enable telescope fzf native, if installed
			pcall(require("telescope").load_extension, "fzf")

			-- Enable telescope ui select
			pcall(require("telescope").load_extension("ui-select"))

			-- File browser
			pcall(require("telescope").load_extension("file_browser"))
			vim.keymap.set("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

			-- Yank registry
			pcall(require("telescope").load_extension("neoclip"))
			vim.keymap.set("n", "<leader>nc", ":Telescope neoclip<CR>")

			-- Cheatsheet of commands
			pcall(require("telescope").load_extension("cheatsheet"))
			vim.keymap.set("n", "<leader>ch", ":Cheatsheet<CR>")

			-- Tailwind CSS guide
			pcall(require("telescope").load_extension("tailiscope"))
			vim.keymap.set("n", "<leader>tw", ":Telescope tailiscope<CR>")

			-- -- Git UI
			-- pcall(require("telescope").load_extension("lazygit"))
			-- vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>")
		end,
	},


	-- // Telescope File Browser
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},


	-- // Tailiscope (plugin for tailwind cheatsheet)
	{ "danielvolchek/tailiscope.nvim", },


	-- // Cheatsheet
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

			-- Setup cheatsheet.nvim
			require("cheatsheet").setup({
				bundled_cheetsheetse = {
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
	}
	,


	-- // Telescope UI Select
	{ "nvim-telescope/telescope-ui-select.nvim", },


	-- Oil file manager
	-- {
	-- 	'stevearc/oil.nvim',
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- 	config = function()
	-- 		require("oil").setup()
	-- 		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	-- 	end
	-- },


	-- // Neoclip
	{
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("neoclip").setup()
		end,
	},


	-- -- Lazygit
	-- {
	-- 	"kdheepak/lazygit.nvim",
	-- 	dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", },
	-- 	config = function()
	-- 		require("telescope").load_extension("lazygit")
	-- 	end,
	-- },


	--  Colorizer
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


	--  Vim Surround
	{
		-- Vim-surround provides mappings to easily delete, change and add such surroundings in pairs
		-- ie. parentheses, brackets, quotes, XML tags, and more.
		"tpope/vim-surround",
		-- Keymaps :
		-- [ ysw' ]  Surround a word with single quotes
		-- [ ys3w{ ]  Surround 3 word with { Hello-World }
		-- [ ds" ]  Delete surrounding double quotes "
		-- [ cs"' ]  Change surrounding double quotes " to single quotes '
		-- [ cs"' ]  "Hello" -> 'Hello'
		-- [ ds" ]  "Hello" -> Hello
		-- [ ysiw' ]  Hello -> 'Hello'
		-- [ ysiw{ ]  Hello -> { Hello } World
		-- [ yss( ]  Hello World -> ( Hello World )
		-- [ ysiw} ]  Hello -> {Hello} World
		-- [ yss) ]  Hello World -> (Hello World)
		-- [ vfec{} + Esc p ]  props.name -> {} -> {props.name}
	},


	{
		-- // Vim convert between px and rem
		"Oldenborg/vim-px-to-rem",
		-- Keymaps :
		-- :Rem
		-- :Px
	},


	-- // Vim Tmux Navigator
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},


	-- // Toggleterm
	{
		"akinsho/toggleterm.nvim",
		version = "",
		config = function()
			local toggleterm = require("toggleterm")

			toggleterm.setup({
				size = 40,
				open_mapping = [[<c-\>]],
				hide_numbers = true,
				direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
				close_on_exit = true,
				float_opts = {
					border = "curved", -- 'single' | 'double' | 'shadow' | 'curved' |
				},
			})

			-- local Terminal = require("toggleterm.terminal").Terminal
			-- local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

			-- function _lazygit_toggle()
			-- 	lazygit:toggle()
			-- end

			-- vim.api.nvim_set_keymap(
			-- 	"n",
			-- 	"<leader>lg",
			-- 	"<cmd>lua _lazygit_toggle()<CR>",
			-- 	{ noremap = true, silent = true }
			-- )
		end,
	},


	-- // Transparent
	{ "xiyaowong/transparent.nvim", },


	-- // Firenvim
	{
		-- nvim embedded in the browser
		-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
		"glacambre/firenvim",
		-- Lazy load firenvim
		lazy = not vim.g.started_by_firenvim,
		build = function()
			vim.fn["firenvim#install"](0)
		end,
	},


	-- // Lsp_lines
	{
		-- Shows errors
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()

			-- Disable virtual_text since it's redundant due to lsp_lines.
			vim.diagnostic.config({
				virtual_text = false,
			})
		end,
	},


	-- // Chatgpt
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


	-- // Startup
	-- {
	-- 	"startup-nvim/startup.nvim",
	-- 	requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		require("startup").setup({ theme = "startify" })
	-- 	end,
	-- },


	-- // MarkdownHeaders
	{
		"AntonVanAssche/md-headers.nvim",
		version = "*",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter", },
		config = function()
			require("md-headers").setup({
				width = 90,
				height = 30,
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				popup_auto_close = true,
			})

			-- Shorten function name.
			local keymap = vim.keymap.set

			-- Silent keymap option.
			local opts = { silent = true }

			-- Set keymap.
			keymap("n", "<leader>mh", "<cmd>MarkdownHeaders<CR>", opts)
		end,
	},


	-- Nvim-dap Debugger
	{
		'mfussenegger/nvim-dap',
		dependencies = {
			-- Creates a beautiful debugger UI
			'rcarriga/nvim-dap-ui',

			-- Installs the debug adapters for you
			'williamboman/mason.nvim',
			'jay-babu/mason-nvim-dap.nvim',

			-- Add your own debuggers here
			'leoluz/nvim-dap-go',
		},
		config = function()
			local dap = require 'dap'

			local dapui = require 'dapui'

			require('mason-nvim-dap').setup {
				automatic_setup = true,
				handlers = {},
				ensure_installed = {
					-- Update this to ensure that you have the debuggers for the langs you want
					'delve',
				},
			}

			-- Basic debugging keymaps, feel free to change to your liking!
			vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
			vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
			vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
			vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
			vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
			vim.keymap.set('n', '<leader>B', function()
				dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
			end, { desc = 'Debug: Set Breakpoint' })

			-- Dap UI setup
			-- For more information, see |:help nvim-dap-ui|
			dapui.setup {
				-- Set icons to characters that are more likely to work in every terminal.
				icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
				controls = {
					icons = {
						pause = '⏸',
						play = '▶',
						step_into = '⏎',
						step_over = '⏭',
						step_out = '⏮',
						step_back = 'b',
						run_last = '▶▶',
						terminate = '⏹',
						disconnect = '⏏',
					},
				},
			}

			-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
			vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

			dap.listeners.after.event_initialized['dapui_config'] = dapui.open
			dap.listeners.before.event_terminated['dapui_config'] = dapui.close
			dap.listeners.before.event_exited['dapui_config'] = dapui.close

			-- Install golang specific config
			require('dap-go').setup()
		end,
	},


	-- // Undo Tree
	{ "mbbill/undotree", },


	-- // Rainbow Brackets
	{
		"HiPhish/rainbow-delimiters.nvim",
		config = function()
			require('rainbow-delimiters.setup').setup {
				blacklist = { 'html' },
				highlight = {
					'RainbowDelimiterRed',
					'RainbowDelimiterYellow',
					'RainbowDelimiterBlue',
					'RainbowDelimiterOrange',
					'RainbowDelimiterGreen',
					'RainbowDelimiterViolet',
					'RainbowDelimiterCyan',
				},
			}
		end
	},


	-- // Codeium AI
	{
		"Exafunction/codeium.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp", },
		config = function()
			require("codeium").setup({})
		end
	},


	-- Codesnap (Code screenshot)
	{
		"mistricky/codesnap.nvim",
		lazy = true,
		build = "make",
		cmd = { "CodeSnap", "CodeSnapSave" },
		config = function()
			require("codesnap").setup({
				save_path = "~",
				watermark = "",
				-- bg_theme = "grape"
			})
		end
	},


	---- // Rest Api
	--{
	--	"vhyrro/luarocks.nvim",
	--	priority = 1000,
	--	config = true,
	--},
	--{
	--	"rest-nvim/rest.nvim",
	--	ft = "http",
	--	dependencies = { "luarocks.nvim" },
	--	config = function()
	--		require("rest-nvim").setup({
	--			client = "curl",
	--			env_file = ".env",
	--			env_pattern = "\\.env$",
	--			env_edit_command = "tabedit",
	--			encode_url = true,
	--			skip_ssl_verification = false,
	--			custom_dynamic_variables = {},
	--			logs = {
	--				level = "info",
	--				save = true,
	--			},
	--			result = {
	--				split = {
	--					horizontal = false,
	--					in_place = false,
	--					stay_in_current_window_after_split = true,
	--				},
	--				behavior = {
	--					decode_url = true,
	--					show_info = {
	--						url = true,
	--						headers = true,
	--						http_info = true,
	--						curl_command = true,
	--					},
	--					statistics = {
	--						enable = true,
	--						---@see https://curl.se/libcurl/c/curl_easy_getinfo.html
	--						stats = {
	--							{ "total_time",      title = "Time taken:" },
	--							{ "size_download_t", title = "Download size:" },
	--						},
	--					},
	--					formatters = {
	--						json = "jq",
	--						html = function(body)
	--							if vim.fn.executable("tidy") == 0 then
	--								return body, { found = false, name = "tidy" }
	--							end
	--							local fmt_body = vim.fn.system({
	--								"tidy",
	--								"-i",
	--								"-q",
	--								"--tidy-mark", "no",
	--								"--show-body-only", "auto",
	--								"--show-errors", "0",
	--								"--show-warnings", "0",
	--								"-",
	--							}, body):gsub("\n$", "")

	--							return fmt_body, { found = true, name = "tidy" }
	--						end,
	--					},
	--				},
	--			},
	--			highlight = {
	--				enable = true,
	--				timeout = 750,
	--			},
	--			---Example:
	--			---```lua
	--			---keybinds = {
	--			---  { ---    "<localleader>rr", "<cmd>Rest run<cr>", "Run request under the cursor", ---  },
	--			---  { ---    "<localleader>rl", "<cmd>Rest run last<cr>", "Re-run latest request", ---  },
	--			---}
	--			---```
	--			---@see vim.keymap.set
	--			keybinds = {
	--				vim.keymap.set("n", "<leader>rr", "<cmd>RestRun<cr>", { noremap = true }),
	--				vim.keymap.set("n", "<leader>rl", "<cmd>RestRunLast<cr>", { noremap = true }),
	--			},
	--		})
	--	end,
	--},


	{
		'MunifTanjim/prettier.nvim',
		config = function()
			require("prettier").setup({
				cli_options = {
					print_width = 120,
					semi = false,
					single_quote = true,
					tab_width = 2,
				},
			})
		end
	},


	-- // Headlines for Markdown
	{
		"lukas-reineke/headlines.nvim",
		config = function()
			vim.cmd [[highlight Headline1 guifg=#d78700]]
			vim.cmd [[highlight Headline2 guifg=#87afff]]
			vim.cmd [[highlight Headline3 guifg=#d75f87]]
			vim.cmd [[highlight CodeBlock guibg=#101010]]

			require("headlines").setup {
				markdown = {
					headline_highlights = { "Headline1", "Headline2", "Headline3" },
					fat_headlines = false,
					bullets = "",
				},
			}
		end
	},


	-- // Harpoon
	-- {
	-- 	"ThePrimeagen/harpoon",
	-- 	branch = "harpoon2",
	-- 	requires = { { "nvim-lua/plenary.nvim" } },
	-- },


	-- LASTPLUGIN
}, {})


-- ========================================
-- # CONFIGURE OPTIONS
-- ========================================
-- See :help options
vim.opt.autoindent = true                        -- Enable auto-indentation.
vim.opt.laststatus = 2                           -- Set laststatus to always show statusline.
vim.opt.shell = "zsh"                            -- Set shell to use zsh.
vim.opt.title = true                             -- Enable window title manipulation.
vim.opt.backspace = { "indent", "eol", "start" } -- allows <backspace> to function as we expect
vim.opt.backup = false                           -- creates a backup file
vim.opt.clipboard = "unnamedplus"                -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1                            -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" }  -- mostly just for cmp
vim.opt.conceallevel = 0                         -- 0 is so that `` is visible in markdown files
-- vim.opt.fileencoding = "UTF-8"                   -- the encoding written to a file
-- vim.opt.fillchars = "eob: "                      -- Remove "~" from empty lines
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.iskeyword:append("-")                   -- hyphenated words recognized by searches
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.showmode = false                        -- hide -- NORMAL --  -- INSERT --, mode
vim.opt.showtabline = 0                         -- always show tabs
vim.opt.background = "dark"                     -- Set the background option to "dark" to indicate a dark color scheme.
vim.opt.smartcase = true                        -- smart case
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.termguicolors = true                    -- set termguicolors to enable highlight groups
vim.opt.timeoutlen = 300                        -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.writebackup = false                     -- if a file is being edited or was written to file with another program, it is not allowed to be edited
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.shiftwidth = 2                          -- the number of spaces inserted for each indentation
vim.opt.softtabstop = 2                         -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2                             -- insert 2 spaces for a tab
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.cursorlineopt =
"number"                                        -- Set cursorlineopt to "number" to enable line numbering for the cursor line.
vim.opt.number = true                           -- set numbered lines
vim.opt.relativenumber = true                   -- set relative numbered lines
vim.opt.numberwidth = 3                         -- set number column width to 2 {default 4}
vim.opt.signcolumn =
"yes"                                           -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = true                             -- display lines as one long line
-- vim.opt.formatoptions = 1                       -- " Ensures word-wrap does not split words
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- don't insert the current comment leader automatically for...
vim.opt.breakindent = true                      -- " Indents word-wrapped lines as much as the 'parent' line
vim.opt.lbr = true                              -- Enable line break, which wraps long lines at the last space before the width of the window.
vim.opt.linebreak = true                        -- companion to wrap, don't split words
vim.opt.scrolloff = 8                           -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 10                      -- minimal number of screen columns either side of cursor if wrap is `false`
-- vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
vim.opt.whichwrap = "bs<>[]hl"                  -- which "horizontal" keys are allowed to travel to prev/next line
-- vim.opt.guicursor = ""                          -- guicursor as a block instead of a line
vim.opt.shortmess:append("c")                   -- don't give |ins-completion-menu| messages
-- vim.opt.foldmethod = "manual"                   -- Set fold method to 'manual' to manually define folds.
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- Set fold expression to use nvim-treesitter for folding.


-- ========================================
-- # CONFIGURE KEYMAPS
-- ========================================
-- See `:help vim.keymap.set()`
-- Remap to go into normal mode
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("i", "kj", "<ESC>")

-- No operation for the space key in normal and visual mode
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
-- vim.api.nvim_set_keymap("n", "<Leader>zz", [[:let &scrolloff=999-&scrolloff<CR>]], { noremap = true, silent = true })

-- View a list of all headings
vim.keymap.set("n", "<leader>#", ":g^#<cr>")
vim.keymap.set("n", "<leader>//", ":g/^//<cr>")
vim.keymap.set("n", "<leader>//#", ":g^//#<cr>")

-- Toggle undotree
vim.keymap.set("n", "<leader>t", vim.cmd.UndotreeToggle)

-- Toggle between previous file and current file
vim.keymap.set("n", "<leader>.", "<c-^>")

-- Vim Fugitive
vim.keymap.set("n", "<leader>gg", ":Git<cr>")

-- Insert highlighted word in a console.log()
-- vim.api.nvim_set_keymap('x', '<leader>l', [["adiconsole.log(<C-R>a)<Esc>kJ]], { noremap = true })
vim.api.nvim_set_keymap('x', '<leader>l', [["adiconsole.log(<C-R>a<Esc>]], { noremap = true })



-- ========================================
-- # CONFIGURE VIM APIs
-- ========================================
-- -- NVIM BACKGROUND HIGHLIGHTING --
-- -- Normal highlighting
-- vim.api.nvim_set_hl(0, "Normal", { bg = "#1D1D1D" })

-- -- SignColumn highlighting
-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "#1D1D1D" })


-- -- NVIM FOREGROUND HIGHLIGHTING --
-- -- Indent Line highlight
-- vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#222222" })
vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#333333" })

-- -- Comment highlight
-- vim.api.nvim_set_hl(0, "Comment", { fg = "#555555" })
-- vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })

-- -- Line Number highlight
-- vim.api.nvim_set_hl(0, "LineNr", { fg = "#666666" })


-- -- NVIMTREE BACKGROUND HIGHLIGHTING --
-- -- NvimTree Normal highlight
-- vim.cmd("highlight NvimTreeNormal guibg=#181818 ctermbg=NONE")

-- -- NvimTree Opened Folder Name highlight
-- vim.cmd("highlight NvimTreeOpenedFolderName guibg=#181818")

-- -- NvimTree Cursor Line highlight
-- vim.cmd("highlight NvimTreeCursorLine guibg=#151515")


-- -- NVIMTREE FOREGROUND HIGHLIGHTING --
-- -- NvimTree Normal highlight
-- vim.cmd [[hi NvimTreeNormal guifg=#FFFFFF]]

-- -- NvimTree Folder Name highlight
-- vim.cmd("highlight NvimTreeFolderName guifg=#4EC9B0")

-- -- NvimTree Opened Folder Name highlight
-- vim.cmd("highlight NvimTreeOpenedFolderName guifg=#4FC1FE")

-- -- NvimTree Folder Icon highlight
-- vim.cmd('highlight NvimTreeFolderIcon guifg=#a1a1a1')

-- -- NvimTree Indent Marker highlight
vim.cmd('highlight NvimTreeIndentMarker guifg=#222222')

-- -- NvimTree Opened File highlight
-- vim.cmd('highlight NvimTreeOpenedFile guifg=#CE9178')

-- -- NvimTree Modified Files highlight
-- vim.cmd('highlight NvimTreeModifiedFile guifg=#4EC9B0')

-- -- NvimTree Git Dirty highlight (modified fiels)
-- vim.cmd('highlight NvimTreeGitDirty guifg=#3865BD')


-- ========================================
-- # CONFIGURE AUGROUPS
-- ========================================
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


-- ========================================
-- # MY PERSONAL COLORSCHEME
-- ========================================
-- Function to set highlights
local function set_highlights()
	-- Used to highlight boolean values (true and false).
	vim.api.nvim_set_hl(0, 'Boolean', { bg = 'NONE', fg = '#fafafa' })

	-- Used to highlight character literals.
	vim.api.nvim_set_hl(0, 'Character', { bg = 'NONE', fg = '#87afd7' })

	-- Used to highlight the column color in Neovim.
	vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#000000', fg = '#fafafa' })

	-- Used to highlight comments in the code.
	vim.api.nvim_set_hl(0, 'Comment', { bg = 'NONE', fg = '#9e9e9e' })

	-- Used to highlight conditional statements (if, else, etc.).
	vim.api.nvim_set_hl(0, 'Conditional', { bg = 'NONE', fg = '#006a6a' })

	-- Used to highlight constant values (numbers, constants, etc.).
	vim.api.nvim_set_hl(0, 'Constant', { bg = 'NONE', fg = '#fcfcfc' })

	-- Used to highlight the column where the cursor is located.
	vim.api.nvim_set_hl(0, 'CursorColumn', { bg = '#444444', fg = 'NONE' })

	-- Used to highlight the cursor itself.
	vim.api.nvim_set_hl(0, 'Cursor', { bg = 'NONE', fg = 'NONE' })

	-- Used to highlight the line where the cursor is located.
	vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#444444', bold = true })

	-- Used to highlight debug statements or lines.
	vim.api.nvim_set_hl(0, 'Debug', { bg = '#ffffff', fg = 'NONE' })

	-- Used to highlight preprocessor definitions (like #define in C/C++).
	vim.api.nvim_set_hl(0, 'Define', { bg = 'NONE', fg = '#ffffff' })

	-- Used to highlight delimiters (like brackets, braces, commas, etc.).
	vim.api.nvim_set_hl(0, 'Delimiter', { bg = 'NONE', fg = '#fafafa' })
	-- vim.api.nvim_set_hl(0, 'Delimiter', { bg = 'NONE', fg = '#d75f87' })

	-- Used to highlight lines that have been added in a diff view.
	vim.api.nvim_set_hl(0, 'DiffAdd', { bg = 'NONE', fg = '#ffffff' })

	-- Used to highlight lines that have been changed in a diff view.
	vim.api.nvim_set_hl(0, 'DiffChange', { bg = 'NONE', fg = '#afffaf' })

	-- Used to highlight lines that have been deleted in a diff view.
	vim.api.nvim_set_hl(0, 'DiffDelete', { bg = 'NONE', fg = '#9e9e9e' })

	-- Used to highlight the actual changed text within a line in a diff view.
	vim.api.nvim_set_hl(0, 'DiffText', { bg = 'NONE', fg = '#fafafa' })

	-- Used to highlight directories in file explorers like netrw or telescope.
	vim.api.nvim_set_hl(0, 'Directory', { bg = 'NONE', fg = '#ffffff' })

	-- Used to highlight error messages or error lines in the code.
	vim.api.nvim_set_hl(0, 'Error', { bg = '#ff0000', fg = '#000000' })

	-- Used to highlight error messages in the command line or pop-ups.
	vim.api.nvim_set_hl(0, 'ErrorMsg', { bg = 'NONE', fg = '#ffffff' })

	-- Used to highlight exception keywords (like try, catch, throw).
	vim.api.nvim_set_hl(0, 'Exception', { bg = 'NONE', fg = '#fafafa' })

	-- Used to highlight floating point numbers.
	vim.api.nvim_set_hl(0, 'Float', { bg = 'NONE', fg = '#87af00' })

	-- Used to highlight the fold column, which indicates fold levels.
	vim.api.nvim_set_hl(0, 'FoldColumn', { bg = 'NONE', fg = '#87af00' })

	-- Used to highlight folded text.
	vim.api.nvim_set_hl(0, 'Folded', { bg = 'NONE', fg = '#87af00' })

	-- Used to highlight function names and definitions.
	vim.api.nvim_set_hl(0, 'Function', { bg = 'NONE', fg = '#fcfcfc' })

	-- Used to highlight variable names and other identifiers.
	vim.api.nvim_set_hl(0, 'Identifier', { bg = 'NONE', fg = '#9e9e9e' })

	-- Used to highlight preprocessor includes and other include statements (e.g., #include in C/C++).
	vim.api.nvim_set_hl(0, 'Include', { bg = 'NONE', fg = '#ffffff' })

	-- Used to highlight the current match when searching incrementally.
	vim.api.nvim_set_hl(0, 'IncSearch', { bg = '#ffffff', fg = '#000000' })

	-- Used to highlight language keywords (e.g., if, else, while).
	vim.api.nvim_set_hl(0, 'Keyword', { bg = 'NONE', fg = '#ffffff' })

	-- Used to highlight labels (e.g., labels for goto statements in C).
	vim.api.nvim_set_hl(0, 'Label', { bg = 'NONE', fg = '#ffffff' })

	-- Used to highlight line numbers in the editor.
	vim.api.nvim_set_hl(0, 'LineNr', { bg = '#e8e8e8', fg = '#f0f0f0' })

	-- Used to highlight macros (e.g., #define in C).
	vim.api.nvim_set_hl(0, 'Macro', { bg = 'NONE', fg = '#87af00' })

	-- Used to highlight matching parentheses and brackets.
	vim.api.nvim_set_hl(0, 'MatchParen', { bg = 'NONE', fg = '#464646' })

	-- Used to highlight mode messages (e.g., when entering insert mode).
	vim.api.nvim_set_hl(0, 'ModeMsg', { bg = 'NONE', fg = '#fafafa' })

	-- Used to highlight messages when more text is available (e.g., in the command line).
	vim.api.nvim_set_hl(0, 'MoreMsg', { bg = 'NONE', fg = '#fafafa' })

	-- Used to highlight non-text characters (e.g., end-of-line markers).
	vim.api.nvim_set_hl(0, 'NonText', { bg = 'NONE', fg = '#f0f0f0' })

	-- Used to highlight normal text in the editor.
	vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE', fg = '#ffffff' })

	-- Used to highlight numeric constants.
	vim.api.nvim_set_hl(0, 'Number', { bg = 'NONE', fg = '#ffffff' })

	-- Used to highlight operators (e.g., +, -, *, /).
	vim.api.nvim_set_hl(0, 'Operator', { bg = 'NONE', fg = '#5f87d7' })

	-- Used to highlight the popup menu (completion menu).
	vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'NONE', fg = '#ffffff' })

	-- Used to highlight the scrollbar in the popup menu.
	vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = 'NONE', fg = '#464646' })

	-- Used to highlight the selected item in the popup menu.
	vim.api.nvim_set_hl(0, 'PmenuSel', { bg = 'NONE', fg = '#006a6a' })

	-- Used to highlight the thumb of the scrollbar in the popup menu.
	vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = 'NONE', fg = '#e8e8e8' })

	-- Used to highlight preprocessor conditionals (e.g., #if, #ifdef).
	vim.api.nvim_set_hl(0, 'PreCondit', { bg = 'NONE', fg = '#ffffff' })

	-- Used to highlight preprocessor statements (e.g., #define, #include).
	vim.api.nvim_set_hl(0, 'PreProc', { bg = 'NONE', fg = '#87af00' })

	-- Used to highlight questions or prompts.
	vim.api.nvim_set_hl(0, 'Question', { bg = 'NONE', fg = '#fafafa' })

	-- Used to highlight repeat statements (for, while).
	vim.api.nvim_set_hl(0, 'Repeat', { bg = 'NONE', fg = '#ffffff' })

	-- Used to highlight search matches.
	vim.api.nvim_set_hl(0, 'Search', { bg = '#006a6a', fg = '#000000' })

	-- Used to highlight special characters.
	vim.api.nvim_set_hl(0, 'SpecialChar', { bg = 'NONE', fg = '#ffffff' })

	-- Used to highlight special comments (e.g., TODO comments).
	vim.api.nvim_set_hl(0, 'SpecialComment', { bg = 'NONE', fg = '#fafafa' })

	-- Used to highlight special items (like formatting characters).
	vim.api.nvim_set_hl(0, 'Special', { bg = 'NONE', fg = '#ffffff' })

	-- Used to highlight special keys (e.g., non-printable characters).
	vim.api.nvim_set_hl(0, 'SpecialKey', { bg = 'NONE', fg = '#d75f87' })

	-- Used to highlight misspelled words.
	vim.api.nvim_set_hl(0, 'SpellBad', { bg = '#000000', fg = '#434343' })

	-- Used to highlight words that are incorrectly capitalized.
	vim.api.nvim_set_hl(0, 'SpellCap', { bg = 'NONE', fg = '#ffffff' })

	-- Used to highlight words that are incorrect in the local context.
	vim.api.nvim_set_hl(0, 'SpellLocal', { bg = 'NONE', fg = '#ffffff' })

	-- Used to highlight rare words that may be misspelled.
	vim.api.nvim_set_hl(0, 'SpellRare', { bg = 'NONE', fg = '#7c7c7c' })

	-- Used to highlight statements (return, break, continue).
	vim.api.nvim_set_hl(0, 'Statement', { bg = 'NONE', fg = '#e6e6e6' })

	-- Used to highlight the status line of the current window.
	vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#ffffff', fg = '#000000' })

	-- Used to highlight the status line of non-current windows.
	vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = '#eeeeee', fg = '#000000' })

	-- Used to highlight storage class keywords (static, extern).
	vim.api.nvim_set_hl(0, 'StorageClass', { bg = 'NONE', fg = '#ffffff' })

	-- Used to highlight string literals.
	-- vim.api.nvim_set_hl(0, 'String', { bg = 'NONE', fg = '#606060' })
	vim.api.nvim_set_hl(0, 'String', { bg = 'NONE', fg = '#fafafa' })

	-- Used to highlight structure names (e.g., struct in C).
	vim.api.nvim_set_hl(0, 'Structure', { bg = 'NONE', fg = '#ffffff' })

	-- Used to fill the background of the tabline.
	vim.api.nvim_set_hl(0, 'TabLineFill', { bg = '#000000', fg = '#000000' })

	-- Used to highlight tags (e.g., in HTML or XML).
	-- vim.api.nvim_set_hl(0, 'Tag', { bg = 'NONE', fg = '#fafafa' })
	vim.api.nvim_set_hl(0, 'Tag', { bg = 'NONE', fg = '#606060' })

	-- Used to highlight titles (e.g., in Markdown or help files).
	-- vim.api.nvim_set_hl(0, 'Title', { bg = 'NONE', fg = '#d78700' })

	-- Used to highlight TODO comments.
	vim.api.nvim_set_hl(0, 'Todo', { bg = 'NONE', fg = '#ffffff' })

	-- Used to highlight type names (e.g., int, float in C).
	vim.api.nvim_set_hl(0, 'Type', { bg = 'NONE', fg = '#7c7c7c' })

	-- Used to highlight typedef statements in C/C++.
	vim.api.nvim_set_hl(0, 'Typedef', { bg = 'NONE', fg = '#ffffff' })

	-- Used to highlight the vertical split separator.
	vim.api.nvim_set_hl(0, 'VertSplit', { bg = '#000000', fg = '#000000' })

	-- Used to highlight the visual selection.
	vim.api.nvim_set_hl(0, 'Visual', { bg = 'NONE', fg = '#008000' })

	-- Used to highlight visual mode selections when the selection is not active.
	vim.api.nvim_set_hl(0, 'VisualNOS', { bg = 'NONE', fg = '#464646' })

	-- Used to highlight warning messages.
	vim.api.nvim_set_hl(0, 'WarningMsg', { bg = 'NONE', fg = '#006a6a' })

	-- Used to highlight the wild menu (command-line completion matches).
	vim.api.nvim_set_hl(0, 'WildMenu', { bg = 'NONE', fg = '#f0f0f0' })

	-- Define links
	vim.api.nvim_set_hl(0, 'diffCommon', { link = 'Statement' })
	vim.api.nvim_set_hl(0, 'diffRemoved', { link = 'DiffDelete' })
	vim.api.nvim_set_hl(0, 'diffChanged', { link = 'DiffChange' })
	vim.api.nvim_set_hl(0, 'diffAdded', { link = 'DiffAdd' })
end

-- Autocommand to apply highlights after colorscheme is set
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		set_highlights()
	end
})

-- Set colorscheme name
vim.g.colors_name = "A6"

-- Call the highlight function
set_highlights()
