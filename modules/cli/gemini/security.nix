{ den, ... }:
{
  den.aspects.cli._.gemini-cli._.security = {
    includes = [ den.aspects.security._.sops ];

    homeManager =
      { config, ... }:
      {
        sops.secrets.gemini-api-key = { };

        sops.templates.gemini-api-key = {
          content = ''
            GEMINI_API_KEY=${config.sops.placeholder.gemini-api-key}
            GEMINI_AUTH_TYPE=identity-studio-api
            GEMINI_TRUST_WORKSPACE=true
          '';
          path = config.home.homeDirectory + "/.gemini/.env";
        };

        programs.gemini-cli.settings.security = {
          auth = {
            selectedType = "gemini-api-key";
            enforcedType = "gemini-api-key";
          };
        };
      };
  };
}
