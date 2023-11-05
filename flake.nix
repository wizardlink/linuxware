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

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hyprland,
    ...
  }@inputs: {
    nixosConfigurations.nixos =
      let
        system = "x86_64-linux";
        modules = [
          ./nixos.nix

          hyprland.nixosModules.default
          {
            programs.hyprland.enable = true;
          }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.wizardlink = import ./home-manager.nix;
          }
        ];
      in
        nixpkgs.lib.nixosSystem { inherit system modules; };

    homeConfigurations."wizardlink@nixos" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      modules = [
        hyprland.homeManagerModules.default
        {
          wayland.windowManager.hyprland.enable = true;
        }
      ];
    };
  };
}
