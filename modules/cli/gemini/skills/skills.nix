# skills — skill paths configuration for gemini-cli
{ ... }:
{
  den.aspects.cli._.gemini-cli._.skills = {
    includes = [ ];

    homeManager =
      { ... }:
      {
        programs.gemini-cli.skills = {
          "nixos" = ./nixos;
          "codebase" = ./codebase;
          "research" = ./research;
        };
      };
  };
}
