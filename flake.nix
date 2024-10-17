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

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs =
    { home-manager, nixpkgs, ... }@inputs:
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
              ./specific/desktop/nixos.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.extraSpecialArgs = inputs;
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.wizardlink = import ./specific/desktop/home-manager.nix;
              }
            ];
          in
          nixpkgs.lib.nixosSystem { inherit system specialArgs modules; };

        wizlap =
          let
            specialArgs = inputs;
            modules = [
              ./specific/laptop/nixos.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.extraSpecialArgs = inputs;
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.wizardlink = import ./specific/laptop/home-manager.nix;
              }
            ];
          in
          nixpkgs.lib.nixosSystem { inherit system specialArgs modules; };
      };

      formatter."${system}" = pkgs.nixfmt-rfc-style;

      homeManagerModules = {
        common = import ./modules/home-manager/common.nix;
        default = import ./modules/home-manager;
        emacsConfig = import ./modules/home-manager/programs/emacs;
        hyprlandConfig = import ./modules/home-manager/programs/hyprland;
        neovim = import ./modules/home-manager/programs/neovim;
        theming = import ./modules/home-manager/theming.nix;
      };

      nixosModules = {
        common = import ./modules/nixos/common.nix;
        default = import ./modules/nixos;
        desktop = import ./modules/nixos/desktop.nix;
        hardware = import ./modules/nixos/hardware.nix;
        sound = import ./modules/nixos/sound.nix;
        system = import ./modules/nixos/system.nix;
      };
    };
}
