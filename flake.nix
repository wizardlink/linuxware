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
              ./modules/nixos
              ./specific/wizdesk/nixos.nix
            ];
          in
          nixpkgs.lib.nixosSystem { inherit system specialArgs modules; };

        wizlap =
          let
            specialArgs = inputs;
            modules = [
              ./modules/nixos
              ./specific/wizlap/nixos.nix
            ];
          in
          nixpkgs.lib.nixosSystem { inherit system specialArgs modules; };
      };

      homeConfigurations.wizardlink = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = inputs;
        modules = [ ./specific/home-manager.nix ];
      };

      formatter."${system}" = pkgs.nixfmt-rfc-style;

      homeManagerModules = {
        emacs = import ./modules/home-manager/programs/emacs;
        hyprlandConfig = import ./modules/home-manager/programs/hyprland;
        neovim = import ./modules/home-manager/programs/neovim;
      };

      nixosModules = {
        default = import ./modules/nixos;
      };
    };
}
