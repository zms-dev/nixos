/*
  jq — lightweight command-line JSON processor with a functional query language
  https://github.com/jqlang/jq
*/
{ ... }:
{
  den.aspects.cli._.jq = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.jq ];
      };
  };
}
