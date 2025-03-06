{
  description = "NixOS System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Ideally using nixos-unstable since my configuration
    # is based off of this channel.

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    linuxware = {
      url = "github:wizardlink/linuxware";
      inputs.nixpkgs.follows = "nixpkgs"; # Pin to your local `nixpkgs` if you use the unstable channel.
    };
  };

  outputs =
    {
      home-manager,
      nixpkgs,
      linuxware,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      your-hostname-here =
        let
          specialArgs = inputs;
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = inputs;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.wizardlink = import ./home-manager.nix;
            }
            linuxware.nixosModules.hyprland
          ];
        in
        nixpkgs.lib.nixosSystem { inherit system specialArgs modules; };
    };
}
