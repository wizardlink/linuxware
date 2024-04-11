{ pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;

    extraLuaConfig = builtins.readFile ./init.lua;

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
    { "nvim/lua/community.lua".source = ./lua/community.lua; }
    { "nvim/lua/lazy_setup.lua".source = ./lua/lazy_setup.lua; }
    { "nvim/lua/plugins".source = ./lua/plugins; }
    { "nvim/lua/polish.lua".source = ./lua/polish.lua; }
  ];
}
