{
  description = "Akiva's flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
  nixosConfigurations.default = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
      modules = [
       /etc/nixos/configuration.nix
        ./system.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
