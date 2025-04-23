---@type LazySpec
return {
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    lazy = true,
    dependencies = {
      {
        "tris203/rzls.nvim",
        opts = function(_, opts)
          opts = {
            capabilities = vim.lsp.protocol.make_client_capabilities(),
            path = vim.fn.get_nix_store "rzls" .. "/bin/rzls",
          }

          return opts
        end,
      },
    },
    opts = function(_, opts)
      local rzlspath = vim.fn.get_nix_store "rzls"
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
