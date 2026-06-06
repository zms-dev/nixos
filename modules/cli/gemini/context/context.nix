# context — configuration to load context templates and system profiles for gemini-cli
{ ... }:
{
  den.aspects.cli._.gemini-cli._.context = {
    includes = [ ];

    homeManager =
      { ... }:
      {
        programs.gemini-cli.context = {
          IDENTITY = builtins.readFile ./IDENTITY.md;
          PROTOCOLS = builtins.readFile ./PROTOCOLS.md;
          EXECUTION = builtins.readFile ./EXECUTION.md;
          ENGINEERING = builtins.readFile ./ENGINEERING.md;
          NIXOS = builtins.readFile ./NIXOS.md;
        };

        programs.gemini-cli.settings.context = {
          loadMemoryFromIncludeDirectories = true;
          fileName = [
            "GEMINI.md"
            "AGENTS.md"
            "ENGINEERING.md"
            "EXECUTION.md"
            "IDENTITY.md"
            "PROTOCOLS.md"
            "NIXOS.md"
          ];
        };
      };
  };
}
