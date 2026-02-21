{ config, pkgs, ... }:

{
  home.username = "emil";
  home.homeDirectory = "/home/emil";

  # Home Manager state version (matches system version)
  home.stateVersion = "25.11";

  # Manage Zed keybindings via XDG config
  xdg.configFile."zed/keymap.json".text = builtins.toJSON [
    {
      "context" = "Workspace";
      "bindings" = { };
    }
    {
      "context" = "Editor && vim_mode == insert";
      "bindings" = { };
    }
    {
      "context" = "Terminal";
      "bindings" = {
        "ctrl-c" = "terminal::Copy";
        "ctrl-v" = "terminal::Paste";
        "ctrl-shift-c" = [ "terminal::SendKeystroke" "ctrl-c" ];
      };
    }
  ];

  # Basic Home Manager setup
  programs.home-manager.enable = true;
}
