/*
  linkding — fast and minimal self-hosted bookmark manager
  https://github.com/sissbruecker/linkding
*/
{ den, ... }:
{
  den.aspects.containers._.linkding = {
    includes = [ ];
  };
}
