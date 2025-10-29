{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }:
  let
    user = "fluffypal";
    system = "x86_64-linux";
    stateVersion = "25.05";
    hostname = "nixos";

    username = "USERNAME";
    passwordHash = "PASSWORD_HASH";

    gitUsername = "GIT_USERNAME";
    gitUseremail = "GIT_USEREMAIL";
  in
  nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
    system = system;

    specialArgs = {
      hostname = hostname;
      system = system;
      stateVersion = stateVersion;

      username = username;
      passwordHash = passwordHash;
      gitUsername = gitUsername;
      gitUseremail = gitUseremail;
    };
    modules = [
            {
              system.stateVersion = stateVersion;
            }
            home-manager.nixosModules.home-manager

            ./configuration.nix
            ./home.nix

            ./hardware-configuration.nix
            ./boot.nix
            ./user.nix
            ./gnome-desktop.nix
            ./key-remap.nix
            ./system-packages.nix
            ./system-settings.nix

          ];
}
