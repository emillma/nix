{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  # Optionally add other networking defaults here
  # networking.firewall.enable = true;
}
