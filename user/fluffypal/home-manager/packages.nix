{ config , pkgs , ... }:

{
  home.packages = with pkgs; [
    rust-analyzer
    steam-devices-udev-rules
    conda
    lolcat
    nextcloud-client
    helix
  ];
}
