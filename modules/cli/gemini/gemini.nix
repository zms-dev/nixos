/*
  Claude Code — Anthropic's agentic CLI; installed via claude-code-nix flake overlay with cachix binary cache
  https://github.com/anthropics/claude-code
*/
{ den, ... }:
{
  den.aspects.cli._.gemini-cli = {
    includes = [
      den.aspects.cli._.mcp
      den.aspects.dev._.nodejs
      den.aspects.cli._.gemini-cli._.context
      den.aspects.cli._.gemini-cli._.general
      den.aspects.cli._.gemini-cli._.hooks._.after-agent
      den.aspects.cli._.gemini-cli._.hooks._.after-model
      den.aspects.cli._.gemini-cli._.hooks._.after-tool
      den.aspects.cli._.gemini-cli._.hooks._.before-agent
      den.aspects.cli._.gemini-cli._.hooks._.before-model
      den.aspects.cli._.gemini-cli._.hooks._.before-tool
      den.aspects.cli._.gemini-cli._.hooks._.before-tool-selection
      den.aspects.cli._.gemini-cli._.hooks._.notification
      den.aspects.cli._.gemini-cli._.hooks._.pre-compress
      den.aspects.cli._.gemini-cli._.hooks._.session-end
      den.aspects.cli._.gemini-cli._.hooks._.session-start
      den.aspects.cli._.gemini-cli._.ide
      den.aspects.cli._.gemini-cli._.policies._.git
      den.aspects.cli._.gemini-cli._.policies._.just
      den.aspects.cli._.gemini-cli._.policies._.mcp
      den.aspects.cli._.gemini-cli._.policies._.nix
      den.aspects.cli._.gemini-cli._.policies._.secrets
      den.aspects.cli._.gemini-cli._.policies._.security
      den.aspects.cli._.gemini-cli._.policies._.utilities
      den.aspects.cli._.gemini-cli._.privacy
      den.aspects.cli._.gemini-cli._.security
      den.aspects.cli._.gemini-cli._.skills
      den.aspects.cli._.gemini-cli._.tools
      den.aspects.cli._.gemini-cli._.ui
    ];

    homeManager =
      { ... }:
      {
        programs.gemini-cli = {
          enable = true;
          defaultModel = "gemini-3-flash-preview";
          enableMcpIntegration = true;
        };
      };
  };
}
