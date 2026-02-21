{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Disable Bluetooth USB autosuspend and Realtek power management to prevent jitter and drops
  boot.kernelParams = [
    "btusb.enable_autosuspend=0"
    "rtw89_pci.disable_aspm_l1=y"
    "rtw89_pci.disable_aspm_l1ss=y"
    "rtw89_core.disable_ps_mode=y"
  ];
}
