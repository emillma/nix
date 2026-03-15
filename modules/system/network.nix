{ ... }:

{
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  networking.firewall.allowedTCPPorts = [ 13618 ];

  networking.wireless.iwd = {
    enable = true;
    settings = {
      General = {
        AddressRandomization = "network";
        RoamThreshold = -75;
      };
      Rank = {
        # Prioritize 5GHz band and de-prioritize 2.4GHz to reduce interference
        "BandModifier2.4GHz" = 0.0;
        "BandModifier2.4Ghz" = 0.0;
        "BandModifier5GHz" = 10.0;
        "BandModifier5Ghz" = 10.0;
      };
    };
  };
}
