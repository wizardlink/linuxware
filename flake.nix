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

    hyprland-hyprfocus = {
      url = "github:VortexCoyote/hyprfocus";
      inputs.hyprland.follows = "hyprland";
    };

    # My neovim configuration using nixvim.
    custom-neovim.url = "github:wizardlink/neovim";

    # Real time scheduling for audio work.
    musnix.url = "github:musnix/musnix";
  };

  outputs =
    { self
    , home-manager
    , hyprland
    , nixpkgs
    , musnix
    , ...
    }@inputs: {
      nixosConfigurations.nixos =
        let
          system = "x86_64-linux";
          modules = [
            ./nixos.nix

            musnix.nixosModules.musnix

            hyprland.nixosModules.default
            {
              programs.hyprland.enable = true;
            }

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = inputs;
              home-manager.users.wizardlink = import ./home-manager.nix;
            }
          ];
        in
        nixpkgs.lib.nixosSystem { inherit system modules; };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
