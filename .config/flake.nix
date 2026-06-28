{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    agenix.url = "github:ryantm/agenix"; 

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, zen-browser, agenix, ... }@inputs:
  let
    system = "x86_64-linux";
    hostnames =  [ "knicks-os" "skull" "beast-jr" "super-beast-lx" "launchpad-9" ];

    mkSys = hostName: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit hostName inputs; };
      modules = [
        ./configuration.nix
        (./hosts + "/${hostName}/hardware-configuration.nix")
        inputs.home-manager.nixosModules.home-manager
        agenix.nixosModules.default

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
      ];
    };
  in {
    nixosConfigurations = nixpkgs.lib.genAttrs hostnames (name: mkSys name);
  };
}
