{ 
  pkgs, 
  config, 
  inputs, 
  ...
}: {

  imports = [
    ../../services/hm/pkgs/default.nix
  
    ../../services/hm/environments/environment.nix
    ../../services/hm/development/lsp.nix
  ];

  home = {
    username = "mene";
    homeDirectory = "/home/mene";
    stateVersion = "25.11";
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
