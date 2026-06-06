{ ... }:
{
  den.aspects.cli._.gemini-cli._.policies._.security = {
    includes = [ ];

    homeManager =
      { ... }:
      {
        programs.gemini-cli.policies."security" = {
          rule = [
            {
              toolName = "run_shell_command";
              commandPrefix = "rm -rf /";
              decision = "deny";
              priority = 999;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "sudo ";
              decision = "deny";
              priority = 999;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "reboot|poweroff|shutdown|halt";
              decision = "deny";
              priority = 999;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "find .* -delete";
              decision = "ask_user";
              priority = 100;
            }
          ];
        };
      };
  };
}
