/*
  forgejo — self-hosted lightweight Git software forge
  https://codeberg.org/forgejo/forgejo
*/
{ den, ... }:
{
  den.aspects.containers._.forgejo = {
    includes = [ ];
  };
}
