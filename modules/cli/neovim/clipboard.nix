# neovim: clipboard — clipboard provider and register integration (system clipboard via wl-clipboard)
{ den, ... }:
{
  den.aspects.cli._.neovim._.clipboard = {
    includes = [ den.aspects.cli._.clipboard ];

    homeManager =
      { ... }:
      {
        programs.nixvim.clipboard = {
          providers = {
            wl-copy.enable = true; # For Wayland
            xsel.enable = true; # For X11
          };

          # Sync clipboard between OS and Neovim
          #  Remove this option if you want your OS clipboard to remain independent.
          register = "unnamedplus";
        };
      };
  };
}
