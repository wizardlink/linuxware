This module generates dotfiles for [neovim].

The module extends `programs.neovim`.

## Module options

### programs.neovim.flakePath

The location of your system's flake, [nixd] will execute an expression defined in the LSP's configuration that reads
the flake's contents to evaluate [NixOS] and [Home Manager] options.

This setting is optional since other programs might force you to set the `FLAKE` environment variable; if this is not
set by the time you open [neovim] it will spout an error, impeding critical plugins from starting.

### programs.neovim.ollama.enable

Whether to add an [ollama] package to be used with [ollama.nvim](https://github.com/nomnivore/ollama.nvim).

### programs.neovim.ollama.type

The type of [ollama] package to be added, valid options are: `amd`, `nvidia` or `cpu`.

## My neovim failed because of package X not existing

My configuration is based off of `nixos-unstable` so sometimes your package may not exist or have a different name, I
apologise for that but I don't plan on maintaining backwards compatibility. :(

## How it looks

Here's some screenshots of how it currently looks like:

![image](/assets/screenshots/neovim-dashboard.png)
![image](/assets/screenshots/neovim-nix.png)
![image](/assets/screenshots/neovim-rust.png)

The theme I'm using is [catppuccin](https://github.com/catppuccin) in case you're curious.

[neovim]: https://neovim.io/
[Home Manager]: https://github.com/nix-community/home-manager
[nixos]: https://nixos.org
[nixd]: https://github.com/nix-community/nixd/
[ollama]: https://ollama.com/
