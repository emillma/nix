{ pkgs, ... }:

{
  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Firefox
  programs.firefox.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
  ];

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
  ];
}
