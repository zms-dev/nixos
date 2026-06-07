# before-model — before-model event hook configuration for gemini-cli
{ ... }:
{
  den.aspects.cli._.gemini-cli._.hooks._.before-model = {
    includes = [ ];

    homeManager =
      { config, ... }:
      let
        hookPath = "gemini/hooks/before-model.sh";
      in
      {
        home.file."${config.xdg.configHome}/${hookPath}" = {
          executable = true;
          text = ''
            #!/usr/bin/env bash
            # BeforeModel hook script
            exit 0
          '';
        };

        programs.gemini-cli.settings.hooks.BeforeModel = [
          {
            hooks = [
              {
                type = "command";
                command = "${config.xdg.configHome}/${hookPath}";
              }
            ];
          }
        ];
      };
  };
}
