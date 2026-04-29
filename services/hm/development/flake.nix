{
  description = "my enviroment flake for development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      devShells.${system} = {
        fullstackdev = pkgs.mkShell {
          buildInputs = with pkgs; [
            nodejs
            bun
            typescript
          ];
        };

        javadev = pkgs.mkShell {
          buildInputs = with pkgs; [
            javaPackages.compiler.openjdk25
            maven
            gradle
          ];
        };

        mobiledev = pkgs.mkShell {
          buildInputs = with pkgs; [
            flutter
            javaPackages.compiler.openjdk17
            android-tools
          ];
        };

        rustdev = pkgs.mkShell {
          buildInputs = with pkgs; [
            rustc
            cargo
          ];
        };
      };
    }; 
}
