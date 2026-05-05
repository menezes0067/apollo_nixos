{
  pkgs,
  ...
}: {
    home.packages = with pkgs; [
      # LSPs
      nixd
      jdt-language-server
      vscode-css-languageserver
      vscode-json-languageserver
      superhtml
      
     #formatters
     nixfmt
    ];
  }
    
