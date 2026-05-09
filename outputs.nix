{
  self,
  inputs,
  lib,
  ...
}:
{
  flake = {
    nixosConfigurations = {
      apollo = lib.nixosSystem {
        modules = [
          ./hosts/mene/configuration.nix
          ./hosts/mene/laptop/laptop.nix
          ./hosts/mene/laptop/hardware-configuration.nix
        ];
      };

      apollopc = lib.nixosSystem {
        modules = [
          ./hosts/mene/configuration.nix
          ./hosts/mene/desktop/desktop.nix
          ./hosts/mene/desktop/hardware-configuration.nix

        ];
      };
    };

    homeConfigurations."mene@apollo" = inputs.home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = { inherit inputs; };
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        ./hosts/mene/home.nix
      ];
    };
  };

  systems = [ "x86_64-linux" ];
}
