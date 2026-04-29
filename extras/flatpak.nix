{ 
  config, 
  pkgs, 
  ...}: 
  {
  
  services = {
    flatpak = {
      enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;

    extraPortals = [ 
      pkgs.xdg-desktop-portal 
      pkgs.xdg-desktop-portal-gtk 
    ];
    
    config = {
      common = {
        default = "*";
      };
    };
  };
}