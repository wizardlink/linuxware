---@type LazySpec
return {
  "wizardlink/nvim-ufo",
  opts = {
    provider_selector = function(_, filetype, _)
      ---@type table<string, UfoProviderEnum | UfoProviderEnum[]>
      local ftDefaults = {
        cs = "treesitter",
      }

      local function handleFallbackException(bufnr, err, providerName)
        if type(err) == "string" and err:match "UfoFallbackException" then
          return require("ufo").getFolds(bufnr, providerName)
        else
          return require("promise").reject(err)
        end
      end

      return ftDefaults[filetype]
          or function(bufnr)
            return require("ufo")
                .getFolds(bufnr, "lsp")
                :catch(function(err)
                  return handleFallbackException(bufnr, err, "treesitter")
                end)
                :catch(function(err)
                  return handleFallbackException(bufnr, err, "indent")
                end)
          end
    end,
  },
}
