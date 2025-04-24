---@class CSFTPlugin.Project
---@field dll_path string
---@field name string
---@field project_path string
---@field target_framework string

---@class CSFTPlugin.LaunchOptions: dap.Configuration
---@field cwd string?
---@field program (fun(): thread)?

---@class CSFTPlugin
---@field dotnet_cmd string?
---@field launch_options CSFTPlugin.LaunchOptions?
local M = {
  dotnet_cmd = vim.fn.exepath "dotnet",
  launch_options = {
    name = "Launch project DLL",
    request = "launch",
    type = "netcoredbg",
  },
}

---@param command string The shell command to execute
---@return string[]
function M.cmd(command)
  -- execute command
  local exec_return = vim.fn.execute("!" .. command)

  -- get the output by line
  local output = vim.tbl_filter(
  ---@param item string
  ---@return boolean
    function(item)
      if item == "" then
        return false
      else
        return true
      end
    end,
    vim.split(exec_return, "[\n]")
  )

  -- remove echo line (":!<command>")
  table.remove(output, 1)

  return output
end

---@return CSFTPlugin.Project[]
function M.find_projects()
  ---@type CSFTPlugin.Project[]
  local projects = {}

  local csproj_extension = ".csproj"

  local csproj_files = M.cmd("find . -name '*" .. csproj_extension .. "'")

  for _, file_path in ipairs(csproj_files) do
    local sub_start, sub_end = string.find(file_path, "%w+%" .. csproj_extension)

    local project_name = string.sub(file_path, sub_start or 1, sub_end - #csproj_extension)
    local project_path = vim.fn.simplify(vim.fn.getcwd() .. "/" .. string.sub(file_path, 1, sub_start - 1))

    local target_framework = M.cmd("rg -e 'TargetFramework>(.*)<' -r '$1' -o " .. file_path)[1]

    projects[#projects + 1] = {
      dll_path = project_path .. "bin/Debug/" .. target_framework .. "/" .. project_name .. ".dll",
      name = project_name,
      project_path = project_path,
      target_framework = target_framework,
    }
  end

  return projects
end

---@param command string The dotnet CLI command to run
---@return string[]
function M:run(command)
  return M.cmd(self.dotnet_cmd .. " " .. command)
end

---@return boolean
function M:check_version()
  local cmd_output = self:run "--version"

  local sub_start = string.find(cmd_output[1], "%d+%.%d+%.%d+")
  if not sub_start then
    return false
  end

  return true
end

---@return thread
function M:choose_dll()
  self.projects = self.find_projects()

  local dap = require "dap"

  return coroutine.create(function(search_coroutine)
    vim.ui.select(
      self.projects,
      {
        prompt = "Select project to debug:",
        ---@param item CSFTPlugin.Project
        ---@return string
        format_item = function(item)
          return item.name
        end,
      },
      ---@param item CSFTPlugin.Project
      function(item)
        local path = item and item.dll_path or dap.ABORT

        if path ~= dap.ABORT then
          self:run "build"
          self.launch_options.cwd = item.project_path
        end

        coroutine.resume(search_coroutine, path)
      end
    )
  end)
end

function M:start()
  local has_dotnet = self:check_version()

  if not has_dotnet then
    vim.notify_once("dotnet executable not present of malfunctioning", vim.log.levels.ERROR)
    return
  end

  vim.fn.setenv("DOTNET_ENVIRONMENT", "Development")

  local debugger_path = vim.fn.get_nix_store "netcoredbg" .. "/bin/netcoredbg"

  local dap = require "dap"

  ---@type dap.ExecutableAdapter
  dap.adapters.netcoredbg = {
    type = "executable",
    command = debugger_path,
    args = { "--interpreter=vscode" },
  }

  self.launch_options.program = function()
    return self:choose_dll()
  end

  ---@type dap.Configuration[]
  dap.configurations.cs = { self.launch_options }

  vim.g.loaded_csftplugin = true
end

if not vim.g.loaded_csftplugin then
  M:start()
end
