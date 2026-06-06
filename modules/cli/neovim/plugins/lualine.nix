/*
  neovim: plugins — statusline
  lualine.nvim: fast statusline with mode, branch, diff, diagnostics segments
  https://github.com/nvim-lualine/lualine.nvim
*/
{ ... }:
{
  den.aspects.cli._.neovim._.plugins._.lualine = {
    homeManager =
      { ... }:
      {
        programs.nixvim.plugins.lualine = {
          enable = true;
          lazyLoad = {
            enable = true;
            settings.event = "DeferredUIEnter";
          };
          settings = {
            sections = {
              lualine_a = [
                "mode"
              ];
              lualine_b = [
                "branch"
              ];
              lualine_c = [
                "filename"
                "diff"
              ];
              lualine_x = [
                "diagnostics"
                "encoding"
              ];
              lualine_y = [
                "fileformat"
              ];
              lualine_z = [
                "filetype"
              ];
            };
          };
        };
      };
  };
}
