/*
  buildarr — Arr stack configuration orchestrator
  https://github.com/callum-git/buildarr
*/
{ den, ... }:
{
  den.aspects.containers._.buildarr = {
    includes = [ ];
  };
}
