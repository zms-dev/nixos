# just — just command runner policy rules configuration for gemini-cli
{ ... }:
{
  den.aspects.cli._.gemini-cli._.policies._.just = {
    includes = [ ];

    homeManager =
      { ... }:
      {
        programs.gemini-cli.policies."just" = {
          rule = [
            {
              toolName = "run_shell_command";
              commandPrefix = "just {build,test,format,flake,update,update-den}";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "just ";
              decision = "ask_user";
              priority = 50;
            }
          ];
        };
      };
  };
}
