/*
  Material Icons — Google's Material Design icon set as a ligature glyph font
  https://github.com/google/material-design-icons
*/
{ ... }:
{
  den.aspects.fonts._.material-icons = {
    nixos =
      { pkgs, ... }:
      {
        fonts.packages = [
          pkgs.material-icons
        ];
      };
  };
}
