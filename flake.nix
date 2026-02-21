{
  description = "Emil's NixOS System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    zed.url = "github:zed-industries/zed";
  };

  outputs = { self, nixpkgs, zed, ... }@inputs: {
    nixosConfigurations.workstation = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./machines/workstation/default.nix
      ];
    };
  };
}
