{ config , pkgs , ... }:

{
  services.podman = {
    enable = true;
  };
}
