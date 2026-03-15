{
  description = "Emil's NixOS System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    bambu-flatpak.url = "path:./bambu-flatpak";
  };

  outputs =
    { nixpkgs, ... }@inputs:
    {
      nixosConfigurations.workstation = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          inputs.catppuccin.nixosModules.catppuccin
          inputs.bambu-flatpak.nixosModules.default
          ./machines/workstation/default.nix
        ];
      };
    };
}
