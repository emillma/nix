{ pkgs, ... }:

{
  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Nix settings
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Core system services
  services.printing.enable = true;
  programs.firefox.enable = true;
  programs.dconf.enable = true;
  programs.droidcam.enable = true;
  # ComfyUI - Node-based Stable Diffusion UI (via comfyui-nix NixOS module)
  services.comfyui.enable = true;

  # Add comfyui-cuda to system packages from overlay
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    gcc
    cudaPackages_13.cudatoolkit
    solaar
    htop
    nvtopPackages.nvidia
    comfyui-cuda
    vulkan-tools
  ];

  # Fonts
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
  ];

  # Logitech & Solaar configuration
  hardware.logitech.wireless.enable = true;

  # Fix Solaar permissions for settings and Wayland
  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", OPTIONS+="static_node=uinput", MODE="0660", GROUP="uinput"
  '';

  # Create the uinput group
  users.groups.uinput = { };

  # Ensure the solaar package and udev rules are correctly linked
  services.udev.packages = with pkgs; [ solaar ];
}
