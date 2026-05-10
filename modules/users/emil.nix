{ pkgs, ... }:

{
  users.users.emil = {
    isNormalUser = true;
    description = "emil";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "uinput"
    ];
    packages = with pkgs; [
      google-chrome
      spotify
      zed-editor
      texlab
      texlive.combined.scheme-full
      zathura
      kdePackages.okular
      python3
      jq
      nil
      nixd
      nixfmt-rfc-style
      uv
      rustup
      pixi
      xdg-utils
      lmstudio
    ];
  };

  # Minimal nix-ld for unpatched dynamic binaries (LSPs, etc.)
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    openssl
    icu
    libxml2
    glib
    stdenv.cc.cc
    zlib
    fuse3
    icu
    nss
    openssl
    curl
    expat
    # Add hardware acceleration libs if using GPU
    libglvnd
    vulkan-loader
  ];

  environment.sessionVariables = {
    WEBKIT_DISABLE_COMPOSITING_MODE = "1";
    # Force Zed to use Vulkan (NVIDIA + Wayland requires this)
    GPUI_BACKEND = "Vulkan";
  };

  # 1Password & Auth
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "emil" ];
  };

  environment.variables.SSH_AUTH_SOCK = "/home/emil/.1password/agent.sock";

  # Global Git Identity
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "Emil Martens";
        email = "emil.martens@gmail.com";
      };
    };
  };
}
