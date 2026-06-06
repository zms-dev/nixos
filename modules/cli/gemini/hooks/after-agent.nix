# after-agent — after-agent event hook configuration for gemini-cli
{ ... }:
{
  den.aspects.cli._.gemini-cli._.hooks._.after-agent = {
    includes = [ ];

    homeManager =
      { config, ... }:
      let
        hookPath = "gemini/hooks/after-agent.sh";
      in
      {
        home.file."${config.xdg.configHome}/${hookPath}" = {
          executable = true;
          text = ''
            #!/usr/bin/env bash
            # AfterAgent hook script
            exit 0
          '';
        };

        programs.gemini-cli.settings.hooks.AfterAgent = [
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
