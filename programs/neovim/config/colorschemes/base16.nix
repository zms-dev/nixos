{config, lib, pkgs, ... }:

{
  programs.nixvim.colorschemes.base16 = {
    enable = true;
    customColorScheme =
        lib.concatMapAttrs (name: value: {
          ${name} = "#${value}";
        })
        config.colorScheme.palette;
    setUpBar = true;
    useTruecolor = true;
  };
}
