{ config, pkgs, ... }:

{
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  # Optionally add other networking defaults here
  # networking.firewall.enable = true;
}
