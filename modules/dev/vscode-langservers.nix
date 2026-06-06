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
