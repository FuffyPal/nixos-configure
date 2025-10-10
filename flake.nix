{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    inherit (nixpkgs.lib) nixosSystem;
    userName = "default_user_name"; 
    userEmail = "default_user_email@example.com"; 

    fluffypalModules = [
      ./user/fluffypal/fluffypal.nix
      ./configuration.nix
      ./modules/network/network.nix
      ./modules/network/dns.nix
      ./modules/network/firewall.nix
      ./modules/desktop/gnome/gnome.nix
      ./modules/desktop/gnome/autologin.nix
      ./modules/system/boot/boot.nix
      ./modules/system/locale/locale.nix
      ./modules/system/xserver/xserver.nix
    ];
  in
  {
    nixosConfigurations = {
      fluffypal = nixosSystem {
        system = "x86_64-linux";
        modules = fluffypalModules;
      };
      fluffypal-nvidia = nixosSystem {
        system = "x86_64-linux";
        modules = fluffypalModules ++ [ ./modules/hardware/nvidia/nvidia.nix ];
      };
      fluffypal-nvidia-open = nixosSystem {
        system = "x86_64-linux";
        modules = fluffypalModules ++ [ ./modules/hardware/nvidia/nvidia-open-kernel.nix ];
      };
      fluffypal-nvidia-turing = nixosSystem {
        system = "x86_64-linux";
        modules = fluffypalModules ++ [ ./modules/hardware/nvidia/nvidia-turing.nix ];
      };
      fluffypal-nvidia-open-turing = nixosSystem {
        system = "x86_64-linux";
        modules = fluffypalModules ++ [ ./modules/hardware/nvidia/nvidia-turing-open-kernel.nix ];
      };
    };
    homeConfigurations = {
      fluffypal = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [ ./user/fluffypal/home-manager/home.nix ];
        specialArgs = {
          userName = userName;
          userEmail = userEmail;
        };
      };
    };
  };
}
