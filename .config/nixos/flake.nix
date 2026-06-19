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
  };

  outputs = { self, nixpkgs, zen-browser, ... }@inputs: {
    nixosConfigurations = nixpkgs.lib.genAttrs [ "knicks-os" "skull" "beast-jr" "super-beast-lx" "launchpad-9" ] (hostName: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
      ./configuration.nix
      {
          networking.hostName = hostName;
      }

      inputs.home-manager.nixosModules.home-manager

      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.amcmillan = import ./amcmillan.nix;
      }
      ];
    });
  };
}
