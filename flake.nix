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
        emacsConfig = import ./modules/home-manager/programs/emacs;
        hyprlandConfig = import ./modules/home-manager/programs/hyprland;
        neovim = import ./modules/home-manager/programs/neovim;
      };
    };
}
