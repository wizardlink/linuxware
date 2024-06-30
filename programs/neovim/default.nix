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
      gcc # Needed for treesitter

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
      nixfmt-rfc-style

      # TypeScript
      (callPackage ../vtsls/package.nix { })

      # Rust
      rust-analyzer
      taplo
      vscode-extensions.vadimcn.vscode-lldb.adapter

      # Vue
      vscode-extensions.vue.volar

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
}
