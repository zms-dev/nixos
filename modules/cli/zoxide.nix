/*
  zoxide — smarter cd that tracks frecency (frequency + recency) and fuzzy-matches directory history
  https://github.com/ajeetdsouza/zoxide
*/
{ ... }:
{
  den.aspects.cli._.zoxide = {
    homeManager =
      { config, ... }:
      {
        programs.zoxide = {
          enable = true;
          enableZshIntegration = config.programs.zsh.enable;
          options = [ "--cmd cd" ];
        };
      };
  };
}
