{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-treesitter.url = "github:ratson/nix-treesitter";
  };

  outputs =
    {
      self,
      nixpkgs,
      zen-browser,
      fenix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      hostnames = [
        "knicks-os"
        "skull"
        "beast-jr"
        "super-beast-lx"
        "launchpad-9"
      ];

      mkSys =
        hostName:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit hostName inputs fenix; };
          modules = [
            ./configuration.nix
            (./hosts + "/${hostName}/hardware-configuration.nix")
            inputs.home-manager.nixosModules.home-manager

            {
              home-manager.useGlobalPkgs = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.useUserPackages = true;
            }
          ];
        };
    in
    {
      nixosConfigurations = nixpkgs.lib.genAttrs hostnames (name: mkSys name);
    };
}
