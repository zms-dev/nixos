{ ... }:
{
  den.aspects.cli._.gemini-cli._.policies._.nix = {
    includes = [ ];

    homeManager =
      { ... }:
      {
        programs.gemini-cli.policies."nix" = {
          rule = [
            {
              toolName = "run_shell_command";
              commandPrefix = "nix build";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "nix eval";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "nix flake";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "run_shell_command";
              commandPrefix = "nixfmt";
              decision = "allow";
              priority = 100;
            }
          ];
        };
      };
  };
}
