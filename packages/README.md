## [zenergy](https://github.com/BoukeHaarsma23/zenergy/)

This is a kernel driver that adds the ability for user to fetch power draw data from AMD CPUs. I maintain it in
[nixpkgs], so you shouldn't use this package _unless_ it is broken in your current
version of [nixpkgs].

Unfortunately this cannot be outputted as a package in the flake since to create a derivation the `kernel` parameter
must be present, which, each user will have their own kernel package.

Thus you need to copy the `zenergy.nix` file somewhere in your configuration and inside `boot.extraModulePackages` pass
the package with the following expression: `config.boot.kernelPackages.callPackage ./path/to/zenergy.nix`; successfully
installing the package onto your system.

## wb32dfu-udev-rules

This package installs the udev rules necessary to allow flashing QMK/Vial onto keyboards that use WB32-DFU bootloaders.

It is meant to be used in tandem with [NixOS] using the
[`services.udev.packages`](https://search.nixos.org/options?query=services.udev.packages) configuration.


<!-- REFERENCES -->
[nixpkgs]: https://github.com/NixOS/nixpkgs/
[nixos]: https://nixos.org
