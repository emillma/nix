{ config, pkgs, inputs, ... }:

{
  users.users.emil = {
    isNormalUser = true;
    description = "emil";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      google-chrome
      inputs.zed.packages.${pkgs.stdenv.hostPlatform.system}.default

      # GNOME Extensions and Manager
      gnome-extension-manager
      gnomeExtensions.tiling-shell
    ];
  };

  # Enable nix-ld for user's needs (like Zed language servers)
  programs.nix-ld.enable = true;

  # User specific system packages
  environment.systemPackages = with pkgs; [
    git
  ];
}
