{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Disable Bluetooth USB autosuspend to prevent headset/mouse jitter
  boot.kernelParams = [ "btusb.enable_autosuspend=0" ];
}
