/*
  git — distributed version control system
  https://git-scm.com
*/
{ ... }:
{
  den.aspects.cli._.git = {
    homeManager =
      { config, pkgs, ... }:
      let
        github-helper = pkgs.writeShellScript "github-credential-helper" ''
          echo username=oauth2
          echo password=$(cat ${config.sops.secrets.github-access-token.path})
        '';
      in
      {
        sops.secrets.github-access-token = { };

        programs.git = {
          enable = true;
          settings = {
            credential."https://github.com".helper = "${github-helper}";
          };
        };
      };
  };
}
