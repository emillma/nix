{
  description = "Emil's NixOS System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    bambu-flatpak.url = "path:./bambu-flatpak";
    comfyui-nix.url = "github:utensils/comfyui-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      comfyui-nix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      comfyuiOverlay = final: prev: {
        comfyui-cuda = inputs.comfyui-nix.packages.${final.system}.cuda or null;
      };

      allPackages = pkgs.lib.recursiveUpdate inputs.comfyui-nix.packages.${system} {
        inherit (pkgs) python3 pixi;
      };
    in
    {
      nixosConfigurations.workstation = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          inputs.catppuccin.nixosModules.catppuccin
          inputs.bambu-flatpak.nixosModules.default
          comfyui-nix.nixosModules.default
          ./machines/workstation/default.nix
          { nixpkgs.overlays = [ comfyuiOverlay ]; }
        ];
      };

      packages.${system} = allPackages;

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.python3
          pkgs.pixi
        ];
      };
    };
}
