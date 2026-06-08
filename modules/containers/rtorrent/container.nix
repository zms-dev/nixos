/*
  container — containerized rTorrent BitTorrent client instance
  https://github.com/rakshasa/rtorrent
*/
{ den, lib, ... }:
{
  den.aspects.containers._.rtorrent = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-untrusted-ingress
      den.aspects.networking._.zones._.untrusted-ingress
      den.aspects.networking._.zones._.wan
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.rtorrent = {
          scgi = lib.mkOption {
            type = lib.types.port;
            default = 5000;
            description = "rTorrent SCGI port";
          };
        };

        config = {
          networking.hostPorts.rtorrent-peer = 49161;
          containers.rtorrent =
            let
              rootDir = "/var/lib/rtorrent";
              peerPort = config.networking.hostPorts.rtorrent-peer;
              scgiPort = config.containerPorts.rtorrent.scgi;
              net = config.networking.subnets.untrusted-ingress;
              containerIp = net.namedAddresses.rtorrent;
              extraHosts = config.networking.subnetExtraHosts;
            in
            {
              autoStart = true;
              privateNetwork = true;
              hostBridge = config.networking.interfaces.br-untr-in.name;
              localAddress = "${containerIp}/${toString net.prefixLength}";
              bindMounts = {
                "${rootDir}" = {
                  hostPath = "/mnt/rtorrent";
                  isReadOnly = false;
                };
                "/etc/resolv.conf" = {
                  hostPath = "/run/systemd/resolve/resolv.conf";
                  isReadOnly = true;
                };
              };
              config =
                {
                  config,
                  pkgs,
                  lib,
                  ...
                }:
                {
                  system.stateVersion = "26.05";
                  networking.enableIPv6 = false;
                  networking.defaultGateway = net.gateway;
                  networking.extraHosts = extraHosts;
                  networking.firewall.allowedTCPPorts = [
                    scgiPort
                    peerPort
                  ];
                  networking.firewall.allowedUDPPorts = [ peerPort ];

                  environment.systemPackages = [
                    pkgs.tmux
                    pkgs.rtorrent
                  ];

                  users.users.rtorrent = {
                    uid = 5001;
                    isNormalUser = true;
                  };

                  systemd.services.rtorrent =
                    let
                      sessionDir = "${rootDir}/session";
                      downloadDir = "${rootDir}/download";
                      watchDir = "${rootDir}/watch";
                    in
                    {
                      description = "rTorrent Daemon";
                      after = [ "network.target" ];
                      wantedBy = [ "multi-user.target" ];

                      preStart = ''
                        mkdir -p ${sessionDir}
                        mkdir -p ${downloadDir}
                        mkdir -p ${watchDir}
                        rm -f ${sessionDir}/rtorrent.lock
                        chown -R rtorrent ${rootDir}
                      '';

                      environment = {
                        SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
                        CURL_CA_BUNDLE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
                      };

                      serviceConfig =
                        let
                          tmux = lib.getExe pkgs.tmux;
                          rtorrent = lib.getExe pkgs.rtorrent;

                          configFile = pkgs.replaceVars ./rtorrent.rc {
                            inherit downloadDir sessionDir watchDir;
                            startPort = toString peerPort;
                            endPort = toString peerPort;
                            scgiPort = toString scgiPort;
                          };

                          startScript = pkgs.writeShellScript "rtorrent-start" ''
                            exec ${tmux} -L rtorrent \
                              new-session -d -s rtorrent \
                              "${rtorrent} -n -o import=${configFile}"
                          '';
                        in
                        {
                          Type = "forking";
                          ExecStart = startScript;
                          ExecStop = "${tmux} -L rtorrent kill-session -t rtorrent";
                          WorkingDirectory = "${rootDir}";
                          User = "rtorrent";
                          PermissionsStartOnly = true;
                          RemainAfterExit = "yes";
                        };
                    };
                };
            };

          networking.zones.wan.preroutingRules = [
            {
              toContainer = config.containers.rtorrent;
              toPort = config.networking.hostPorts.rtorrent-peer;
              hostPort = config.networking.hostPorts.rtorrent-peer;
            }
            {
              toContainer = config.containers.rtorrent;
              toPort = config.networking.hostPorts.rtorrent-peer;
              hostPort = config.networking.hostPorts.rtorrent-peer;
              proto = "udp";
            }
          ];

          networking.zones.wan.forwardRules = [
            {
              toContainer = config.containers.rtorrent;
              toPort = config.networking.hostPorts.rtorrent-peer;
            }
            {
              toContainer = config.containers.rtorrent;
              toPort = config.networking.hostPorts.rtorrent-peer;
              proto = "udp";
            }
          ];
        };
      };
  };
}
