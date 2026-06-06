# neovim: extra-files — additional runtime files injected into the Neovim config directory
{ ... }:
{
  den.aspects.cli._.neovim._.extra-files = {
    homeManager =
      { ... }:
      {
        programs.nixvim.extraFiles = { };
      };
  };
}
