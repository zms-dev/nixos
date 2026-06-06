# before-tool — before-tool event hook configuration for gemini-cli
{ ... }:
{
  den.aspects.cli._.gemini-cli._.hooks._.before-tool = {
    includes = [ ];

    homeManager =
      { config, ... }:
      let
        hookPath = "gemini/hooks/before-tool.sh";
      in
      {
        home.file."${config.xdg.configHome}/${hookPath}" = {
          executable = true;
          text = ''
            #!/usr/bin/env bash
            # BeforeTool hook script
            exit 0
          '';
        };

        programs.gemini-cli.settings.hooks.BeforeTool = [
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
