/*
  bat — cat clone with syntax highlighting and Git integration
  https://github.com/sharkdp/bat
*/
{ ... }:
{
  den.aspects.cli._.bat = {
    homeManager =
      { ... }:
      {
        programs.bat = {
          enable = true;
          config = {
            #theme = "TwoDark";
          };
        };

        programs.zsh.shellAliases = {
          cat = "bat";
        };
      };
  };
}
