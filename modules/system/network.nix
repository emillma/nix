{ ... }:

{
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  networking.wireless.iwd = {
    enable = true;
    settings = {
      General = {
        AddressRandomization = "network";
        # Lowering RoamThreshold (e.g., -75) makes the device stay connected
        # to the current AP longer before attempting to roam.
        RoamThreshold = -75;
      };
      Rank = {
        # Setting the 2.4GHz band modifier to 0.0 effectively disables
        # the band for scanning, connecting, and roaming.
        # We include multiple naming conventions used by different iwd versions.
        "BandModifier2.4GHz" = 0.0;
        "BandModifier2.4Ghz" = 0.0;
        BandModifier24GHz = 0.0;
        BandModifier24Ghz = 0.0;
        # Increase preference for 5GHz band significantly.
        BandModifier5GHz = 10.0;
        BandModifier5Ghz = 10.0;
      };
    };
  };
}
