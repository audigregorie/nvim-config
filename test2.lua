-- Init Lua file

-- ========================================
-- # CONFIGURE KEYMAPS
-- ========================================
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
-- Sets <space> as the global leader key for general mappings
vim.g.mapleader = " "
-- Sets <space> as the local leader key for buffer-local mappings
vim.g.maplocalleader = " "

-- No operation for the space key in normal and visual mode
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap split windows vertically and horizontally
vim.keymap.set("n", "<leader>|", "<C-w>v")
vim.keymap.set("n", "<leader>_", "<C-w>s")

-- Remap to go into normal mode
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("i", "kj", "<ESC>")

-- Setting "Q" to nothing, dangerous button
vim.keymap.set("n", "Q", "<nop>")

-- Toggle between previous file and current file
vim.keymap.set("n", "<leader>.", "<c-^>")

-- Swap between last two buffers
vim.keymap.set("n", "<leader>'", "<C-^>", { desc = "Switch to last buffer", noremap = true, silent = true })

-- Press 'S' for quick find/replace for the word under the cursor
vim.keymap.set("n", "S", function()
  local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
  local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end, { noremap = true, silent = true })

-- Press 'H', 'L' to jump to start/end of a line (first/last char)
vim.keymap.set("n", "L", "$", { noremap = true, silent = true })
vim.keymap.set("n", "H", "^", { noremap = true, silent = true })

-- Turn off highlighted results
vim.keymap.set("n", "<leader>nh", "<cmd>noh<cr>", { noremap = true, silent = true })

-- Diagnostics

-- Open the diagnostic under the cursor in a float window
vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.open_float({
    border = "rounded",
  })
end, { noremap = true, silent = true })

-- Goto next diagnostic of any severity
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next({})
  vim.api.nvim_feedkeys("zz", "n", false)
end, { noremap = true, silent = true })

-- Goto previous diagnostic of any severity
vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev({})
  vim.api.nvim_feedkeys("zz", "n", false)
end, { noremap = true, silent = true })

-- Goto next error diagnostic
vim.keymap.set("n", "]e", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
  vim.api.nvim_feedkeys("zz", "n", false)
end, { noremap = true, silent = true })

-- Goto previous error diagnostic
vim.keymap.set("n", "[e", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
  vim.api.nvim_feedkeys("zz", "n", false)
end, { noremap = true, silent = true })

-- Goto next warning diagnostic
vim.keymap.set("n", "]w", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
  vim.api.nvim_feedkeys("zz", "n", false)
end, { noremap = true, silent = true })

-- Goto previous warning diagnostic
vim.keymap.set("n", "[w", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
  vim.api.nvim_feedkeys("zz", "n", false)
end, { noremap = true, silent = true })

-- Place all dignostics into a qflist
vim.keymap.set(
  "n",
  "<leader>ld",
  vim.diagnostic.setqflist,
  { desc = "Quickfix [L]ist [D]iagnostics", noremap = true, silent = true }
)

-- Navigate to next qflist item
vim.keymap.set("n", "<leader>cn", ":cnext<cr>zz", { noremap = true, silent = true })

-- Navigate to previous qflist item
vim.keymap.set("n", "<leader>cp", ":cprevious<cr>zz", { noremap = true, silent = true })

-- Open the qflist
vim.keymap.set("n", "<leader>co", ":copen<cr>zz", { noremap = true, silent = true })

-- Close the qflist
vim.keymap.set("n", "<leader>cc", ":cclose<cr>zz", { noremap = true, silent = true })

-- Map MaximizerToggle (szw/vim-maximizer) to leader-m
vim.keymap.set("n", "<leader>m", ":MaximizerToggle<cr>", { noremap = true, silent = true })

-- Resize split windows to be equal size
vim.keymap.set("n", "<leader>=", "<C-w>=", { noremap = true, silent = true })

-- Format the current buffer
vim.keymap.set("n", "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format the current buffer", noremap = true, silent = true })

-- Rotate open windows
vim.keymap.set("n", "<leader>rw", ":RotateWindows<cr>", { desc = "[R]otate [W]indows", noremap = true, silent = true })

-- Open the link under the cursor
vim.keymap.set("n", "gx", ":sil !open <cWORD><cr>", { silent = true, noremap = true })

-- TSC autocommand keybind to run TypeScripts tsc
vim.keymap.set("n", "<leader>tc", ":TSC<cr>", { desc = "[T]ypeScript [C]ompile", noremap = true, silent = true })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })

-- Paste and keep the replaced text in register
vim.keymap.set("v", "p", '"_dP', { noremap = true, silent = true })

-- Move text up and down in visual mode
vim.keymap.set("v", "<S-j>", ":m '>+1<cr>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-k>", ":m '<-2<cr>gv=gv", { noremap = true, silent = true })

-- Remap to indent and outdent lines or blocks of code
vim.keymap.set("n", "<Tab>", ">>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", "<<", { noremap = true, silent = true })
vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })


-- Miscellaneous keymaps
-- Run tests with neotest
vim.keymap.set("n", "<leader>tf", function()
  require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "[T]est [F]ile", noremap = true, silent = true })

vim.keymap.set("n", "<leader>tn", function()
  require("neotest").run.run()
end, { desc = "[T]est [N]earest", noremap = true, silent = true })

vim.keymap.set("n", "<leader>td", function()
  require("neotest").run.run({ strategy = "dap" })
end, { desc = "[T]est with [D]ebugger", noremap = true, silent = true })

vim.keymap.set("n", "<leader>ts", function()
  require("neotest").summary.toggle()
end, { desc = "[T]est [S]ummary", noremap = true, silent = true })

vim.keymap.set("n", "<leader>to", function()
  require("neotest").output.open({ enter = true })
end, { desc = "[T]est [O]utput", noremap = true, silent = true })

vim.keymap.set("n", "<leader>tp", function()
  require("neotest").output_panel.toggle()
end, { desc = "[T]est [P]anel", noremap = true, silent = true })


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
  --
  -- lazy-start
  --
  -- <> Colorscheme Catppuccin
  {
    "catppuccin/nvim",
    config = function()
      require("catppuccin").setup({
        integrations = {
          cmp = true,
          fidget = true,
          gitsigns = true,
          harpoon = true,
          indent_blankline = {
            enabled = false,
            scope_color = "sapphire",
            colored_indent_levels = false,
          },
          mason = true,
          native_lsp = { enabled = true },
          noice = true,
          notify = true,
          symbols_outline = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
        },
      })

      vim.cmd.colorscheme("catppuccin-macchiato")

      -- Hide all semantic highlights until upstream issues are resolved (https://github.com/catppuccin/nvim/issues/480)
      for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
      end
    end,
  },

  -- <> Colorscheme Vscode
  -- {
  --   "Mofiqul/vscode.nvim",
  --   config = function()
  --     require("vscode").setup({
  --       integrations = {
  --         cmp = true,
  --         fidget = true,
  --         gitsigns = true,
  --         harpoon = true,
  --         indent_blankline = {
  --           enabled = false,
  --           scope_color = "sapphire",
  --           colored_indent_levels = false,
  --         },
  --         mason = true,
  --         native_lsp = { enabled = true },
  --         noice = true,
  --         notify = true,
  --         symbols_outline = true,
  --         telescope = true,
  --         treesitter = true,
  --         treesitter_context = true,
  --       },
  --     })

  --     vim.cmd.colorscheme("vscode")

  --     -- Hide all semantic highlights until upstream issues are resolved (https://github.com/catppuccin/nvim/issues/480)
  --     for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  --       vim.api.nvim_set_hl(0, group, {})
  --     end
  --   end,
  -- },

  -- <> Colorscheme Github
  -- {
  --   'projekt0n/github-nvim-theme',
  --   config = function()
  --     vim.cmd([[colorscheme github_dark_default]])
  --     -- vim.cmd([[colorscheme github_dark_dimmed]])
  --     -- vim.cmd([[colorscheme github_dark_high_contrast]])
  --   end,
  -- },

  -- <> Colorscheme Lackluster
  -- {
  --   "slugbyte/lackluster.nvim",
  --   config = function()
  --     vim.cmd([[colorscheme lackluster]])
  --   end,
  -- },

  -- <> Colorscheme Monochrome
  -- {
  --   "kdheepak/monochrome.nvim",
  --   config = function()
  --     vim.cmd.colorscheme("monochrome")

  --     -- Hide all semantic highlights until upstream issues are resolved (https://github.com/catppuccin/nvim/issues/480)
  --     for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  --       vim.api.nvim_set_hl(0, group, {})
  --     end
  --   end,
  -- },

  -- <> LSP config
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
        -- nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        -- nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        nmap("<leader>gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        nmap("<leader>gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")

        nmap("<leader>gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        nmap("<leader>td", vim.lsp.buf.type_definition, "Type [D]efinition")
        nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
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
              lint = { unknownAtRules = "ignore" },
            },
            scss = {
              validate = true,
              lint = { unknownAtRules = "ignore" },
            },
            less = {
              validate = true,
              lint = { unknownAtRules = "ignore" },
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
              lint = { unknownAtRules = "ignore" },
            },
            scss = {
              validate = true,
              lint = { unknownAtRules = "ignore" },
            },
            less = {
              validate = true,
              lint = { unknownAtRules = "ignore" },
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

          -- -- In combination with trouble plugin to show diagnostics in a floating window
          -- on_attach = function(bufnr)
          -- 	vim.api.nvim_create_autocmd('CursorHold', {
          -- 		buffer = bufnr,
          -- 		callback = function()
          -- 			vim.diagnostic.open_float(nil, { focusable = false })
          -- 		end
          -- 	})
          -- end
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

  -- <> Treesitter
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
          "bash",
          "c",
          "cpp",
          "css",
          "go",
          "graphql",
          "html",
          "http",
          "javascript",
          "json",
          "lua",
          "markdown",
          "python",
          "rust",
          "tsx",
          "typescript",
          "vim",
          "xml",
          "yaml",
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

      -- -- Diagnostic keymaps
      -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
      -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
      -- vim.keymap.set("n", "<leader>r", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
      -- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
    end,
  },

  -- <> Autopairs and CMP
  {
    "hrsh7th/nvim-cmp",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      {
        "L3MON4D3/LuaSnip",
        -- version = "v2.3",
      },
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
      "windwp/nvim-ts-autotag",
      "windwp/nvim-autopairs",
    },
    config = function()
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      require("nvim-autopairs").setup()

      -- Integrate nvim-autopairs with cmp
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      -- Load snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
          ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),           -- scroll up preview
          ["<C-d>"] = cmp.mapping.scroll_docs(4),            -- scroll down preview
          ["<C-Space>"] = cmp.mapping.complete({}),          -- show completion suggestions
          ["<C-c>"] = cmp.mapping.abort(),                   -- close completion window
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- select suggestion
        }),
        -- sources for autocompletion
        sources = cmp.config.sources({
          { name = "nvim_lsp" },                      -- lsp
          -- { name = "buffer",    max_item_count = 5 }, -- text within current buffer
          { name = "path",      max_item_count = 3 }, -- file system paths
          { name = "luasnip" },                       -- snippets
          { name = "supermaven" },                    -- Autocompletion copilot
          -- { name = "codeium" }, -- Autocompletion copilot
        }),
        -- Enable pictogram icons for lsp/autocompletion
        formatting = {
          expandable_indicator = true,
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            symbol_map = {
              Copilot = "",
            },
          }),
        },
        experimental = {
          ghost_text = true,
        },
      })
    end,
  },

  -- <> Null-ls
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
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

  -- <> Mason Null-ls
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim", "jose-elias-alvarez/null-ls.nvim" },
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


  -- <> Nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      vim.g.loaded_netrw = 1                     -- Disable netrw at the very start of your init.lua
      vim.g.loaded_netrwPlugin = 1               -- Disable netrwPlugin at the very start of your init.lua
      vim.g.nvim_tree_highlight_opened_files = 1 -- Enable highlighting of opened files in nvim-tree
      vim.g.nvim_tree_highlight_modified = 1     -- Enable highlighting of modified files in nvim-tree

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

  -- <> Lualine
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      -- Eviline config for lualine
      -- Author: shadmansaleh
      -- Credit: glepnir
      local lualine = require('lualine')

      -- Color table for highlights
      -- stylua: ignore
      local colors = {
        -- bg       = '#202328',
        bg       = '#131313',
        fg       = '#bbc2cf',
        yellow   = '#ECBE7B',
        cyan     = '#008080',
        darkblue = '#081633',
        green    = '#98be65',
        orange   = '#FF8800',
        violet   = '#a9a1e1',
        magenta  = '#c678dd',
        blue     = '#51afef',
        red      = '#ec5f67',
      }

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand('%:p:h')
          local gitdir = vim.fn.finddir('.git', filepath .. ';')
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }

      -- Config
      local config = {
        options = {
          -- Disable sections and component separators
          component_separators = '',
          section_separators = '',
          theme = {
            -- We are going to use lualine_c an lualine_x as left and
            -- right section. Both are highlighted by c theme .  So we
            -- are just setting default looks o statusline
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } },
          },
        },
        sections = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          -- These will be filled later
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
      }

      -- Inserts a component in lualine_c at left section
      local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
      end

      -- Inserts a component in lualine_x at right section
      local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
      end


      ins_left {
        function()
          return '▊'
        end,
        -- color = { fg = colors.blue },      -- Sets highlighting of component
        color = function()
          -- auto change color according to neovims mode
          local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            [''] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red,
          }
          return { fg = mode_color[vim.fn.mode()] }
        end,

        padding = { left = 0, right = 1 }, -- We don't need space before this
      }

      ins_left {
        -- mode component
        function()
          -- return ''
          return ''
        end,
        color = function()
          -- auto change color according to neovims mode
          local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            [''] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red,
          }
          return { fg = mode_color[vim.fn.mode()] }
        end,
        padding = { right = 1 },
      }

      ins_left {
        'branch',
        -- icon = '',
        icon = "",
        color = { fg = colors.violet, gui = 'bold' },
      }


      ins_left {
        -- filesize component
        'filesize',
        cond = conditions.buffer_not_empty,
      }

      ins_left {
        'filename',
        cond = conditions.buffer_not_empty,
        color = { fg = colors.magenta, gui = 'bold' },
      }

      -- ins_left { 'location' }

      -- ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

      ins_left {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ' },
        diagnostics_color = {
          color_error = { fg = colors.red },
          color_warn = { fg = colors.yellow },
          color_info = { fg = colors.cyan },
        },
      }

      -- Insert mid section. You can make any number of sections in neovim :)
      -- for lualine it's any number greater then 2
      ins_left {
        function()
          return '%='
        end,
      }

      ins_left {
        -- Lsp server name .
        function()
          local msg = 'No Active Lsp'
          local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = ' LSP:',
        color = { fg = '#ffffff', gui = 'bold' },
      }

      -- Add components to right sections
      -- ins_right {
      --   'o:encoding',       -- option component same as &encoding in viml
      --   fmt = string.upper, -- I'm not sure why it's upper case either ;)
      --   cond = conditions.hide_in_width,
      --   color = { fg = colors.green, gui = 'bold' },
      -- }

      -- ins_right {
      --   'fileformat',
      --   fmt = string.upper,
      --   icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
      --   color = { fg = colors.green, gui = 'bold' },
      -- }

      ins_right {
        'diff',
        -- Is it me or the symbol for modified us really weird
        symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.orange },
          removed = { fg = colors.red },
        },
        cond = conditions.hide_in_width,
      }

      ins_right { 'progress', color = { fg = colors.fg, gui = 'bold' } }

      ins_right { 'location' }


      ins_right {
        function()
          return '▊'
        end,
        -- color = { fg = colors.blue },
        color = function()
          -- auto change color according to neovims mode
          local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            [''] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red,
          }
          return { fg = mode_color[vim.fn.mode()] }
        end,

        padding = { left = 1 },
      }

      -- Now don't forget to initialize lualine
      lualine.setup(config)
    end,
  },

  -- <> Telescope
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
              ["<C-u>"] = require("telescope.actions").preview_scrolling_up,    -- scroll up in preview
              ["<C-d>"] = require("telescope.actions").preview_scrolling_down,  -- scroll down in preview
              ["<C-k>"] = require("telescope.actions").move_selection_previous, -- move to prev result
              ["<C-j>"] = require("telescope.actions").move_selection_next,     -- move to next result
              ["<C-;>"] = require("telescope.actions").which_key,               -- which key cheatsheet
              ["<C-x>"] = require("telescope.actions").delete_buffer,           -- delete buffer
              -- ['<C-|>'] = require('telescope.actions').select_horizontal(), -- open selected file in a horzontal split
              -- ['<C-_>'] = require('telescope.actions').select_vertical(), -- open selected file in a vertical split
            },
            n = {
              ["<C-u>"] = require("telescope.actions").preview_scrolling_up,   -- scroll up in preview
              ["<C-d>"] = require("telescope.actions").preview_scrolling_down, -- scroll down in preview
              ["k"] = require("telescope.actions").move_selection_previous,    -- move to prev result
              ["j"] = require("telescope.actions").move_selection_next,        -- move to next result
              ["<C-;>"] = require("telescope.actions").which_key,              -- which key cheatsheet
              ["<C-x>"] = require("telescope.actions").delete_buffer,          -- delete buffer
              ["gg"] = require("telescope.actions").move_to_top,               -- move to the top of the page
              ["G"] = require("telescope.actions").move_to_bottom,             -- move to the bottom of the page
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
      vim.keymap.set(
        "n",
        "<leader>?",
        require("telescope.builtin").oldfiles,
        { desc = "[?] Find recently opened files" }
      )
      vim.keymap.set(
        "n",
        "<leader><space>",
        require("telescope.builtin").buffers,
        { desc = "[ ] Find existing buffers" }
      )

      -- You can pass additional configuration to telescope to change theme, layout, etc.
      vim.keymap.set("n", "<leader>/", function()
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = "[/] Fuzzily search in current buffer" })

      vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
      vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "[F]ind [F]iles" })
      vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "[F]ind [H]elp" })
      vim.keymap.set(
        "n",
        "<leader>sw",
        require("telescope.builtin").grep_string,
        { desc = "[S]earch current [W]ord" }
      )
      vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "[F]ind by [G]rep" })
      vim.keymap.set(
        "n",
        "<leader>wd",
        require("telescope.builtin").diagnostics,
        { desc = "[W]orkspace [D]iagnostics" }
      )
      vim.keymap.set("n", "<leader>sb", require("telescope.builtin").buffers, { desc = "[S]earch [B]uffers" })
      vim.keymap.set(
        "n",
        "<leader>ds",
        require("telescope.builtin").lsp_document_symbols,
        { desc = "[D]ocument [S]ymbols" }
      )
      vim.keymap.set("n", "<leader>qf", require("telescope.builtin").quickfix, { desc = "[Q]uick [F]ix" })
      vim.keymap.set("n", "<leader>gb", require("telescope.builtin").git_bcommits, { desc = "[G]it [B]commits" })

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

  -- <> Telescope File Browser
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },

  -- <> Telescope UI Select
  { "nvim-telescope/telescope-ui-select.nvim" },

  -- <> Tailiscope (plugin for tailwind cheatsheet)
  { "danielvolchek/tailiscope.nvim" },

  -- <> Cheatsheet
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
  },

  -- <> Neoclip
  {
    "AckslD/nvim-neoclip.lua",
    config = function()
      require("neoclip").setup()
    end,
  },

  -- <> Oil
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        use_default_keymaps = false,
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-\\>"] = "actions.select_split",
          ["<C-enter>"] = "actions.select_vsplit", -- this is used to navigate left
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-r>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
        },
        view_options = {
          show_hidden = true,
        },
      })

      -- Map oil to <leader>e
      vim.keymap.set("n", "<leader>e", function()
        require("oil").toggle_float()
      end, { noremap = true, silent = true })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "oil",
        callback = function()
          vim.opt_local.colorcolumn = ""
        end,
      })
    end,
  },

  -- <> Trouble
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        position = "bottom", -- position of the list can be: bottom, top, left, right
        height = 20,         -- height of the trouble list when position is top or bottom
        width = 50,          -- width of the list when position is left or right
      })
      vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true, noremap = true })
      vim.api.nvim_set_keymap(
        "n",
        "<leader>xw",
        "<cmd>Trouble workspace_diagnostics<cr>",
        { silent = true, noremap = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>xd",
        "<cmd>Trouble document_diagnostics<cr>",
        { silent = true, noremap = true }
      )
      vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>xf", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
      vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })

      -- -- -- Key mapping to show diagnostics in a floating window with custom size
      -- -- vim.keymap.set('n', '<leader>xd', function()
      -- -- 	vim.diagnostic.open_float(nil, {
      -- -- 		width = 80,
      -- -- 		height = 20,
      -- -- 		border = 'rounded'
      -- -- 	})
      -- -- end)
    end,
  },


  -- Git wrapper for vim
  { "tpope/vim-fugitive" },
  -- Github extension to fugitive
  { "tpope/vim-rhubarb" },

  -- Detect tabstop and shiftwidth automatically
  { "tpope/vim-sleuth" },

  -- Gitsigns
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

  -- <> Dressing
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup()
    end,
  },

  -- <> Fidget
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = { "BufEnter" },
    config = function()
      -- Turn on LSP, formatting, and linting status and progress information
      require("fidget").setup({
        text = {
          spinner = "dots_negative",
        },
      })
    end,
  },


  -- <> Indent blankline
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   event = "BufEnter",
  --   opts = {
  --     indent = {
  --       char = "│",
  --       tab_char = "│",
  --     },
  --     scope = { enabled = false },
  --     exclude = {
  --       filetypes = {
  --         "help",
  --         "lazy",
  --         "mason",
  --         "notify",
  --         "oil",
  --       },
  --     },
  --   },
  --   -- main = "ibl",
  -- },

  -- <> Harpoon
  --  {
  --    "ThePrimeagen/harpoon",
  --    lazy = true,
  --    config = function()
  --      local harpoon_ui = require("harpoon.ui")
  --      local harpoon_mark = require("harpoon.mark")

  --      -- Open harpoon ui
  --      vim.keymap.set("n", "<leader>ho", function()
  --        harpoon_ui.toggle_quick_menu()
  --      end, { noremap = true, silent = true })

  --      -- Add current file to harpoon
  --      vim.keymap.set("n", "<leader>ha", function()
  --        harpoon_mark.add_file()
  --      end, { desc = "[H]arpoon [A]dd", noremap = true, silent = true })

  --      -- Remove current file from harpoon
  --      vim.keymap.set("n", "<leader>hr", function()
  --        harpoon_mark.rm_file()
  --      end, { noremap = true, silent = true })

  --      -- Clear all files from harpoon
  --      vim.keymap.set("n", "<leader>hc", function()
  --        harpoon_mark.clear_all()
  --      end, { desc = "[H]arpoon [C]lear", noremap = true, silent = true })

  --      -- Quickly jump to harpooned files
  --      vim.keymap.set("n", "<leader>1", function()
  --        harpoon_ui.nav_file(1)
  --      end, { noremap = true, silent = true })

  --      vim.keymap.set("n", "<leader>2", function()
  --        harpoon_ui.nav_file(2)
  --      end, { noremap = true, silent = true })

  --      vim.keymap.set("n", "<leader>3", function()
  --        harpoon_ui.nav_file(3)
  --      end, { noremap = true, silent = true })

  --      vim.keymap.set("n", "<leader>4", function()
  --        harpoon_ui.nav_file(4)
  --      end, { noremap = true, silent = true })
  --    end,
  --  },

  -- <> Mini Cursorword
  {
    "echasnovski/mini.cursorword",
    lazy = true,
    event = "CursorMoved",
    config = function()
      require("mini.cursorword").setup()
    end,
  },

  -- <> Mini Indentscope
  {
    "echasnovski/mini.indentscope",
    event = "BufEnter",
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      local macchiato = require("catppuccin.palettes").get_palette("macchiato")
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "lazy",
          "mason",
          "notify",
          "oil",
          "Oil",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })

      vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = macchiato.mauve })
    end,
  },

  -- <> Tmux Navigator
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("nvim-tmux-navigation").setup({
        disable_when_zoomed = true,
      })
    end,
  },

  -- <> Spectre
  {
    "nvim-pack/nvim-spectre",
    lazy = true,
    cmd = { "Spectre" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "catppuccin/nvim",
    },
    config = function()
      local theme = require("catppuccin.palettes").get_palette("macchiato")

      vim.api.nvim_set_hl(0, "SpectreSearch", { bg = theme.red, fg = theme.base })
      vim.api.nvim_set_hl(0, "SpectreReplace", { bg = theme.green, fg = theme.base })

      require("spectre").setup({
        highlight = {
          search = "SpectreSearch",
          replace = "SpectreReplace",
        },
        mapping = {
          ["send_to_qf"] = {
            map = "<C-q>",
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
            desc = "send all items to quickfix",
          },
        },
        replace_engine = {
          sed = {
            cmd = "sed",
          },
        },
      })

      -- Open Spectre for global find/replace
      vim.keymap.set("n", "<leader>S", function()
        require("spectre").toggle()
      end, { noremap = true, silent = true })

      -- Open Spectre for global find/replace for the word under the cursor in normal mode
      vim.keymap.set("n", "<leader>sw", function()
        require("spectre").open_visual({ select_word = true })
      end, { desc = "Search current word", noremap = true, silent = true })
    end,
  },

  -- <> Symbols Outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
    config = function()
      require("symbols-outline").setup({
        symbols = {
          File = { icon = "", hl = "@text.uri" },
          Module = { icon = "", hl = "@namespace" },
          Namespace = { icon = "", hl = "@namespace" },
          Package = { icon = "", hl = "@namespace" },
          Class = { icon = "", hl = "@type" },
          Method = { icon = "ƒ", hl = "@method" },
          Property = { icon = "", hl = "@method" },
          Field = { icon = "", hl = "@field" },
          Constructor = { icon = "", hl = "@constructor" },
          Enum = { icon = "", hl = "@type" },
          Interface = { icon = "", hl = "@type" },
          Function = { icon = "", hl = "@function" },
          Variable = { icon = "", hl = "@constant" },
          Constant = { icon = "", hl = "@constant" },
          String = { icon = "", hl = "@string" },
          Number = { icon = "#", hl = "@number" },
          Boolean = { icon = "", hl = "@boolean" },
          Array = { icon = "", hl = "@constant" },
          Object = { icon = "", hl = "@type" },
          Key = { icon = "", hl = "@type" },
          Null = { icon = "", hl = "@type" },
          EnumMember = { icon = "", hl = "@field" },
          Struct = { icon = "", hl = "@type" },
          Event = { icon = "", hl = "@type" },
          Operator = { icon = "", hl = "@operator" },
          TypeParameter = { icon = "", hl = "@parameter" },
          Component = { icon = "", hl = "@function" },
          Fragment = { icon = "", hl = "@constant" },
        },
      })
    end,
  },

  -- <> Typescript Error Translator
  {
    'dmmulroy/ts-error-translator.nvim',
    config = function()
      require("ts-error-translator").setup()
    end,
  },

  -- <> Vim Maximizer
  {
    "szw/vim-maximizer",
  },

  -- <> Vim Surround
  {
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

  -- <> Wilder
  {
    "gelguy/wilder.nvim",
    keys = {
      ":",
      "/",
      "?",
    },
    dependencies = {
      "catppuccin/nvim",
    },
    config = function()
      local wilder = require("wilder")
      local macchiato = require("catppuccin.palettes").get_palette("macchiato")

      -- Create a highlight group for the popup menu
      local text_highlight =
          wilder.make_hl("WilderText", { { a = 1 }, { a = 1 }, { foreground = macchiato.text } })
      local mauve_highlight =
          wilder.make_hl("WilderMauve", { { a = 1 }, { a = 1 }, { foreground = macchiato.mauve } })

      -- Enable wilder when pressing :, / or ?
      wilder.setup({ modes = { ":", "/", "?" } })

      -- Enable fuzzy matching for commands and buffers
      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.cmdline_pipeline({
            fuzzy = 1,
          }),
          wilder.vim_search_pipeline({
            fuzzy = 1,
          })
        ),
      })

      wilder.set_option(
        "renderer",
        wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
          highlighter = wilder.basic_highlighter(),
          highlights = {
            default = text_highlight,
            border = mauve_highlight,
            accent = mauve_highlight,
          },
          pumblend = 5,
          min_width = "100%",
          min_height = "25%",
          max_height = "25%",
          border = "rounded",
          left = { " ", wilder.popupmenu_devicons() },
          right = { " ", wilder.popupmenu_scrollbar() },
        }))
      )
    end,
  },

  -- <> Vim-commentary
  {
    "tpope/vim-commentary",
    -- Keymaps :
    -- [ gcc ] to comment out a line in one go
    -- [ gcap ] to comment out a paragraph
  },

  -- <> Colorizer
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

  -- <> Tailwindcss Colorizer Cmp
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = true,
  },

  -- <> Transparent
  { "xiyaowong/transparent.nvim" },

  -- <> Rainbow Brackets
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("rainbow-delimiters.setup").setup({
        blacklist = { "html" },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      })
    end,
  },

  -- <> Toggleterm
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 40,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
      close_on_exit = true,
      float_opts = {
        border = "curved", -- 'single' | 'double' | 'shadow' | 'curved' |
      },
    },
  },

  -- <> Codesnap (Code screenshot)
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
    end,
  },

  -- <> Headlines for Markdown
  {
    "lukas-reineke/headlines.nvim",
    config = function()
      vim.cmd([[highlight Headline1 guifg=#d78700]])
      vim.cmd([[highlight Headline2 guifg=#87afff]])
      vim.cmd([[highlight Headline3 guifg=#d75f87]])
      vim.cmd([[highlight CodeBlock guibg=#202020]])

      require("headlines").setup({
        markdown = {
          headline_highlights = { "Headline1", "Headline2", "Headline3" },
          fat_headlines = false,
          bullets = "",
        },
      })
    end,
  },

  -- <> Battery
  {
    "justinhj/battery.nvim",
    requires = { { 'nvim-tree/nvim-web-devicons' }, { 'nvim-lua/plenary.nvim' } },
    config = function()
      require("battery").setup({})
    end,
  },

  -- <> Lazygit
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },

  -- <> Vim Px and Rem
  {
    -- Convert between px and rem units
    "Oldenborg/vim-px-to-rem",
    -- Keymaps :
    -- :Rem
    -- :Px
  },

  -- <> Md Headers
  {
    -- View markdown headers
    "AntonVanAssche/md-headers.nvim",
    version = "*",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
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

  -- <> Undo Tree
  { "mbbill/undotree" },

  -- <> Prettier
  {
    "MunifTanjim/prettier.nvim",
    config = function()
      require("prettier").setup({
        cli_options = {
          print_width = 120,
          semi = false,
          single_quote = true,
          tab_width = 2,
        },
      })
    end,
  },

  -- <> Chatgpt
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

  -- <> Codeium Autocompletion
  -- {
  --   "Exafunction/codeium.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
  --   config = function()
  --     require("codeium").setup({})
  --   end,
  -- },

  -- <> Supermarven Autocompletion copilot
  -- {
  --   "supermaven-inc/supermaven-nvim",
  --   config = function()
  --     require("supermaven-nvim").setup({
  --       keymaps = {
  --         accept_suggestion = "<Tab>",
  --         clear_suggestion = "<C-]>",
  --         accept_word = "<C-j>",
  --       },
  --     })
  --   end,
  -- },


  --
  -- lazy-end
  --
}, {
  change_detection = {
    enabled = true,
    notify = false,
  },
})


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

---- Autocmd to copy file path to clipboard
--vim.api.nvim_create_user_command("CopyFilePathToClipboard", function()
--  vim.fn.setreg("+", vim.fn.expand("%:p"))
--end, {})

---- Autocmd to edit text
--vim.api.nvim_create_autocmd({ "FileType" }, {
--  group = vim.api.nvim_create_augroup("edit_text", { clear = true }),
--  pattern = { "gitcommit", "markdown", "txt" },
--  desc = "Enable spell checking and text wrapping for certain filetypes",
--  callback = function()
--    vim.opt_local.wrap = true
--    vim.opt_local.spell = true
--    vim.opt_local.conceallevel = 2
--  end,
--})

---- Autocmd to highlight yanked text
--vim.api.nvim_create_autocmd("TextYankPost", {
--  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
--  pattern = "*",
--  desc = "Highlight selection on yank",
--  callback = function()
--    vim.highlight.on_yank({ timeout = 200, visual = true })
--  end,
--})


---- ========================================
---- # CONFIGURE UTIL
---- ========================================
---- Git directory working tree util
--local is_git_directory = function()
--  local result = vim.fn.system("git rev-parse --is-inside-work-tree")
--  if vim.v.shell_error == 0 and result:find("true") then
--    return true
--  else
--    return false
--  end
--end


-- ========================================
-- # CONFIGURE VIM APIs
-- ========================================
-- Comment highlight
vim.api.nvim_set_hl(0, "Comment", { fg = "#555555" })
vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
