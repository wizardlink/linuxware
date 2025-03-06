In this directory you will find the configuration for [NixOS] and [Home Manager] that I share across multiple machines.

## File structure

### ./nixos

- `default.nix`
  - _Entry point._
- `common.nix`
  - _General configuration and packages._
- `desktop.nix`
  - _Desktop specific configuration._
- `gaming.nix`
  - _Gaming related configuration._
- `hardware.nix`
  - _Hardware specific configuration._
- `system.nix`
  - _Configuration pertaining the system._
- `virtualization.nix`
  - _Virtualization packages and configuration._

### ./home-manager

- `default.nix`
  - _Entry point._
- `common.nix`
  - _General and misc. packages alongside uncategorized dotfiles._
- `gaming.nix`
  - _Packages and dotfiles pertaining games/gaming._
- `theming.nix`
  - _Theming of the system and it's packages._
- `dotfiles/`
  - _Program specific user configuration._
- `scripts/`
  - _Contains scripts that I may use day to day._

#### Screenshots

Waybar:

![image](/assets/screenshots/waybar.png)

Rofi:

![image](/assets/screenshots/rofi.png)


<!-- REFERENCES -->

[nixos]: https://nixos.org
[home manager]: https://github.com/nix-community/home-manager
