{ config, pkgs, ... }:

{
  imports = [
    ./helix.nix
    ./git.nix
    ./podman.nix
    ./packages.nix
    ./bash.nix
    ./autostart.nix
  ];
  
  home.username = "fluffypal";
  home.homeDirectory = "/home/fluffypal";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  programs.home-manager.enable = true;
}
