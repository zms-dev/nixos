/*
  vscode-langservers-extracted — HTML/CSS/JSON/ESLint language servers extracted from VS Code
  https://github.com/hrsh7th/vscode-langservers-extracted
*/
{ ... }:
{
  den.aspects.dev._.vscode-langservers = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.vscode-langservers-extracted ];
      };
  };
}
