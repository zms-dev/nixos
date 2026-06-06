{ ... }:
{
  den.aspects.cli._.neovim._.plugins._.snacks._.dashboard = {
    homeManager =
      { ... }:
      {
        programs.nixvim.plugins.snacks.settings.dashboard = {
          enabled = true;
          preset = {
            # Dashboard header string.
            header =
              let
                header_strings = [
                  "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗"
                  "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║"
                  "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║"
                  "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║"
                  "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║"
                  "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝"
                ];
              in
              builtins.concatStringsSep "\n" header_strings;

            # Key actions to show in the keys section.
            keys = [
              {
                icon = " ";
                key = "f";
                desc = "Find file";
                action = ":lua Snacks.dashboard.pick('files')";
              }
              {
                icon = " ";
                key = "g";
                desc = "Find text";
                action = ":lua Snacks.dashboard.pick('live_grep')";
              }
              {
                icon = " ";
                desc = "Open file explorer";
                padding = 1;
                key = "e";
                action = ":lua Snacks.explorer()";
              }
              {
                icon = " ";
                key = "n";
                desc = "New file";
                action = ":ene";
              }
              {
                icon = " ";
                key = "q";
                desc = "Quit";
                action = ":qa";
              }
            ];
          };

          sections = [
            {
              section = "header";
              padding = 3;
            }
            {
              section = "keys";
              gap = 1;
              padding = 1;
            }
            {
              text = {
                __unkeyed.__raw = ''
                  string.format(
                    "Neovim %d.%d.%d",
                    vim.version().major,
                    vim.version().minor,
                    vim.version().patch
                  )
                '';
                hl = "SnacksDashboardFooter";
                align = "center";
              };
              padding = 3;
            }
          ];
        };
      };
  };
}
