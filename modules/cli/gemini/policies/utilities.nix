# utilities — general system utilities command execution policy rules configuration for gemini-cli
{ ... }:
{
  den.aspects.cli._.gemini-cli._.policies._.utilities = {
    includes = [ ];

    homeManager =
      { ... }:
      {
        programs.gemini-cli.policies."utilities" = {
          rule = [
            {
              toolName = "activate_skill";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "update_topic";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "list_directory";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "read_file";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "glob";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "grep_search";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "jq ";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "which ";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "ls ";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "pwd";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "cat ";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "head ";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "tail ";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "find ";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "grep ";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "rg ";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "wc ";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "sort ";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "mkdir ";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "echo ";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "journalctl ";
              decision = "allow";
              priority = 100;
            }
          ];

        };
      };
  };
}
