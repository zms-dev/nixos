/*
  caddy — extensible server platform that uses TLS by default
  https://github.com/caddyserver/caddy
*/
{ den, ... }:
{
  den.aspects.containers._.caddy = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.bond0
      den.aspects.networking._.zones._.wan
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.caddy = {
          httpPort = lib.mkOption {
            type = lib.types.port;
            default = 8080;
            description = "Caddy Web UI HTTP port";
          };
          httpsPort = lib.mkOption {
            type = lib.types.port;
            default = 8443;
            description = "Caddy Web UI HTTPS port";
          };
        };

        config = {
          networking.hostPorts.caddy = 2000;
          networking.hostPorts.caddy-https = 2443;
          containers.caddy =
            let
              httpPort = config.containerPorts.caddy.httpPort;
              httpsPort = config.containerPorts.caddy.httpsPort;
              net = config.networking.subnets.trusted-ingress;
              containerIp = net.namedAddresses.caddy;
              extraHosts = config.networking.subnetExtraHosts;
            in
            {
              autoStart = true;
              privateNetwork = true;
              hostBridge = config.networking.interfaces.br-trust-in.name;
              localAddress = "${containerIp}/${toString net.prefixLength}";
              bindMounts = {
                "/etc/resolv.conf" = {
                  hostPath = "/run/systemd/resolve/resolv.conf";
                  isReadOnly = true;
                };
              };
              config =
                { ... }:
                {
                  system.stateVersion = "26.05";
                  networking.enableIPv6 = false;
                  networking.defaultGateway = net.gateway;
                  networking.extraHosts = extraHosts;
                  networking.firewall.allowedTCPPorts = [
                    httpPort
                    httpsPort
                  ];

                  services.caddy = {
                    enable = true;
                    globalConfig = ''
                      auto_https off
                      http_port ${toString httpPort}
                      https_port ${toString httpsPort}
                    '';
                    virtualHosts =
                      let
                        trustIn = config.networking.subnets.trusted-ingress.namedAddresses;
                        trustEg = config.networking.subnets.trusted-egress.namedAddresses;
                        untrEg = config.networking.subnets.untrusted-egress.namedAddresses;
                        isolated = config.networking.subnets.isolated.namedAddresses;

                        mkVHost = subdomain: target: {
                          "http://${subdomain}.internal, http://${subdomain}.localhost" = {
                            extraConfig = ''
                              reverse_proxy http://${target.ip}:${toString target.port}
                            '';
                          };
                        };
                      in
                      lib.foldl' (acc: x: acc // x) { } [
                        (mkVHost "autobrr" {
                          ip = trustEg.autobrr;
                          port = config.containerPorts.autobrr.port;
                        })
                        (mkVHost "bazarr" {
                          ip = trustEg.bazarr;
                          port = config.containerPorts.bazarr.port;
                        })
                        (mkVHost "flood" {
                          ip = trustEg.flood;
                          port = config.containerPorts.flood.port;
                        })
                        (mkVHost "forgejo" {
                          ip = trustIn.forgejo;
                          port = config.containerPorts.forgejo.webPort;
                        })
                        (mkVHost "home-assistant" {
                          ip = trustIn.home-assistant;
                          port = config.containerPorts.home-assistant.port;
                        })
                        (mkVHost "homepage" {
                          ip = trustIn.homepage;
                          port = config.containerPorts.homepage.port;
                        })
                        (mkVHost "jellyfin" {
                          ip = trustIn.jellyfin;
                          port = config.containerPorts.jellyfin.port;
                        })
                        (mkVHost "lidarr" {
                          ip = trustEg.lidarr;
                          port = config.containerPorts.lidarr.port;
                        })
                        (mkVHost "linkding" {
                          ip = trustIn.linkding;
                          port = config.containerPorts.linkding.port;
                        })
                        (mkVHost "metube" {
                          ip = untrEg.metube;
                          port = config.containerPorts.metube.port;
                        })
                        (mkVHost "nzbget" {
                          ip = untrEg.nzbget;
                          port = config.containerPorts.nzbget.port;
                        })
                        (mkVHost "nzbhydra" {
                          ip = trustEg.nzbhydra;
                          port = config.containerPorts.nzbhydra.port;
                        })
                        (mkVHost "opencode" {
                          ip = trustIn.opencode;
                          port = config.containerPorts.opencode.port;
                        })
                        (mkVHost "pi-hole" {
                          ip = isolated.pi-hole;
                          port = config.containerPorts.pi-hole.webPort;
                        })
                        (mkVHost "prowlarr" {
                          ip = trustEg.prowlarr;
                          port = config.containerPorts.prowlarr.port;
                        })
                        (mkVHost "radarr" {
                          ip = trustEg.radarr;
                          port = config.containerPorts.radarr.port;
                        })
                        (mkVHost "readarr" {
                          ip = trustEg.readarr;
                          port = config.containerPorts.readarr.port;
                        })
                        (mkVHost "seerr" {
                          ip = trustIn.seerr;
                          port = config.containerPorts.seerr.port;
                        })
                        (mkVHost "sonarr" {
                          ip = trustEg.sonarr;
                          port = config.containerPorts.sonarr.port;
                        })
                        (mkVHost "speedtest-tracker" {
                          ip = untrEg.speedtest-tracker;
                          port = config.containerPorts.speedtest-tracker.port;
                        })
                        (mkVHost "tdarr" {
                          ip = trustEg.tdarr;
                          port = config.containerPorts.tdarr.port;
                        })
                        (mkVHost "wikimedia" {
                          ip = trustIn.wikimedia;
                          port = config.containerPorts.wikimedia.port;
                        })
                      ];
                  };
                };
            };

          networking.zones.wan.preroutingRules = [
            {
              toContainer = config.containers.caddy;
              toPort = config.containerPorts.caddy.httpPort;
              hostPort = config.networking.hostPorts.caddy;
            }
            {
              toContainer = config.containers.caddy;
              toPort = config.containerPorts.caddy.httpsPort;
              hostPort = config.networking.hostPorts.caddy-https;
            }
          ];

          networking.zones.wan.forwardRules = [
            {
              toContainer = config.containers.caddy;
              toPort = config.containerPorts.caddy.httpPort;
            }
            {
              toContainer = config.containers.caddy;
              toPort = config.containerPorts.caddy.httpsPort;
            }
          ];
        };
      };
  };
}
