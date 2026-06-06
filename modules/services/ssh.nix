/*
  OpenSSH — SSH daemon for remote access; public-key auth, agent forwarding
  https://www.openssh.com
*/
{ ... }:
{
  den.aspects.services._.ssh = {
    nixos = {
      services.openssh.enable = true;
    };
  };
}
