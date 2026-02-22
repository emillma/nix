{ config, pkgs, ... }:

{
  # This is technically redundant since plasma6.enable already sets this to true.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable Wayland for SDDM and configure HiDPI settings
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.settings = {
    Wayland = {
      EnableHiDPI = true;
    };
  };

  # Install SDDM-KCM to allow saving monitor layouts to the login screen
  environment.systemPackages = [ pkgs.kdePackages.sddm-kcm ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
