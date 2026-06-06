# session-start — session-start event hook configuration for gemini-cli
{ ... }:
{
  den.aspects.cli._.gemini-cli._.hooks._.session-start = {
    includes = [ ];

    homeManager =
      { config, ... }:
      let
        hookPath = "gemini/hooks/session-start.sh";
      in
      {
        home.file."${config.xdg.configHome}/${hookPath}" = {
          executable = true;
          text = ''
            #!/usr/bin/env bash
            # SessionStart hook script
            exit 0
          '';
        };

        programs.gemini-cli.settings.hooks.SessionStart = [
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
