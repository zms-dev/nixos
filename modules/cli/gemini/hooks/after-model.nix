{ ... }:
{
  den.aspects.cli._.gemini-cli._.hooks._.after-model = {
    includes = [ ];

    homeManager =
      { config, ... }:
      let
        hookPath = "gemini/hooks/after-model.sh";
      in
      {
        home.file."${config.xdg.configHome}/${hookPath}" = {
          executable = true;
          text = ''
            #!/usr/bin/env bash
            # AfterModel hook script
            exit 0
          '';
        };

        programs.gemini-cli.settings.hooks.AfterModel = [
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
