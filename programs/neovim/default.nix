{ pkgs, astronvim, lib, ... }:

{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;

    extraLuaConfig = builtins.readFile "${astronvim}/init.lua";

    extraPackages = with pkgs; [
      # CMAKE
      neocmakelsp

      # C/C++
      clang-tools

      # HTML/CSS
      emmet-ls
      vscode-langservers-extracted

      # JSON
      nodePackages_latest.vscode-json-languageserver-bin

      # LUA
      lua-language-server
      stylua

      # Markdown
      markdownlint-cli
      marksman
      prettierd

      # Nix
      nil
      nixpkgs-fmt

      # TypeScript
      nodePackages.typescript-language-server

      # Rust
      rust-analyzer
      taplo
      vscode-extensions.vadimcn.vscode-lldb.adapter

      # Vue
      nodePackages.volar

      # YAML
      yaml-language-server
    ];
  };

  xdg.configFile = lib.mkMerge [
    { "nvim/lua/astronvim".source = "${astronvim}/lua/astronvim"; }
    { "nvim/lua/plugins".source = "${astronvim}/lua/plugins"; }
    { "nvim/lua/resession/extensions".source = "${astronvim}/lua/resession/extensions"; }
    { "nvim/lua/lazy_snapshot.lua".source = "${astronvim}/lua/lazy_snapshot.lua"; }
    { "nvim/lua/user".source = ./user; }
    {
      "nvim/parser".source =
        let
          parsers = pkgs.symlinkJoin {
            name = "treesitter-parsers";
            paths = (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: with plugins; [
              bash
              c
              cmake
              cpp
              css
              cuda
              dockerfile
              gdscript
              glsl
              godot_resource
              html
              javascript
              jsdoc
              json
              jsonc
              lua
              lua
              markdown
              markdown_inline
              nim
              nim_format_string
              nix
              objc
              proto
              python
              query
              tsx
              typescript
              vim
              vimdoc
              vue
              yaml
            ])).dependencies;
          };
        in
        "${parsers}/parser";
    }
  ];
}
