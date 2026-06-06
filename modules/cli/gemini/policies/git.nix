# git — git tool and command policy rules configuration for gemini-cli
{ ... }:
{
  den.aspects.cli._.gemini-cli._.policies._.git = {
    includes = [ ];

    homeManager =
      { ... }:
      {
        programs.gemini-cli.policies."git" = {
          rule = [
            {
              toolName = "run_shell_command";
              commandPrefix = "git status";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "git diff";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "git log";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "git show";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "git blame";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "git branch";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "git stash";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "git fetch";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "git rev-parse";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "git remote";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "git add";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "git ";
              decision = "ask_user";
              priority = 50;
            }
          ];
        };
      };
  };
}
