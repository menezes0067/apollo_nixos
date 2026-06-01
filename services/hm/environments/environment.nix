{ 
  config, 
  pkgs, 
  inputs,
  ...
  } : 
  
  let
    dotfilePath = "/etc/nixos/services/hm/environments";

    apps = [
      "niri" 
      "waybar" 
      "fuzzel" 
      "helix" 
      "kitty"
      "zellij"
      "hypr"
    ];
    
  in{
  
  home.packages =  
    (with pkgs; [
      nautilus
      unzip
      networkmanagerapplet
      xdg-desktop-portal-gtk
      xdg-user-dirs
      kitty
      waypaper
      awww
      swaybg
      fuzzel
      waybar
      helix 
      bzmenu
      piper
      swappy
      grim
      slurp      

      cava
      cmatrix
      gamescope
    ]);
     
  
  xdg.configFile = builtins.listToAttrs (map (name: {
    name = name;
    value = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilePath}/${name}";
    };
  }) apps);
}
