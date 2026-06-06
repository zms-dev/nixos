{ ... }:
{
  den.aspects.cli._.gemini-cli._.hooks._.before-agent = {
    includes = [ ];

    homeManager =
      { config, ... }:
      let
        hookPath = "gemini/hooks/before-agent.sh";
      in
      {
        home.file."${config.xdg.configHome}/${hookPath}" = {
          executable = true;
          text = ''
            #!/usr/bin/env bash
            # BeforeAgent hook script
            exit 0
          '';
        };

        programs.gemini-cli.settings.hooks.BeforeAgent = [
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
