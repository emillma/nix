{
  description = "Bambu Studio Flatpak Integration using nix-flatpak";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-flatpak,
    }:
    {
      nixosModules.default =
        { config, pkgs, ... }:
        {
          imports = [
            nix-flatpak.nixosModules.nix-flatpak
          ];

          services.flatpak = {
            enable = true;
            remotes = [
              {
                name = "flathub";
                location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
              }
            ];
            packages = [
              "com.bambulab.BambuStudio"
            ];
            update.auto = {
              enable = true;
              onCalendar = "weekly";
            };
          };

          # Ensure XDG portals are enabled for Flatpak to work correctly
          xdg.portal = {
            enable = true;
            extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
            config.common.default = "*";
          };

          # Create a convenient wrapper script to run it from terminal
          environment.systemPackages = [
            (pkgs.writeShellScriptBin "bambu-studio-flatpak" ''
              flatpak run com.bambulab.BambuStudio "$@"
            '')
          ];
        };
    };
}
