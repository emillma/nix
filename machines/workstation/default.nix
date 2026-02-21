{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/system/boot.nix
      ../../modules/system/common.nix
      ../../modules/system/network.nix
      ../../modules/system/audio.nix
      ../../modules/system/display.nix
      ../../modules/hardware/nvidia.nix
      ../../modules/hardware/voyager.nix
      ../../modules/users/emil.nix
    ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  networking.hostName = "workstation";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "25.11";
}
