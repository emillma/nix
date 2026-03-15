{ config, pkgs, ... }:

{
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # Increase the quantum (buffer size) to reduce Bluetooth audio jitter.
    # The default quantum of 1024 frames (~21ms at 48kHz) is often too tight
    # for Bluetooth's wireless transmission, causing audible breaks. Doubling it
    # gives more headroom at the cost of slightly higher latency.
    extraConfig.pipewire."10-clock-settings" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 2048;
        "default.clock.min-quantum" = 1024;
        "default.clock.max-quantum" = 8192;
      };
    };

    # High-quality Bluetooth audio settings
    wireplumber.extraConfig = {
      "10-bluetooth-policy" = {
        "wireplumber.settings" = {
          "bluetooth.autoswitch-to-headset-profile" = false;
        };
      };
      "11-bluetooth-codecs" = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = [
            "a2dp_sink"
            "a2dp_source"
            "bap_sink"
            "bap_source"
            "hfp_hf"
            "hfp_ag"
          ];
        };
      };
      # Prevent Bluetooth audio nodes from suspending when idle.
      # The default suspend-then-resume cycle causes audible glitches at the
      # start of playback after a pause (e.g. between tracks).
      "12-bluetooth-no-suspend" = {
        "monitor.bluez.rules" = [
          {
            matches = [ { "node.name" = "~bluez_*"; } ];
            actions = {
              "update-props" = {
                "session.suspend-timeout-seconds" = 0;
              };
            };
          }
        ];
      };
    };
  };
}
