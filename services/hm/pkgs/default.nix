{ 
  pkgs, 
  ...
  
  }: {

  imports = [ 
    ../fonts 
  ];

  home.packages = with pkgs; [
    
    #development 
    git
    zellij
    helix
    neovim
    yazi
    jetbrains.idea
    lazygit
    
    # common apps
    obsidian
    zathura
    
  ];


  # extra configs 
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "menezes0067";
        email = "menezes0067@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };
}
