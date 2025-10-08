{ config,  ... }:
{
  networking = {
    hostName = "any";
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.macAddress = "random";
      wifi.powersave = true;
      wifi.backend = "wpa_supplicant";
      ethernet.macAddress = "random";
    };
  };
}

