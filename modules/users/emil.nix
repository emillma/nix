{ config, pkgs, inputs, ... }:

{
  users.users.emil = {
    isNormalUser = true;
    description = "emil";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      google-chrome
      inputs.zed.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };

  # Enable nix-ld for user's needs (like Zed language servers)
  programs.nix-ld.enable = true;

  # System-wide packages including GNOME extensions
  environment.systemPackages = with pkgs; [
    git
    gnome-extension-manager
    gnome-tweaks
    gnomeExtensions.tiling-shell
    gnomeExtensions.just-perfection
  ];
}
