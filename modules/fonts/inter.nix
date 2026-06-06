/*
  Inter — humanist sans-serif typeface by Rasmus Andersson, optimized for UI text at small sizes on screens
  https://github.com/rsms/inter
*/
{ ... }:
{
  den.aspects.fonts._.inter = {
    nixos =
      { pkgs, ... }:
      {
        fonts.packages = [
          pkgs.inter
        ];
      };
  };
}
