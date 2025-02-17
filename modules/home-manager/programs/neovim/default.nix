{
  config,
  pkgs,
  lib,
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
    nixd = {
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

    ollama = {
      enable = mkEnableOption "enable";
      type = mkOption {
        default = "amd";
        description = "The type of ollama package to install, AMD GPU accelerated or NVIDIA GPU accelerated.";
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
    programs.neovim = {
      withNodeJs = true;
      withPython3 = true;

      extraLuaConfig = builtins.readFile ./init.lua;

      extraPackages = with pkgs; [
        # Needed by ollama.nvim
        curl
        ollamaPackage

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
        #vscode-extensions.vadimcn.vscode-lldb # FIXME: Broken until MR 380775 hits nixpkgs-untable

        # Vue
        prettierd
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

    xdg.configFile."nvim/queries" = {
      recursive = true;
      source = ./queries;
    };

    xdg.configFile."nvim/ftplugin" = {
      recursive = true;
      source = ./ftplugin;
    };

    xdg.configFile."nvim/lua/plugins/astrolsp.lua".source = pkgs.runCommand "astrolsp.lua" { } ''
      cp ${./lsp.lua} $out

      substituteInPlace $out \
        --replace-fail "{hostname}" "${config.programs.neovim.nixd.hostname}" \
        --replace-fail "{location}" "${config.programs.neovim.nixd.location}"
    '';
  };
}
