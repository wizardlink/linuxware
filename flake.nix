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
  };

  outputs =
    { home-manager, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations."nixos" =
        let
          specialArgs = inputs;
          modules = [ ./nixos.nix ];
        in
        nixpkgs.lib.nixosSystem { inherit system specialArgs modules; };

      homeConfigurations.wizardlink = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = inputs;
        modules = [ ./home-manager.nix ];
      };

      formatter."${system}" = pkgs.nixfmt-rfc-style;
    };
}
