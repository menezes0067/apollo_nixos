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
    ];
    
  in{
  
  home.packages =  
    (with pkgs; [
      nautilus
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
      swaynotificationcenter
    ]) ++ (with inputs.niri-flake.packages.${pkgs.stdenv.hostPlatform.system}; [
      xwayland-satellite-stable
    ]); 

  xdg.portal = {
    enable = true;

    configPackages = [
      inputs.niri-flake.packages.${pkgs.stdenv.hostPlatform.system}.niri-stable
    ];

    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
    ];
  };

  xdg.configFile = builtins.listToAttrs (map (name: {
    name = name;
    value = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilePath}/${name}";
    };
  }) apps);
}
