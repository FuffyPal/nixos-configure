{ config , pkgs , ... }:
{
  users.users.fluffypal = {
    isNormalUser = true;
    description = "FluffyPal";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      helix
    ];
  };
}
