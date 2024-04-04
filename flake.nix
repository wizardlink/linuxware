{
  description = "NixOS System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, home-manager, hyprland, nixpkgs, ... }@inputs:
    let system = "x86_64-linux";
    in {
      nixosConfigurations."nixos" = let
        specialArgs = inputs;
        modules = [
          ./nixos.nix

          hyprland.nixosModules.default
          { programs.hyprland.enable = true; }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = inputs;
            home-manager.users.wizardlink = import ./home-manager.nix;
          }
        ];
      in nixpkgs.lib.nixosSystem { inherit system specialArgs modules; };

      formatter."${system}" = nixpkgs.legacyPackages.${system}.nixfmt;
    };
}
