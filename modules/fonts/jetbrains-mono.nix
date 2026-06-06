/*
  JetBrains Mono — monospace typeface by JetBrains designed for code readability; patched as a Nerd Font for icon glyphs
  https://github.com/JetBrains/JetBrainsMono
*/
{ ... }:
{
  den.aspects.fonts._.jetbrains-mono = {
    nixos =
      { pkgs, ... }:
      {
        fonts.packages = [
          pkgs.nerd-fonts.jetbrains-mono
          pkgs.jetbrains-mono
        ];
      };
  };
}
