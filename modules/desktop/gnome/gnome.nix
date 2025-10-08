{ config , pkgs , ... }:
{
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  services.displayManager.defaultSession = "gnome";
  services.xserver.desktopManager.gnome.enable = true;
  programs.nautilus-open-any-terminal.enable = true;
  programs.nautilus-open-any-terminal.terminal = "ptyxis";
  services.gnome.core-developer-tools.enable = false;
  services.xserver.desktopManager.gnome.flashback.enableMetacity = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    geary
    gnome-calculator
    gnome-calendar
    gnome-clocks
    gnome-contacts
    gnome-connections
    evince
    sushi
    totem
    gnome-maps
    snapshot
    simple-scan
    epiphany
    gnome-music
    kgx
    decibels
  ];
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    papirus-icon-theme
    ptyxis  
    adw-gtk3
    nautilus-open-any-terminal


    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    gnomeExtensions.caffeine
    gnomeExtensions.dash-to-dock
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.appindicator
    gnomeExtensions.color-picker
    gnomeExtensions.battery-health-charging
    gnomeExtensions.day-progress
    gnomeExtensions.gsconnect
    gnomeExtensions.media-controls
    gnomeExtensions.open-desktop-file-location
    gnomeExtensions.quick-settings-tweaker
    gnomeExtensions.wiggle
    gnomeExtensions.weather-oclock
    gnomeExtensions.bluetooth-battery-meter
    gnomeExtensions.compiz-windows-effect
    gnomeExtensions.tiling-shell
  ];
}
