{ config, pkgs, ... }:

{
  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "lavender";

    sddm.enable = true;
    tty.enable = true;
  };
}
