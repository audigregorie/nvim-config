-- Init Lua file

-- ========================================
-- # CONFIGURE KEYMAPS
-- ========================================
-- Normal --
-- Disable Space bar since it'll be used as the leader key
vim.keymap.set("n", "<space>", "<nop>", { noremap = true, silent = true })

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- -- Save with leader key
-- vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { silent = false, noremap = true })

-- -- Quit with leader key
-- vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { silent = false, noremap = true })

-- -- Save and Quit with leader key
-- vim.keymap.set("n", "<leader>wq", "<cmd>wq<cr>", { silent = false, noremap = true })

-- Local variables for keymaps
local TERM = os.getenv("TERM")

-- Remap split windows vertically and horizontally
vim.keymap.set("n", "<leader>|", "<C-w>v")
vim.keymap.set("n", "<leader>_", "<C-w>s")

-- Remap to go into normal mode
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("i", "kj", "<ESC>")

-- Remap to indent and outdent lines or blocks of code
vim.keymap.set("n", "<Tab>", ">>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", "<<", { noremap = true, silent = true })
vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

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

-- Press 'U' for redo
vim.keymap.set("n", "U", "<C-r>", { noremap = true, silent = true })

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

-- Navigate buffers
vim.keymap.set("n", "<TAB>", ":bnext<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-TAB>", ":bprevious<cr>", { noremap = true, silent = true })

-- Jump to the start/end of the line with Tab/Shift-Tab in command mode
vim.keymap.set("n", "<Tab>", "^", { silent = true, noremap = true })
vim.keymap.set("n", "<S-Tab>", "$", { silent = true, noremap = true })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })

-- Paste and keep the replaced text in register
vim.keymap.set("v", "p", '"_dP', { noremap = true, silent = true })

-- Move text up and down in visual mode
vim.keymap.set("v", "<S-j>", ":m '>+1<cr>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-k>", ":m '<-2<cr>gv=gv", { noremap = true, silent = true })

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

-- Center buffer while navigating
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "{", "{zz", { noremap = true, silent = true })
vim.keymap.set("n", "}", "}zz", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true, silent = true })
vim.keymap.set("n", "n", "nzz", { noremap = true, silent = true })
vim.keymap.set("n", "G", "Gzz", { noremap = true, silent = true })
vim.keymap.set("n", "gg", "ggzz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-i>", "<C-i>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-o>", "<C-o>zz", { noremap = true, silent = true })
vim.keymap.set("n", "%", "%zz", { noremap = true, silent = true })
vim.keymap.set("n", "*", "*zz", { noremap = true, silent = true })
vim.keymap.set("n", "#", "#zz", { noremap = true, silent = true })

-- Window + better kitty navigation
vim.keymap.set("n", "<C-j>", function()
  if vim.fn.exists(":KittyNavigateDown") ~= 0 and TERM == "xterm-kitty" then
    vim.cmd.KittyNavigateDown()
  elseif vim.fn.exists(":NvimTmuxNavigateDown") ~= 0 then
    vim.cmd.NvimTmuxNavigateDown()
  else
    vim.cmd.wincmd("j")
  end
end, { noremap = true, silent = true })

vim.keymap.set("n", "<C-k>", function()
  if vim.fn.exists(":KittyNavigateUp") ~= 0 and TERM == "xterm-kitty" then
    vim.cmd.KittyNavigateUp()
  elseif vim.fn.exists(":NvimTmuxNavigateUp") ~= 0 then
    vim.cmd.NvimTmuxNavigateUp()
  else
    vim.cmd.wincmd("k")
  end
end, { noremap = true, silent = true })

vim.keymap.set("n", "<C-l>", function()
  if vim.fn.exists(":KittyNavigateRight") ~= 0 and TERM == "xterm-kitty" then
    vim.cmd.KittyNavigateRight()
  elseif vim.fn.exists(":NvimTmuxNavigateRight") ~= 0 then
    vim.cmd.NvimTmuxNavigateRight()
  else
    vim.cmd.wincmd("l")
  end
end, { noremap = true, silent = true })

vim.keymap.set("n", "<C-h>", function()
  if vim.fn.exists(":KittyNavigateLeft") ~= 0 and TERM == "xterm-kitty" then
    vim.cmd.KittyNavigateLeft()
  elseif vim.fn.exists(":NvimTmuxNavigateLeft") ~= 0 then
    vim.cmd.NvimTmuxNavigateLeft()
  else
    vim.cmd.wincmd("h")
  end
end, { noremap = true, silent = true })

-- ========================================
-- # CONFIGURE PLUGINS
-- ========================================
--
-- lazy-start
--
-- Lazy install bootstrap snippet
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
  -- <> Colorscheme Catppuccin
  -- {
  --   "catppuccin/nvim",
  --   config = function()
  --     require("catppuccin").setup({
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

  --     vim.cmd.colorscheme("catppuccin-macchiato")

  --     -- Hide all semantic highlights until upstream issues are resolved (https://github.com/catppuccin/nvim/issues/480)
  --     for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  --       vim.api.nvim_set_hl(0, group, {})
  --     end
  --   end,
  -- },

  -- <> Colorscheme Vscode
  {
    "Mofiqul/vscode.nvim",
    config = function()
      require("vscode").setup({
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

      vim.cmd.colorscheme("vscode")

      -- Hide all semantic highlights until upstream issues are resolved (https://github.com/catppuccin/nvim/issues/480)
      for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
      end
    end,
  },

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
    "neovim/nvim-lspconfig",
    event = { "BufReadPost" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
    dependencies = {
      -- Plugin(s) and UI to automatically install LSPs to stdpath
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Install lsp autocompletions
      "hrsh7th/cmp-nvim-lsp",

      -- Progress/Status update for LSP
      { "j-hui/fidget.nvim", opts = {} },
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

      -- Override tsserver diagnostics to filter out specific messages
      local messages_to_filter = {
        "This may be converted to an async function.",
      }

      local function tsserver_on_publish_diagnostics_override(_, result, ctx, config)
        local filtered_diagnostics = {}

        for _, diagnostic in ipairs(result.diagnostics) do
          local found = false
          for _, message in ipairs(messages_to_filter) do
            if diagnostic.message == message then
              found = true
              break
            end
          end
          if not found then
            table.insert(filtered_diagnostics, diagnostic)
          end
        end

        result.diagnostics = filtered_diagnostics

        vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
      end

      -- Default handlers for LSP
      local default_handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
          { border = "rounded" }),
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities,
        require("cmp_nvim_lsp").default_capabilities())

      -- LSP servers to install (see list here: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers )
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- LSP Servers
        angularls = {},
        bashls = {},
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
        eslint = {
          autostart = false,
          cmd = { "vscode-eslint-language-server", "--stdio", "--max-old-space-size=12288" },
          settings = {
            format = false,
          },
        },
        html = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = {
                checkThirdParty = false,
                -- Tells lua_ls where to find all the Lua files that you have loaded
                -- for your neovim configuration.
                library = {
                  "${3rd}/luv/library",
                  unpack(vim.api.nvim_get_runtime_file("", true)),
                },
              },
              telemetry = { enabled = false },
            },
          },
        },
        pyright = {},
        sqlls = {},
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

          settings = {
            maxTsServerMemory = 12288,
            typescript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              },
            },
          },
          -- handlers = {
          --   ["textDocument/publishDiagnostics"] = vim.lsp.with(
          --     tsserver_on_publish_diagnostics_override,
          --     {}
          --   ),
          -- },
        },

        -- tsserver = {
        -- 	settings = {
        -- 		diagnostics = {
        -- 			ignoredCodes = { 80001, 801701 }, -- Add ignored diagnostic codes here
        -- 		},
        -- 	},
        -- 	handlers = {
        -- 		["textDocument/publishDiagnostics"] = tsserver_on_publish_diagnostics_override,
        -- 	},
        -- },
        yamlls = {},
      }

      local formatters = {
        prettierd = {},
        stylua = {},
      }

      vim.tbl_keys(vim.tbl_deep_extend("force", {}, servers, formatters))

      require("mason-tool-installer").setup({
        auto_update = true,
        run_on_start = true,
        start_delay = 3000,
        debounce_hours = 12,
        ensure_installed = ensure_installed,
      })

      -- Iterate over our servers and set them up
      for name, config in pairs(servers) do
        require("lspconfig")[name].setup({
          autostart = config.autostart,
          cmd = config.cmd,
          capabilities = capabilities,
          filetypes = config.filetypes,
          handlers = vim.tbl_deep_extend("force", {}, default_handlers,
            config.handlers or {}),
          on_attach = on_attach,
          settings = config.settings,
          root_dir = config.root_dir,
          vim.diagnostic.enable(),
        })
      end

      -- Setup mason so it can manage 3rd party LSP servers
      require("mason").setup({
        ui = {
          border = "rounded",
        },
      })

      require("mason-lspconfig").setup()

      -- Configure borderd for LspInfo ui
      require("lspconfig.ui.windows").default_options.border = "rounded"

      -- Configure diagnostics border
      vim.diagnostic.config({
        float = {
          border = "rounded",
        },
      })
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
        version = "v2.3",
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

  -- Nvim-tree
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

      vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", { desc = "Open Nvim Tree" })
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

  -- <> Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
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

  -- <> Conform
  -- {
  -- 	"stevearc/conform.nvim",
  -- 	event = { "BufWritePre", "BufNewFile" },
  -- 	cmd = { "ConformInfo" },
  -- 	opts = {
  -- 		notify_on_error = false,
  -- 		format_after_save = {
  -- 			async = true,
  -- 			timeout_ms = 500,
  -- 			lsp_fallback = true,
  -- 		},
  -- 		formatters_by_ft = {
  -- 			javascript = { { "prettierd", "prettier" } },
  -- 			typescript = { { "prettierd", "prettier" } },
  -- 			typescriptreact = { { "prettierd", "prettier" } },
  -- 			json = { { "prettierd", "prettier" } },
  -- 			lua = { "stylua" },
  -- 			html = { "htmlbeautifier" },
  -- 			yaml = { "yamlfix" },
  -- 			css = { "prettierd", "prettier" },
  -- 			scss = { "prettierd", "prettier" },
  -- 		},
  -- 	},
  -- },

  -- <> Harpoon
  {
    "ThePrimeagen/harpoon",
    lazy = true,
    config = function()
      local harpoon_ui = require("harpoon.ui")
      local harpoon_mark = require("harpoon.mark")

      -- Open harpoon ui
      vim.keymap.set("n", "<leader>ho", function()
        harpoon_ui.toggle_quick_menu()
      end, { noremap = true, silent = true })

      -- Add current file to harpoon
      vim.keymap.set("n", "<leader>ha", function()
        harpoon_mark.add_file()
      end, { desc = "[H]arpoon [A]dd", noremap = true, silent = true })

      -- Remove current file from harpoon
      vim.keymap.set("n", "<leader>hr", function()
        harpoon_mark.rm_file()
      end, { noremap = true, silent = true })

      -- Clear all files from harpoon
      vim.keymap.set("n", "<leader>hc", function()
        harpoon_mark.clear_all()
      end, { desc = "[H]arpoon [C]lear", noremap = true, silent = true })

      -- Quickly jump to harpooned files
      vim.keymap.set("n", "<leader>1", function()
        harpoon_ui.nav_file(1)
      end, { noremap = true, silent = true })

      vim.keymap.set("n", "<leader>2", function()
        harpoon_ui.nav_file(2)
      end, { noremap = true, silent = true })

      vim.keymap.set("n", "<leader>3", function()
        harpoon_ui.nav_file(3)
      end, { noremap = true, silent = true })

      vim.keymap.set("n", "<leader>4", function()
        harpoon_ui.nav_file(4)
      end, { noremap = true, silent = true })
    end,
  },

  -- <> Lualine
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     local harpoon = require("harpoon.mark")

  --     local function truncate_branch_name(branch)
  --       if not branch or branch == "" then
  --         return ""
  --       end

  --       -- Match the branch name to the specified format
  --       local user, team, ticket_number = string.match(branch, "^(%w+)/(%w+)%-(%d+)")

  --       -- If the branch name matches the format, display {user}/{team}-{ticket_number}, otherwise display the full branch name
  --       if ticket_number then
  --         return user .. "/" .. team .. "-" .. ticket_number
  --       else
  --         return branch
  --       end
  --     end

  --     local function harpoon_component()
  --       local total_marks = harpoon.get_length()

  --       if total_marks == 0 then
  --         return ""
  --       end

  --       local current_mark = "—"

  --       local mark_idx = harpoon.get_current_index()
  --       if mark_idx ~= nil then
  --         current_mark = tostring(mark_idx)
  --       end

  --       return string.format("󱡅 %s/%d", current_mark, total_marks)
  --     end


  --     require("lualine").setup({
  --       options = {
  --         -- theme = "catppuccin",
  --         theme = "vscode",
  --         globalstatus = true,
  --         component_separators = { left = "", right = "" },
  --         section_separators = { left = "█", right = "█" },
  --         -- section_separators = { left = '', right = '' },
  --       },
  --       sections = {
  --         lualine_a = { { 'mode', right_padding = 2 } },
  --         -- lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
  --         lualine_b = {
  --           { "branch", icon = "", fmt = truncate_branch_name },
  --           harpoon_component,
  --           "diff",
  --           "diagnostics",
  --         },
  --         lualine_c = {
  --           { "filename", path = 1 },

  --         },
  --         lualine_x = {
  --           -- "filetype",
  --         },
  --         -- lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 } },
  --       },
  --     })
  --   end,
  -- },

  -- <> Lualine
  -- lualinestart
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
        bg       = '#101010',
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
  -- lualineend

  -- <> Markdown Preview
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    cmd = {
      "MarkdownPreviewToggle",
      "MarkdownPreview",
      "MarkdownPreviewStop",
    },
  },

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

  -- <> Notify nvim
  --{
  --  "rcarriga/nvim-notify",
  --  event = "VeryLazy",
  --  config = function()
  --    local notify = require("notify")

  --    local filtered_message = { "No information available" }

  --    -- Override notify function to filter out messages
  --    ---@diagnostic disable-next-line: duplicate-set-field
  --    vim.notify = function(message, opts)
  --      local merged_opts = vim.tbl_extend("force", {
  --        on_open = function(win)
  --          local buf = vim.api.nvim_win_get_buf(win)
  --          vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
  --        end,
  --      }, opts or {})

  --      for _, msg in ipairs(filtered_message) do
  --        if message == msg then
  --          return
  --        end
  --      end
  --      return notify(message, merged_opts)
  --    end

  --    -- Update colors to use catppuccino colors
  --    vim.cmd([[
  --highlight NotifyERRORBorder guifg=#ed8796
  --highlight NotifyERRORIcon guifg=#ed8796
  --highlight NotifyERRORTitle  guifg=#ed8796
  --highlight NotifyINFOBorder guifg=#8aadf4
  --highlight NotifyINFOIcon guifg=#8aadf4
  --highlight NotifyINFOTitle guifg=#8aadf4
  --highlight NotifyWARNBorder guifg=#f5a97f
  --highlight NotifyWARNIcon guifg=#f5a97f
  --highlight NotifyWARNTitle guifg=#f5a97f
  --]])
  --  end,
  --},

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

  -- <> Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    event = { "BufEnter" },
    dependencies = {
      -- Additional text objects for treesitter
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      ---@diagnostic disable: missing-fields
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "css",
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
        sync_install = false,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        autopairs = {
          enable = true,
        },
        autotag = {
          enable = true,
        },
        --[[ context_commentstring = {
					enable = true,
					enable_autocmd = false,
				}, ]]
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
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

  -- <> Tsc
  {
    "dmmulroy/tsc.nvim",
    lazy = true,
    ft = { "typescript", "typescriptreact" },
    config = function()
      require("tsc").setup({
        auto_open_qflist = true,
        pretty_errors = false,
      })
    end,
  },

  -- <> Ufo
  {
    "kevinhwang91/nvim-ufo",
    event = "BufEnter",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = function()
      --- @diagnostic disable: unused-local
      require("ufo").setup({
        provider_selector = function(_bufnr, _filetype, _buftype)
          return { "treesitter", "indent" }
        end,
      })
    end,
  },

  -- <> Vim Maximizer
  {
    "szw/vim-maximizer",
  },

  -- <> Vim Surround
  {
    "tpope/vim-surround",
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

  -- <> Trouble
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xd",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  -- <> Null-ls
  {
    -- "jose-elias-alvarez/null-ls.nvim",
    "nvimtools/none-ls.nvim",
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
                ["<C-n>"] = require(
                      "telescope._extensions.file_browser.actions")
                    .create,
                ["<C-r>"] = require(
                      "telescope._extensions.file_browser.actions")
                    .rename,
                ["<C-l>"] = require(
                      "telescope._extensions.file_browser.actions")
                    .change_cwd,
                ["<C-h>"] = require(
                      "telescope._extensions.file_browser.actions")
                    .goto_parent_dir,
                ["<C-.>"] = require(
                      "telescope._extensions.file_browser.actions")
                    .toggle_hidden,
                ["<C-x>"] = require(
                      "telescope._extensions.file_browser.actions")
                    .remove,
                -- ['<C-|>'] = require('telescope.actions').select_horizontal(), -- open selected file in a horizontal split
                -- ['<C-_>'] = require('telescope.actions').select_vertical(), -- open selected file in a vertical split
              },
              n = {
                ["<C-n>"] = require(
                      "telescope._extensions.file_browser.actions")
                    .create,
                ["<C-r>"] = require(
                      "telescope._extensions.file_browser.actions")
                    .rename,
                ["l"] = require(
                      "telescope._extensions.file_browser.actions")
                    .change_cwd,
                ["h"] = require(
                      "telescope._extensions.file_browser.actions")
                    .goto_parent_dir,
                ["<C-.>"] = require(
                      "telescope._extensions.file_browser.actions")
                    .toggle_hidden,
                ["<C-x>"] = require(
                      "telescope._extensions.file_browser.actions")
                    .remove,
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
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes")
          .get_dropdown({
            winblend = 10,
            previewer = false,
          }))
      end, { desc = "[/] Fuzzily search in current buffer" })

      vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files,
        { desc = "Search [G]it [F]iles" })
      vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files,
        { desc = "[F]ind [F]iles" })
      vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags,
        { desc = "[F]ind [H]elp" })
      vim.keymap.set(
        "n",
        "<leader>sw",
        require("telescope.builtin").grep_string,
        { desc = "[S]earch current [W]ord" }
      )
      vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep,
        { desc = "[F]ind by [G]rep" })
      vim.keymap.set(
        "n",
        "<leader>wd",
        require("telescope.builtin").diagnostics,
        { desc = "[W]orkspace [D]iagnostics" }
      )
      vim.keymap.set("n", "<leader>sb", require("telescope.builtin").buffers,
        { desc = "[S]earch [B]uffers" })
      vim.keymap.set(
        "n",
        "<leader>ds",
        require("telescope.builtin").lsp_document_symbols,
        { desc = "[D]ocument [S]ymbols" }
      )
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

  -- <> Git wrapper for vim
  {
    "tpope/vim-fugitive",
    config = function()
      -- Open git vim fugitive
      vim.keymap.set("n", "<leader>gg", ":Git<cr>")
    end,
  },

  -- <> Github extension to fugitive
  { "tpope/vim-rhubarb" },

  {
    -- <> Vim convert between px and rem
    "Oldenborg/vim-px-to-rem",
    -- Keymaps :
    -- :Rem
    -- :Px
  },

  -- <> Vim Tmux Navigator
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  -- <> Transparent
  { "xiyaowong/transparent.nvim" },

  -- <> MarkdownHeaders
  {
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

  -- -- <> Prettier
  -- {
  --   "MunifTanjim/prettier.nvim",
  --   config = function()
  --     require("prettier").setup({
  --       cli_options = {
  --         print_width = 220,
  --         semi = false,
  --         single_quote = true,
  --         tab_width = 2,
  --       },
  --     })
  --   end,
  -- },

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

  -- <> Typescript Error Translator
  {
    "dmmulroy/ts-error-translator.nvim",
    config = function()
      require("ts-error-translator").setup()
    end,
  },

  -- -- <> Codeium AI copilot
  -- {
  -- "Exafunction/codeium.nvim",
  -- dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
  -- config = function()
  --   require("codeium").setup({})
  -- end,
  -- },

  -- <> Supermaven AI copilot
  -- {
  --   "supermaven-inc/supermaven-nvim",
  --   opts = {
  --     disable_keymaps = true,
  --     keymaps = {
  --       accept_suggestion = "<Tab>",
  --       clear_suggestion = "<C-]>",
  --     },
  --   },
  -- },

  {
    "justinhj/battery.nvim",
    requires = { { 'nvim-tree/nvim-web-devicons' }, { 'nvim-lua/plenary.nvim' } },
    config = function()
      require("battery").setup({})
    end,
  },

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
-- vim.opt.number = true                           -- set numbered lines
-- vim.opt.relativenumber = true                   -- set relative numbered lines
vim.opt.showmode = false                        -- Disable showing the mode below the statusline
vim.opt.softtabstop = 2                         -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2                             -- insert 2 spaces for a tab
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.shiftwidth = 2                          -- the number of spaces inserted for each indentation
vim.opt.breakindent = true                      -- " Indents word-wrapped lines as much as the 'parent' line
vim.opt.incsearch = true
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.wrap = false                            -- wrap text to the next line
vim.opt.linebreak = true                        -- companion to wrap, don't split words
vim.opt.iskeyword:append("-")                   -- hyphenated words recognized by searches
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.smartcase = true                        -- better case detection in searches
vim.opt.updatetime = 250                        -- faster completion (4000ms default)
vim.opt.completeopt = { "menuone", "noselect" } -- Set completeopt to have a better completion experience
vim.opt.undofile = true                         -- persistent undo history
vim.opt.termguicolors = true                    -- 24-bit color
vim.opt.signcolumn = "yes"                      -- show the sign column, otherwise it would shift the text each time
vim.opt.clipboard = "unnamed,unnamedplus"       -- allows neovim to access the system clipboard
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.scrolloff = 8                           -- minimal number of screen lines to keep above and below the cursor


-- Markdown files
-- vim.opt.conceallevel = 0 -- 0 is so that `` is visible in markdown files

-- Set fold settings
-- These options were reccommended by nvim-ufo
-- See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.opt.guicursor = {
  "n-v-c:block",                                  -- Normal, visual, command-line: block cursor
  "i-ci-ve:ver25",                                -- Insert, command-line insert, visual-exclude: vertical bar cursor with 25% width
  "r-cr:hor20",                                   -- Replace, command-line replace: horizontal bar cursor with 20% height
  "o:hor50",                                      -- Operator-pending: horizontal bar cursor with 50% height
  "a:blinkwait700-blinkoff400-blinkon250",        -- All modes: blinking settings
  "sm:block-blinkwait175-blinkoff150-blinkon175", -- Showmatch: block cursor with specific blinking settings
}

-- ========================================
-- # CONFIGURE AUTOCMD
-- ========================================
-- Autocmd to copy file path to clipboard
vim.api.nvim_create_user_command("CopyFilePathToClipboard", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, {})

-- Autocmd to edit text
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("edit_text", { clear = true }),
  pattern = { "gitcommit", "markdown", "txt" },
  desc = "Enable spell checking and text wrapping for certain filetypes",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.conceallevel = 2
  end,
})

-- Autocmd to highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  pattern = "*",
  desc = "Highlight selection on yank",
  callback = function()
    vim.highlight.on_yank({ timeout = 200, visual = true })
  end,
})

-- Autocmd for kitty terminal configurations
local set_kitty_layout_is_stack = vim.schedule_wrap(function()
  local layout = vim.fn.system("kitty @ kitten get_layout.py")
  vim.g.kitty_layout_is_stack = string.match(layout, "stack")
end)

-- Check if we launched into neovim from kitty in scrollback mode
-- If so, jump to the bottom of the buffer
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.g.is_kitty_scrollback then
      vim.defer_fn(function()
        vim.cmd("normal G")
        vim.cmd("call search('.', 'bW')")
      end, 250)
    end

    set_kitty_layout_is_stack()
  end,
})

-- Reset is_kitty_scrollback on exit
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    vim.g.is_kitty_scrollback = nil
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  callback = set_kitty_layout_is_stack,
})

-- Autocmd to resize windows
vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("WinResize", { clear = true }),
  pattern = "*",
  command = "wincmd =",
  desc = "Auto-resize windows on terminal buffer resize.",
})

-- Autocmd for vertical help
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("vertical_help", { clear = true }),
  pattern = "help",
  callback = function()
    vim.bo.bufhidden = "unload"
    vim.cmd.wincmd("L")
    vim.cmd.wincmd("=")
  end,
})

-- ========================================
-- # CONFIGURE USER COMMANDS
-- ========================================
-- User command to rotate windows
vim.api.nvim_create_user_command("RotateWindows", function()
  local ignored_filetypes = { "neo-tree", "fidget", "Outline", "toggleterm", "qf", "notify" }
  local window_numbers = vim.api.nvim_tabpage_list_wins(0)
  local windows_to_rotate = {}

  for _, window_number in ipairs(window_numbers) do
    local buffer_number = vim.api.nvim_win_get_buf(window_number)
    local filetype = vim.bo[buffer_number].filetype

    if not vim.tbl_contains(ignored_filetypes, filetype) then
      table.insert(windows_to_rotate, { window_number = window_number, buffer_number = buffer_number })
    end
  end

  local num_eligible_windows = vim.tbl_count(windows_to_rotate)

  if num_eligible_windows == 0 then
    return
  elseif num_eligible_windows == 1 then
    vim.api.nvim_err_writeln("There is no other window to rotate with.")
    return
  elseif num_eligible_windows == 2 then
    local firstWindow = windows_to_rotate[1]
    local secondWindow = windows_to_rotate[2]

    vim.api.nvim_win_set_buf(firstWindow.window_number, secondWindow.buffer_number)
    vim.api.nvim_win_set_buf(secondWindow.window_number, firstWindow.buffer_number)
  else
    vim.api.nvim_err_writeln("You can only swap 2 open windows. Found " .. num_eligible_windows .. ".")
  end
end, {})

-- User command to toggle diagnostics
vim.api.nvim_create_user_command("ToggleDiagnostics", function()
  if vim.g.diagnostics_enabled == nil then
    vim.g.diagnostics_enabled = false
    vim.diagnostic.disable()
  elseif vim.g.diagnostics_enabled then
    vim.g.diagnostics_enabled = false
    vim.diagnostic.disable()
  else
    vim.g.diagnostics_enabled = true
    vim.diagnostic.enable()
  end
end, {})

-- ========================================
-- # CONFIGURE UTIL
-- ========================================
-- Git directory working tree util
local is_git_directory = function()
  local result = vim.fn.system("git rev-parse --is-inside-work-tree")
  if vim.v.shell_error == 0 and result:find("true") then
    return true
  else
    return false
  end
end

-- ========================================
-- # CONFIGURE VIM APIs
-- ========================================
-- Comment highlight
vim.api.nvim_set_hl(0, "Comment", { fg = "#555555" })
vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
