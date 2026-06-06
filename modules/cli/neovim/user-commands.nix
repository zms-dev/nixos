# neovim: user-commands — custom Ex commands defined via vim.api.nvim_create_user_command
{ ... }:
{
  den.aspects.cli._.neovim._.user-commands = {
    homeManager =
      { ... }:
      {
        programs.nixvim.userCommands = { };
      };
  };
}
