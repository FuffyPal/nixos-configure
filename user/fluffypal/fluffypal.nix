{ config , ... }:
{
  users.users.fluffypal = {
    isNormalUser = true;
    description = "FluffyPal";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
}
