{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-flake.url = "github:sodiboo/niri-flake";
    lazygit.url = "github:jesseduffield/lazygit";
  };
  
  nixConfig = {
    extra-substituters = [
      "https://niri.cachix.org"
    ];
    extra-trusted-public-keys = [
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    ];
  };
  
  outputs = { self, nixpkgs, home-manager, ... }@ inputs: {
    nixosConfigurations = {
      apollo = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          ./hosts/mene/configuration.nix
          ./hosts/mene/laptop/laptop.nix
          ./hosts/mene/laptop/hardware-configuration.nix
        ];
      }; 

      apollopc = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          ./hosts/mene/configuration.nix
          ./hosts/mene/desktop/desktop.nix
        ];
      };
    };
 
    homeConfigurations."mene@apollo" = home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = {inherit inputs;};
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        ./hosts/mene/home.nix
      ];
    };
  };
}
