{
  description = "my enviroment flake for development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    { self, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      perSystem =
        { pkgs, ... }:
        {
          devShells = {
            typescript = pkgs.mkShell {
              packages = with pkgs; [
                nodejs
                bun
                typescript
                typescript-language-server
              ];
            };

            java = pkgs.mkShell {
              packages = with pkgs; [
                javaPackages.compiler.openjdk21
                maven
                gradle
              ];
            };

            flutter = pkgs.mkShell {
              packages = with pkgs; [
                javaPackages.compiler.openjdk17
                flutter
                android-tools
              ];
            };

            rust = pkgs.mkShell {
              packages = with pkgs; [
                rustc
                cargo
                rust-analyzer
              ];
            };
          };
        };
      systems = [ "x86_64-linux" ];
    };
}
