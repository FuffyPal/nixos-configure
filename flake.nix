{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }:
  let
    inherit (nixpkgs.lib) nixosSystem;
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
  };
}
