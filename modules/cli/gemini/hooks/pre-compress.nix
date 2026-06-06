{ ... }:
{
  den.aspects.cli._.gemini-cli._.hooks._.pre-compress = {
    includes = [ ];

    homeManager =
      { config, ... }:
      let
        hookPath = "gemini/hooks/pre-compress.sh";
      in
      {
        home.file."${config.xdg.configHome}/${hookPath}" = {
          executable = true;
          text = ''
            #!/usr/bin/env bash
            # PreCompress hook script
            exit 0
          '';
        };

        programs.gemini-cli.settings.hooks.PreCompress = [
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
