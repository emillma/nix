{ pkgs, ... }:

{
  # Enable gnome-keyring for secret storage
  services.gnome.gnome-keyring.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.settings.Wayland.EnableHiDPI = true;
  services.desktopManager.plasma6.enable = true;

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";

    # Tell Electron/Chromium apps to use Wayland natively (Hyprland Nvidia guide)
    NIXOS_OZONE_WL = "1";

    # Use direct backend for VA-API hardware video acceleration with Nvidia
    NVD_BACKEND = "direct";
  };

  environment.systemPackages = with pkgs; [
    kdePackages.sddm-kcm
    seahorse # GUI for managing the keyring
  ];

  # Configure keymap
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
