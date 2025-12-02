{
  description = "NixOS System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    clipboard-sync = {
      url = "github:dnut/clipboard-sync";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    hydractify-bot.url = "github:hydractify/hydractify-bot";

    blink-cmp.url = "github:Saghen/blink.cmp";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs =
    {
      home-manager,
      nixpkgs,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        wizdesk =
          let
            specialArgs = inputs;
            modules = [
              ./hosts/wizdesk/nixos.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.extraSpecialArgs = inputs;
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.wizardlink = import ./hosts/wizdesk/home-manager.nix;
              }
            ];
          in
          nixpkgs.lib.nixosSystem { inherit system specialArgs modules; };

        wizlap =
          let
            specialArgs = inputs;
            modules = [
              ./hosts/wizlap/nixos.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.extraSpecialArgs = inputs;
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.wizardlink = import ./hosts/wizlap/home-manager.nix;
              }
            ];
          in
          nixpkgs.lib.nixosSystem { inherit system specialArgs modules; };
      };

      formatter."${system}" = pkgs.nixfmt-rfc-style;

      packages."${system}" = {
        deadlock-api-ingest = pkgs.callPackage ./packages/deadlock-api-ingest.nix { };
        lmms = pkgs.callPackage ./packages/lmms/package.nix { };
        miraclecast = pkgs.callPackage ./packages/miraclecast.nix { };
        wb32dfu-udev-rules = pkgs.callPackage ./packages/wb32dfu-udev-rules { };
      };

      nixosModules = {
        hyprland = import ./modules/hyprland/nixos.nix;
      };

      homeManagerModules = {
        emacs = import ./modules/emacs;
        hyprland = import ./modules/hyprland/home-manager.nix;
        neovim = import ./modules/neovim;
      };

      templates.default = {
        path = ./modules/template;
        description = ''
          A NixOS & Home-Manager template to get started with the https://github.com/wizardlink/linuxware configuration.
        '';
      };
    };
}
