{
  description = "Highly modular NixOS flake configuration for 25.05 with Home Manager and Podman testing support.";

  inputs = {
    # Nixpkgs stable channel for NixOS 25.05 (assuming it's available or will be soon)
    # If 25.05 is not yet a stable release, consider "nixos-unstable" or "nixos-24.05"
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Home Manager stable channel for 25.05, follows nixpkgs
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Optional: nixos-hardware for specific hardware configurations
    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Optional: For impermanence setup
    # impermanence.url = "github:ryantm/impermanence";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      # Systems supported by this flake
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];

      # Function to define a NixOS configuration
      # It takes the system architecture, hostname, and an optional list of modules
      mkNixosConfiguration = system: hostname: extraModules:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            # You can pass global variables here to all modules
            # e.g., configDir = ./.;
          };
          modules = [
            # Common system modules
            ./modules/system # Basic system settings

            # Host-specific configuration
            (./hosts + "/${hostname}/configuration.nix")

            # Home Manager integration as a NixOS module
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              # Import user-specific Home Manager configurations from the host's home directory
              # Expects a directory like ./home/my-nixos/default.nix which then imports individual user configs
              home-manager.users = import (./home + "/${hostname}");
            }
          ] ++ extraModules;
        };

    in
    {
      # NixOS system configurations
      nixosConfigurations = {
        # Example configuration for 'my-nixos' host
        my-nixos = mkNixosConfiguration "x86_64-linux" "my-nixos" [ ];

        # You can add more hosts here, for example:
        # my-laptop = mkNixosConfiguration "x86_64-linux" "my-laptop" [
        #   ./modules/hardware/laptop-specific.nix
        # ];
        # my-server = mkNixosConfiguration "x86_64-linux" "my-server" [
        #   ./modules/server-roles/database.nix
        #   ./modules/server-roles/webserver.nix
        # ];
      };

      # Developer shell for testing with Podman (NixOS container)
      devShells = {
        # For x86_64-linux system
        x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.mkShell {
          packages = with nixpkgs.legacyPackages.x86_64-linux; [
            nixos-container # Tool to manage NixOS containers
            # Add any other development tools you might need here, e.g., git, direnv
          ];

          shellHook = ''
            echo "You are in a development shell for NixOS container management."
            echo "To create a NixOS container for 'my-nixos' host:"
            echo "  nixos-container create my-test-container --flake .#my-nixos"
            echo "To start/enter the container:"
            echo "  nixos-container start my-test-container"
            echo "  nixos-container enter my-test-container"
            echo "To destroy the container:"
            echo "  nixos-container destroy my-test-container"
            echo "Note: Podman must be running and configured to allow rootless containers (if applicable)."
          '';
        };

        # For aarch64-linux system (if you have one)
        aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.mkShell {
          packages = with nixpkgs.legacyPackages.aarch64-linux; [
            nixos-container
          ];
          shellHook = ''
            echo "You are in a development shell for NixOS container management on AArch64."
          '';
        };
      };
    };
}
