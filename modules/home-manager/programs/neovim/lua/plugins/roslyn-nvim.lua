---@type LazySpec
return {
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    lazy = true,
    dependencies = {
      {
        "tris203/rzls.nvim",
        opts = {
          capabilities = vim.lsp.protocol.make_client_capabilities(),
          path = vim.fn.getnixpath "rzls" .. "/bin/rzls",
        },
      },
    },
    opts = function(_, opts)
      local rzlspath = vim.fn.getnixpath "rzls"
      require("roslyn.config").get()

      opts = {
        exe = "Microsoft.CodeAnalysis.LanguageServer",
        args = {
          "--stdio",
          "--logLevel=Information",
          "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
          "--razorSourceGenerator=" .. rzlspath .. "/lib/rzls/Microsoft.CodeAnalysis.Razor.Compiler.dll",
          "--razorDesignTimePath="
          .. rzlspath
          .. "/lib/rzls/Targets/Microsoft.NET.Sdk.Razor.DesignTime.targets",
        },
        ---@type vim.lsp.ClientConfig
        ---@diagnostic disable-next-line: missing-fields
        config = {
          handlers = require "rzls.roslyn_handlers",
          settings = {
            ["csharp|inlay_hints"] = {
              csharp_enable_inlay_hints_for_implicit_object_creation = true,
              csharp_enable_inlay_hints_for_implicit_variable_types = true,

              csharp_enable_inlay_hints_for_lambda_parameter_types = true,
              csharp_enable_inlay_hints_for_types = true,
              dotnet_enable_inlay_hints_for_indexer_parameters = true,
              dotnet_enable_inlay_hints_for_literal_parameters = true,
              dotnet_enable_inlay_hints_for_object_creation_parameters = true,
              dotnet_enable_inlay_hints_for_other_parameters = true,
              dotnet_enable_inlay_hints_for_parameters = true,
              dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
            },
            ["csharp|code_lens"] = {
              dotnet_enable_references_code_lens = true,
            },
          },
          ---@class RoslynPatchedClient: vim.lsp.Client
          ---@field patched boolean?

          ---@param client RoslynPatchedClient
          ---@param bufnr integer
          on_attach = function(client, bufnr)
            -- Call AstroLSP's on_attach so it registers mappings, formatting, etc.
            require("astrolsp").on_attach(client, bufnr)

            -- HACK: Patch out the `roslyn-ls` LSP client to have proper
            -- semantic tokens.
            -- This is a snippet of code taken and modified from:
            -- https://github.com/seblyng/roslyn.nvim/wiki#semantic-tokens
            if client.patched then
              return
            else
              client.patched = true
            end

            -- let the runtime know the server can do semanticTokens/full now
            client.server_capabilities = vim.tbl_deep_extend("force", client.server_capabilities, {
              semanticTokensProvider = {
                full = true,
              },
            })

            local lsp_request = client.request

            client.request = function(method, params, handler, req_bufnr)
              if method ~= vim.lsp.protocol.Methods.textDocument_semanticTokens_full then
                return lsp_request(method, params, handler, req_bufnr)
              end

              local target_bufnr = vim.uri_to_bufnr(params.textDocument.uri)
              local line_count = vim.api.nvim_buf_line_count(target_bufnr)
              local last_line =
                  vim.api.nvim_buf_get_lines(target_bufnr, line_count - 1, line_count, true)[1]

              local returnvalue = lsp_request("textDocument/semanticTokens/range", {
                textDocument = params.textDocument,
                range = {
                  ["start"] = {
                    line = 0,
                    character = 0,
                  },
                  ["end"] = {
                    line = line_count - 1,
                    character = string.len(last_line) - 1,
                  },
                },
              }, handler, req_bufnr)
              return returnvalue
            end
          end,
        },
      }

      return opts
    end,
    init = function()
      vim.filetype.add {
        extension = {
          razor = "razor",
          cshtml = "razor",
        },
      }
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = { "Issafalcon/neotest-dotnet", config = function() end },
    opts = function(_, opts)
      if not opts.adapters then
        opts.adapters = {}
      end
      table.insert(opts.adapters, require "neotest-dotnet" (require("astrocore").plugin_opts "neotest-dotnet"))
    end,
  },
}
