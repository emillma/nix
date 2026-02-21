{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Reduce top bar size and UI scaling
  services.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.shell]
    enabled-extensions=['tilingshell@ferrarodomenico.com', 'just-perfection-desktop@just-perfection']

    [org.gnome.shell.extensions.just-perfection]
    panel-size=24

    [org.gnome.desktop.interface]
    text-scaling-factor=0.9
  '';

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
