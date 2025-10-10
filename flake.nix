{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    inherit (nixpkgs.lib) nixosSystem;

    # These variables will be passed to all NixOS and Home Manager modules
    # via specialArgs.
    myUserName = "default_user_name"; # Kullanıcı adınızı buraya girin
    myUserEmail = "default_user_email@example.com"; # E-posta adresinizi buraya girin

    # Common NixOS modules for all fluffypal configurations
    fluffypalBaseModules = [
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

      # Home Manager as a NixOS module
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        # Import the main Home Manager configuration for fluffypal
        home-manager.users.fluffypal = import ./user/fluffypal/home-manager/home.nix;
      }
    ];

  in
  {
    nixosConfigurations = {
      fluffypal = nixosSystem {
        system = "x86_64-linux";
        modules = fluffypalBaseModules;
        specialArgs = { inherit myUserName myUserEmail; };
      };
      fluffypal-nvidia = nixosSystem {
        system = "x86_64-linux";
        modules = fluffypalBaseModules ++ [ ./modules/hardware/nvidia/nvidia.nix ];
        specialArgs = { inherit myUserName myUserEmail; };
      };
      fluffypal-nvidia-open = nixosSystem {
        system = "x86_64-linux";
        modules = fluffypalBaseModules ++ [ ./modules/hardware/nvidia/nvidia-open-kernel.nix ];
        specialArgs = { inherit myUserName myUserEmail; };
      };
      fluffypal-nvidia-turing = nixosSystem {
        system = "x86_64-linux";
        modules = fluffypalBaseModules ++ [ ./modules/hardware/nvidia/nvidia-turing.nix ];
        specialArgs = { inherit myUserName myUserEmail; };
      };
      fluffypal-nvidia-open-turing = nixosSystem {
        system = "x86_64-linux";
        modules = fluffypalBaseModules ++ [ ./modules/hardware/nvidia/nvidia-turing-open-kernel.nix ];
        specialArgs = { inherit myUserName myUserEmail; };
      };
    };
  };
}
