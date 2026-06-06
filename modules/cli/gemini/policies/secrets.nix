# secrets — repository and environment secret files access policy rules configuration for gemini-cli
{ ... }:
{
  den.aspects.cli._.gemini-cli._.policies._.secrets = {
    includes = [ ];

    homeManager =
      { ... }:
      {
        programs.gemini-cli.policies."secrets" = {
          rule = [
            {
              toolName = "read_file";
              pathPattern = "**/{.env,*.key,id_rsa,id_ed25519,*.pem}";
              decision = "ask_user";
              priority = 100;
            }
            {
              toolName = "read_file";
              pathPattern = "secrets/**";
              decision = "ask_user";
              priority = 100;
            }
          ];
        };
      };
  };
}
