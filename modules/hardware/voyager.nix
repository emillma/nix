{ config, pkgs, ... }:

{
  # Enable support for ZSA keyboards (Voyager, Moonlander, Ergodox EZ)
  # This automatically installs the necessary udev rules (zsa-udev-rules)
  # which allow for flashing and communication with the keyboard without root.
  hardware.keyboard.zsa.enable = true;

  # Optional: Add utility packages for ZSA keyboards if they are available in nixpkgs
  environment.systemPackages = with pkgs; [
    # keymapp is the official ZSA tool for live-remapping and flashing
    # Note: Some versions of nixpkgs might not have it yet or it might be unfree
  ];
}
