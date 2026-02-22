{
  description = "Emil's NixOS System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    zed.url = "github:zed-industries/zed";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, zed, ... }@inputs: {
    nixosConfigurations.workstation = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        inputs.catppuccin.nixosModules.catppuccin
        ./machines/workstation/default.nix
      ];
    };
  };
}
