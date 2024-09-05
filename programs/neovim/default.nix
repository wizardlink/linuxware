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

      # TypeScript
      (callPackage ../vtsls/package.nix { })

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
}
