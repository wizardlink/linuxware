## [zenergy](https://github.com/BoukeHaarsma23/zenergy/)

This is a kernel driver that adds the ability for user to fetch power draw data from AMD CPUs. I maintain it in
[nixpkgs], so you shouldn't use this package _unless_ it is broken in your current
version of [nixpkgs].

## wb32dfu-udev-rules

This package installs the udev rules necessary to allow flashing QMK/Vial onto keyboards that use WB32-DFU bootloaders.

It is also meant to be used in tandem with [NixOS] using the
[`services.udev.packages`](https://search.nixos.org/options?query=services.udev.packages) configuration.


<!-- REFERENCES -->
[nixpkgs]: https://github.com/NixOS/nixpkgs/
[nixos]: https://nixos.org
