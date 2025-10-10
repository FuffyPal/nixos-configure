{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.fluffypal = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
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
    };
  };
}
