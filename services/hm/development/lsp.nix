{
  pkgs,
  ...
}: {
    home.packages = with pkgs; [
      # LSPs
      nixd
      typescript-language-server
      rust-analyzer
      jdt-language-server
      vscode-css-languageserver
      vscode-json-languageserver
      superhtml
    ];
  }
    
