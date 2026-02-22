{ config, pkgs, inputs, ... }:

{
  users.users.emil = {
    isNormalUser = true;
    description = "emil";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      google-chrome
      spotify
      inputs.zed.packages.${pkgs.stdenv.hostPlatform.system}.default
      texlab
      texlive.combined.scheme-full
    ];
  };

  # Enable nix-ld for user's needs (like Zed language servers)
  programs.nix-ld.enable = true;

  # Enable 1Password and 1Password-GUI with Polkit support
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "emil" ];
  };

  # Set SSH_AUTH_SOCK to use 1Password SSH agent
  environment.variables.SSH_AUTH_SOCK = "/home/emil/.1password/agent.sock";
}
