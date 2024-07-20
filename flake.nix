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

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    {
      home-manager,
      nixpkgs,
      catppuccin,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations."wizdesk" =
        let
          specialArgs = inputs;
          modules = [
            ./nixos.nix
            catppuccin.nixosModules.catppuccin
          ];
        in
        nixpkgs.lib.nixosSystem { inherit system specialArgs modules; };

      homeConfigurations.wizardlink = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = inputs;
        modules = [
          ./home-manager.nix
          catppuccin.homeManagerModules.catppuccin
        ];
      };

      formatter."${system}" = pkgs.nixfmt-rfc-style;
    };
}
