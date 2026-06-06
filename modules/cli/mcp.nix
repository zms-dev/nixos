{ den, inputs, ... }:
{
  flake-file.inputs = {
    mcp-servers-nix = {
      url = "github:natsukium/mcp-servers-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.cli._.mcp = {
    includes = [
      den.aspects.dev._.nixd
      den.aspects.security._.sops
    ];

    homeManager =
      { config, pkgs, ... }:
      {
        imports = [ inputs.mcp-servers-nix.homeManagerModules.default ];
        programs.mcp.enable = true;

        sops.secrets.github-access-token = { };

        sops.templates.github-mpc-server-env = {
          content = ''
            GITHUB_PERSONAL_ACCESS_TOKEN=${config.sops.placeholder.github-access-token}
          '';
        };

        mcp-servers.programs = {
          # filesystem = {
          #   enable = true;
          #   args = [ "/nix/store" ];
          # };
          fetch.enable = true;
          context7.enable = true;
          git.enable = true;
          github = {
            enable = true;
            envFile = config.sops.templates.github-mpc-server-env.path;
          };
          memory.enable = true;
          serena = {
            enable = true;
            # context = "ide-assistant";
            args = [ "--project-from-cwd" ];
            enableWebDashboard = false;
            extraPackages = [
              pkgs.nixd
              pkgs.lua-language-server
            ];
          };
          nixos.enable = true;
          time.enable = true;
        };
      };
  };
}
