{ config, pkgs, ... }:

{
  # Import your modules here
  # imports = [
  #   ./modules/hardware-configuration.nix
  # ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Timezone
  time.timeZone = "Europe/Istanbul";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_MEASUREMENT = "tr_TR.UTF-8";
    LC_MONETARY = "tr_TR.UTF-8";
    LC_NAME = "tr_TR.UTF-8";
    LC_NUMERIC = "tr_TR.UTF-8";
    LC_PAPER = "tr_TR.UTF-8";
    LC_TELEPHONE = "tr_TR.UTF-8";
    LC_TIME = "tr_TR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fluffypal = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh; # Example shell
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    htop
    zsh
    # Add any other core utilities you need
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on an existing system were taken. It‘s currently the NixOS 23.11 release.
  # Changing this value and running a NixOS system update (by running
  # `nixos-rebuild switch --flake .#nixos`) will cause all applied modules to be
  # re-evaluated with the new settings in mind. Your system will not start if
  # you change this value and don't rebuild your system.
  #
  # If you change this from the current system to another system, we strongly
  # recommend you to first create a backup of your data before doing so.
  #
  # The elegant way to do this is to set the value to 23.11 for the current
  # system and then, on a subsequent update, change it to 24.05 (or whatever
  # your target release is).
  #
  # You can also get a more fine-grained update path by specifying the `id`
  # and `revision` attributes separately, e.g.
  #
  # system.stateVersion = {
  #   id = "23.11";
  #   revision = "999";
  # };
  #
  # This makes sure that your system is up-to-date with a specific revision of
  # the 23.11 release.
  #
  # Refer to the NixOS release notes for more information.
  system.stateVersion = "23.11"; # Did you read the comment?

  # The example below uses a more recent stateVersion, targeting 24.05.
  # Be careful when changing this!
  # system.stateVersion = "24.05";
}
