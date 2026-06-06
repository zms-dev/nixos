/*
  Claude Code — Anthropic's agentic CLI; installed via claude-code-nix flake overlay with cachix binary cache
  https://github.com/anthropics/claude-code
*/
{ den, inputs, ... }:
{
  flake-file.inputs = {
    claude-code.url = "github:sadjow/claude-code-nix";
    claude-plugins = {
      url = "github:anthropics/claude-plugins-official";
      flake = false;
    };
    caveman = {
      url = "github:JuliusBrussee/caveman";
      flake = false;
    };
    anthropics-skills = {
      url = "github:anthropics/skills";
      flake = false;
    };
    matt-pocock-skills = {
      url = "github:mattpocock/skills";
      flake = false;
    };
  };

  den.aspects.cli._.claude = {
    includes = [ den.aspects.dev._.nodejs ];

    nixos = {
      nixpkgs.overlays = [ inputs.claude-code.overlays.default ];

      nix.settings = {
        substituters = [ "https://claude-code.cachix.org" ];
        trusted-public-keys = [ "claude-code.cachix.org-1:YeXf2aNu7UTX8Vwrze0za1WEDS+4DuI2kVeWEE4fsRk=" ];
      };
    };

    homeManager =
      { lib, pkgs, ... }:
      {
        programs.claude-code = {
          enable = true;
          package = pkgs.claude-code;
          marketplaces = {
            claude-plugins-official = inputs.claude-plugins;
            caveman = inputs.caveman;
          };
          agents = { };
          plugins = [ ];
          rules = { };
          skills = {
            grill-me = "${inputs.matt-pocock-skills}/grill-me";
            skill-creator = "${inputs.anthropics-skills}/skills/skill-creator";
          };
          lspServers = {
            nix = {
              command = (lib.getExe pkgs.nixd);
              extensionToLanguage = {
                ".nix" = "nix";
              };
            };
          };
          mcpServers = {
            # nixos = { command = (lib.getExe pkgs.mcp-nixos); };
          };
          settings = {
            permissions = {
              allow = [
                # git
                "Bash(git status *)"
                "Bash(git diff *)"
                "Bash(git log *)"
                "Bash(git show *)"
                "Bash(git blame *)"
                "Bash(git branch *)"
                "Bash(git stash *)"
                "Bash(git fetch *)"
                "Bash(git rev-parse *)"
                "Bash(git remote *)"
                "Bash(git add *)"

                # nix
                "Bash(nix build *)"
                "Bash(nix eval *)"
                "Bash(nix flake *)"
                "Bash(nixfmt *)"

                # utilities
                "Bash(jq *)"
                "Bash(which *)"
                "Bash(ls *)"
                "Bash(pwd)"
                "Bash(cat *)"
                "Bash(head *)"
                "Bash(tail *)"
                "Bash(find *)"
                "Bash(grep *)"
                "Bash(rg *)"
                "Bash(wc *)"
                "Bash(sort *)"
                "Bash(mkdir *)"
                "Bash(echo *)"
                "Bash(journalctl *)"
              ];
              deny = [
                "Bash(rm -rf /)"
                "Bash(rm -rf /*)"
                "Bash(sudo *)"
              ];
            };
            enabledPlugins = {
              #"context7@claude-plugins-official" = true;
              #"github@claude-plugins-official" = true;
              "code-simplifier@claude-plugins-official" = true;
              #"superpowers@claude-plugins-official" = true;
              "security-guidance@claude-plugins-official" = true;
              "claude-md-management@claude-plugins-official" = true;
              "claude-code-setup@claude-plugins-official" = true;
              "commit-commands@claude-plugins-official" = true;
              "rust-analyzer-lsp@claude-plugins-official" = true;
              "lua-lsp@claude-plugins-official" = true;
              "caveman@caveman" = true;
            };
          };
        };
      };
  };
}
