---@type LazySpec
return {
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    lazy = true,
    dependencies = {
      {
        "tris203/rzls.nvim",
        ---@return rzls.Config
        opts = function(_, opts)
          local has_astrolsp, astrolsp = pcall(require, "astrolsp")
          local has_blink, blink = pcall(require, "blink-cmp")

          opts = {
            capabilities = has_blink and blink.get_lsp_capabilities({}, true)
                or vim.lsp.protocol.make_client_capabilities(),
            on_attach = has_astrolsp and astrolsp.on_attach or nil,
            path = vim.fn.get_nix_store "rzls" .. "/bin/rzls",
          }

          return opts
        end,
      },
    },
    opts = function(_, opts)
      local has_astrolsp, astrolsp = pcall(require, "astrolsp")
      local rzlspath = vim.fn.get_nix_store "rzls"

      opts = {
        ---@type vim.lsp.ClientConfig
        ---@diagnostic disable-next-line: missing-fields
        config = {
          cmd = {
            "Microsoft.CodeAnalysis.LanguageServer",
            "--stdio",
            "--logLevel=Information",
            "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
            "--razorSourceGenerator=" .. rzlspath .. "/lib/rzls/Microsoft.CodeAnalysis.Razor.Compiler.dll",
            "--razorDesignTimePath="
            .. rzlspath
            .. "/lib/rzls/Targets/Microsoft.NET.Sdk.Razor.DesignTime.targets",
          },
          handlers = require "rzls.roslyn_handlers",
          on_attach = has_astrolsp and astrolsp.on_attach or nil,
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
