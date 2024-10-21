{
  config,
  pkgs,
  lib,
  ...
}:

let
  inherit (lib) types mkOption;
  ollamaPackage =
    if config.programs.neovim.ollama.type == "amd" then pkgs.ollama-rocm else pkgs.ollama-cuda;
in
{
  options.programs.neovim = {
    flake = {
      hostname = mkOption {
        default = "wizdesk";
        description = "Your NixOS hostname, needed for nixd lsp.";
        example = "nixos";
        type = types.str;
      };

      location = mkOption {
        default = "git+file:///home/wizardlink/.system";
        description = "Path to your flake location, prepend 'file:///' to it and 'git+' before that if using git.";
        example = "git+file:///home/wizardlink/.system";
        type = types.str;
      };
    };

    ollama.type = mkOption {
      default = "amd";
      description = "The type of ollama package to install, AMD GPU accelerated or NVIDIA GPU accelerated.";
      example = "amd";
      type = types.enum [
        "amd"
        "nvidia"
      ];
    };
  };

  config = {
    programs.neovim = {
      enable = true;
      withNodeJs = true;
      withPython3 = true;

      extraLuaConfig = builtins.readFile ./init.lua;

      extraPackages = with pkgs; [
        # Needed by ollama.nvim
        curl
        ollamaPackage

        # CMAKE
        neocmakelsp

        # C/C++
        clang-tools
        gcc # Needed for treesitter

        # C#
        csharp-ls
        csharpier

        # HTML/CSS/JSON
        emmet-ls
        vscode-langservers-extracted

        # LUA
        lua-language-server
        stylua

        # Markdown
        markdownlint-cli
        marksman
        prettierd

        # Nix
        nixd
        nixfmt-rfc-style

        # Python
        basedpyright
        python312Packages.flake8
        ruff

        # TypeScript
        typescript-language-server

        # Rust
        rust-analyzer
        taplo
        vscode-extensions.vadimcn.vscode-lldb.adapter

        # Vue
        vue-language-server

        # Svelte
        nodePackages.svelte-language-server

        # YAML
        yaml-language-server
      ];
    };

    xdg.configFile."nvim/lua" = {
      recursive = true;
      source = ./lua;
    };

    xdg.configFile."nvim/lua/plugins/astrolsp.lua".text = import ./lsp.nix {
      config = config;
      pkgs = pkgs;
    };

    xdg.configFile."nvim/colors/catppuccin-frappe-base16.lua".source = ./colors/catppuccin-frappe-base16.lua;
  };
}
