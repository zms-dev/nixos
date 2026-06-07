# after-tool — after-tool event hook configuration for gemini-cli
{ ... }:
{
  den.aspects.cli._.gemini-cli._.hooks._.after-tool = {
    includes = [ ];

    homeManager =
      { config, ... }:
      let
        hookPath = "gemini/hooks/after-tool.sh";
      in
      {
        home.file."${config.xdg.configHome}/${hookPath}" = {
          executable = true;
          text = ''
            #!/usr/bin/env bash
            # AfterTool hook script
            exit 0
          '';
        };

        programs.gemini-cli.settings.hooks.AfterTool = [
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
