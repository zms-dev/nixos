# server — configuration profile aggregating all aspects and containerized services for the server host
{ den, ... }:
{
  den.aspects.hosts._.server = {
    includes = [
      den.provides.hostname

      den.aspects.hosts._.server._.boot
      den.aspects.hosts._.server._.disks
      den.aspects.hosts._.server._.networking
      den.aspects.hosts._.server._.platform
      den.aspects.hosts._.server._.time

      den.aspects.services._.ssh

      den.aspects.containers._.autobrr
      den.aspects.containers._.bazarr
      den.aspects.containers._.buildarr
      den.aspects.containers._.caddy
      den.aspects.containers._.flood
      den.aspects.containers._.forgejo
      den.aspects.containers._.home-assistant
      den.aspects.containers._.homepage
      den.aspects.containers._.jellyfin
      den.aspects.containers._.lidarr
      den.aspects.containers._.linkding
      den.aspects.containers._.metube
      den.aspects.containers._.nzbget
      den.aspects.containers._.nzbhydra
      den.aspects.containers._.opencode
      den.aspects.containers._.pi-hole
      den.aspects.containers._.prowlarr
      den.aspects.containers._.radarr
      den.aspects.containers._.readarr
      den.aspects.containers._.recyclarr
      den.aspects.containers._.rtorrent
      den.aspects.containers._.seerr
      den.aspects.containers._.sonarr
      den.aspects.containers._.speedtest-tracker
      den.aspects.containers._.tdarr
      den.aspects.containers._.unpackerr
      den.aspects.containers._.wikimedia

      den.aspects.groups._.nixos-config
      den.aspects.security._.sops
    ];
  };
}
