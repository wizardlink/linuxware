{
  config,
  pkgs,
  lib,
  blink-cmp,
  ...
}:

let
  inherit (lib)
    types
    mkOption
    mkIf
    mkEnableOption
    ;

  ollamaPackage = mkIf config.programs.neovim.ollama.enable (
    if config.programs.neovim.ollama.type == "amd" then
      pkgs.ollama-rocm
    else if config.programs.neovim.ollama.type == "nvidia" then
      pkgs.ollama-cuda
    else
      pkgs.ollama
  );
in
{
  options.programs.neovim = {
    flakePath = mkOption {
      default = null;
      description = "The path to your flake, this will be the value of the `FLAKE` environment variable.";
      example = "~/.config/nix";
      type = types.nullOr types.str;
    };

    ollama = {
      enable = mkEnableOption "enable";
      type = mkOption {
        default = "amd";
        description = "The type of ollama package to install, accelerated by an AMD GPU, NVIDIA GPU or CPU.";
        example = "amd";
        type = types.enum [
          "amd"
          "nvidia"
          "cpu"
        ];
      };
    };
  };

  config = {
    home.sessionVariables = {
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
    }
    // lib.optionalAttrs (config.programs.neovim.flakePath != null) {
      FLAKE = config.programs.neovim.flakePath;
    };

    programs.neovim = {
      withNodeJs = true;
      withPython3 = true;

      extraLuaConfig = builtins.readFile ./init.lua;

      extraPackages =
        with pkgs;
        [
          # Needed by LuaSnip
          luajitPackages.jsregexp

          # Treesitter
          gcc # For compiling languages

          # CMAKE
          neocmakelsp

          # C/C++
          clang-tools
          vscode-extensions.ms-vscode.cpptools

          # C#
          #csharp-ls Testing roslyn.nvim
          roslyn-ls
          rzls
          csharpier
          netcoredbg

          # HTML/CSS/JSON
          emmet-ls
          vscode-langservers-extracted

          # LUA
          lua-language-server
          stylua

          # Markdown
          markdownlint-cli
          marksman

          # Nix
          deadnix
          nixd
          nixfmt-rfc-style
          statix

          # Python
          basedpyright
          python312Packages.flake8
          ruff

          # TypeScript/JavaScript
          vtsls
          deno
          vscode-js-debug

          # Rust
          rust-analyzer
          cargo # Needed by blink-cmp
          taplo
          vscode-extensions.vadimcn.vscode-lldb

          # Vue
          prettierd
          vue-language-server

          # Svelte
          nodePackages.svelte-language-server

          # YAML
          yaml-language-server
        ]
        ++ pkgs.lib.optionals config.programs.neovim.ollama.enable [
          # Needed by ollama.nvim
          curl
          ollamaPackage
        ];
    };

    xdg.configFile."nvim/lua" = {
      recursive = true;
      source = ./lua;
    };

    xdg.configFile."nvim/queries" = {
      recursive = true;
      source = ./queries;
    };

    xdg.configFile."nvim/ftplugin" = {
      recursive = true;
      source = ./ftplugin;
    };

    xdg.dataFile."nvim/lazy/blink.cmp/target/release/libblink_cmp_fuzzy.so" = {
      recursive = true;
      source = "${
        blink-cmp.packages.${pkgs.stdenv.hostPlatform.system}.blink-fuzzy-lib
      }/lib/libblink_cmp_fuzzy.so";
    };
  };
}
