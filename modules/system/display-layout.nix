{ config, pkgs, ... }:

{
  # This module ensures that the monitor layout (rotation, primary display, etc.)
  # configured by the user 'emil' is also applied to the GDM login screen.
  #
  # How it works:
  # 1. Set up your monitors in GNOME Settings -> Displays.
  # 2. This script copies your ~/.config/monitors.xml to GDM's home folder.

  system.activationScripts.gdm-monitors = {
    text = ''
      if [ -f /home/emil/.config/monitors.xml ]; then
        mkdir -p /var/lib/gdm/.config
        cp /home/emil/.config/monitors.xml /var/lib/gdm/.config/monitors.xml
        chown gdm:gdm /var/lib/gdm/.config/monitors.xml
      fi
    '';
  };
}
