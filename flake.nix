{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    niri-flake.url = "github:sodiboo/niri-flake";
    lazygit.url = "github:jesseduffield/lazygit";
    alejandra.url = "github:kamadorueda/alejandra/4.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  nixConfig = {
    extra-substituters = [
      "https://niri.cachix.org"
      "https://cache.garnix.io"
    ];
    extra-trusted-public-keys = [
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };
  
  outputs = {
    self,
    nixpkgs,
    home-manager,
    alejandra,
    ...
  }@ inputs:
  {
    nixosConfigurations = {
      apollo = nixpkgs.lib.nixosSystem rec {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          ./hosts/mene/configuration.nix
          ./hosts/mene/laptop/laptop.nix
          ./hosts/mene/laptop/hardware-configuration.nix
        
          {
            environment.systemPackages = [
              alejandra.defaultPackage.${system}
            ];
          }
        ];
      }; 

      apollopc = nixpkgs.lib.nixosSystem rec {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          ./hosts/mene/configuration.nix
          ./hosts/mene/desktop/desktop.nix
          ./hosts/mene/desktop/hardware-configuration.nix

          {
            envorinment.systemPackages = [
              alejandra.defaultPackage.${system}
            ];
          }
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
