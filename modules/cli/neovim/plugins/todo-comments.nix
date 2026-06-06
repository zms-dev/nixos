{ ... }:
{
  den.aspects.cli._.neovim._.plugins._.todo-comments = {
    includes = [ ];

    homeManager =
      { ... }:
      {
        programs.nixvim.plugins.todo-comments = {
          enable = true;
          lazyLoad = {
            enable = true;
            settings.event = [
              "BufReadPost"
              "BufNewFile"
              "BufWritePre"
            ];
          };
        };
      };
  };
}
