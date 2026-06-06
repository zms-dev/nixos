/*
  fzf — general-purpose fuzzy finder for files, history, and shell completions
  https://github.com/junegunn/fzf
*/
{ ... }:
{
  den.aspects.cli._.fzf = {
    homeManager =
      { config, ... }:
      {
        programs.fzf = {
          enable = true;
          enableZshIntegration = config.programs.zsh.enable;
        };

        programs.zsh.shellAliases = { };
      };
  };
}
