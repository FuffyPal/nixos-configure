{ config, pkgs, ... }:
{
  services.xserver.displayManager.gdm.autoLogin.delay = 2;
  services.displayManager.autoLogin = {
    user = "fluffypal";
    enable = true;
  };
}
