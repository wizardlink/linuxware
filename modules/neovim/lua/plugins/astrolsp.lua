-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@param opts AstroLSPOpts
  ---@return AstroLSPOpts
  opts = function(_, opts)
    local system_flake_path = vim.fn.getenv "FLAKE" or error "FLAKE environment variable must be set."
    local hostname = vim.fn.hostname()

    ---@type AstroLSPOpts
    local lsp_options = {
      -- Configuration table of features provided by AstroLSP
      features = {
        codelens = true,    -- enable/disable codelens refresh on start
        inlay_hints = true, -- enable/disable inlay hints on start
        semantic_tokens = true, -- enable/disable semantic token highlighting
        signature_help = false, -- enable/disable automatic signature help
      },
      -- customize lsp formatting options
      formatting = {
        -- control auto formatting on save
        format_on_save = {
          enabled = true, -- enable or disable format on save globally
          allow_filetypes = { -- enable format on save for specified filetypes only
            -- "go",
            "c",
            "cpp",
            "cs",
            "gdscript",
            "h",
            "javascript",
            "jsx",
            "lua",
            "nix",
            "rust",
            "svelte",
            "tsx",
            "typescript",
            "vue",
          },
          ignore_filetypes = { -- disable format on save for specified filetypes
            -- "python",
          },
        },
        disabled = { -- disable formatting capabilities for the listed language servers
          -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
          -- "lua_ls",
        },
        timeout_ms = 1000, -- default format timeout
        -- filter = function(client) -- fully override the default formatting function
        --   return true
        -- end
      },
      -- enable servers that you already have installed without mason
      servers = {
        "basedpyright",
        "clangd",
        "cmake",
        --"csharp_ls", Testing roslyn.nvim
        "cssls",
        "denols",
        "eslint",
        "gdscript",
        "html",
        "jsonls",
        "lua_ls",
        "marksman",
        "nixd",
        "rust_analyzer",
        "svelte",
        "taplo",
        "volar",
        "vtsls",
        "yamlls",
      },
      -- customize language server configuration options passed to `lspconfig`
      ---@diagnostic disable: missing-fields
      config = {
        -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
        ---@type lspconfig.Config
        nixd = {
          settings = {
            nixd = {
              nixpkgs = {
                expr = "import (builtins.getFlake (" .. system_flake_path .. ")).inputs.nixpkgs { }",
              },
              options = {
                nixos = {
                  expr = "(builtins.getFlake ("
                      .. system_flake_path
                      .. ")).nixosConfigurations."
                      .. hostname
                      .. ".options",
                },
                home_manager = {
                  expr = "(builtins.getFlake ("
                      .. system_flake_path
                      .. ")).nixosConfigurations."
                      .. hostname
                      .. ".options"
                      .. ".home-manager.users.type.getSubOptions []",
                },
              },
            },
          },
        },
        ---@type lspconfig.Config
        vtsls = {
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
          settings = {
            vtsls = {
              tsserver = {
                globalPlugins = {
                  {
                    name = "@vue/typescript-plugin",
                    location = vim.fn.get_nix_store "vue-language-server"
                        .. "/lib/node_modules/@vue/language-server",
                    languages = { "vue" },
                    configNamespace = "typescript",
                    enableForWorkspaceTypeScriptVersions = true,
                  },
                },
              },
            },
          },
        },
        ---@type lspconfig.Config
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                extraEnv = { CARGO_PROFILE_RUST_ANALYZER_INHERITS = "dev" },
                extraArgs = { "--profile", "rust-analyzer" },
              },
              check = { command = "check", extraArgs = {} },
            },
          },
        },
        ---@type lspconfig.Config
        html = {
          filetypes = { "html", "templ", "razor" },
        },
      },
      -- customize how language servers are attached
      handlers = {
        -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
        -- function(server, opts) require("lspconfig")[server].setup(opts) end

        -- the key is the server that is being setup with `lspconfig`
        -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
        -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
      },
      -- Configure buffer local auto commands to add when attaching a language server
      autocmds = {
        -- first key is the `augroup` to add the auto commands to (:h augroup)
        lsp_document_highlight = {
          -- Optional condition to create/delete auto command group
          -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
          -- condition will be resolved for each client on each execution and if it ever fails for all clients,
          -- the auto commands will be deleted for that buffer
          cond = "textDocument/documentHighlight",
          -- cond = function(client, bufnr) return client.name == "lua_ls" end,
          -- list of auto commands to set
          {
            -- events to trigger
            event = { "CursorHold", "CursorHoldI" },
            -- the rest of the autocmd options (:h nvim_create_autocmd)
            desc = "Document Highlighting",
            callback = function()
              vim.lsp.buf.document_highlight()
            end,
          },
          {
            event = { "CursorMoved", "CursorMovedI", "BufLeave" },
            desc = "Document Highlighting Clear",
            callback = function()
              vim.lsp.buf.clear_references()
            end,
          },
        },
      },
      -- mappings to be set up on attaching of a language server
      mappings = {
        n = {
          gl = {
            function()
              vim.diagnostic.open_float()
            end,
            desc = "Hover diagnostics",
          },
          -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
          -- gD = {
          --   function() vim.lsp.buf.declaration() end,
          --   desc = "Declaration of current symbol",
          --   cond = "textDocument/declaration",
          -- },
          -- ["<Leader>uY"] = {
          --   function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          --   desc = "Toggle LSP semantic highlight (buffer)",
          --   cond = function(client) return client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens end,
          -- },
        },
      },
      -- A custom `on_attach` function to be run after the default `on_attach` function
      -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
      on_attach = function(client, bufnr)
        -- this would disable semanticTokensProvider for all clients
        -- client.server_capabilities.semanticTokensProvider = nil
      end,
    }

    opts = vim.tbl_deep_extend("force", opts, lsp_options)

    return opts
  end,
}
