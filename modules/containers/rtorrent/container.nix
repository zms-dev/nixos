/*
  container — containerized rTorrent BitTorrent client instance
  https://github.com/rakshasa/rtorrent
*/
{ den, lib, ... }:
{
  den.aspects.containers._.rtorrent = {
    includes = [
      den.aspects.networking._.interfaces._.br-untrusted
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
          start = lib.mkOption {
            type = lib.types.port;
            default = 49161;
            description = "rTorrent incoming connection start port";
          };
          end = lib.mkOption {
            type = lib.types.port;
            default = 49161;
            description = "rTorrent incoming connection end port";
          };
        };

        config = {
          containers.rtorrent =
            let
              rootDir = "/var/lib/rtorrent";
              startPort = config.containerPorts.rtorrent.start;
              endPort = config.containerPorts.rtorrent.end;
              scgiPort = config.containerPorts.rtorrent.scgi;
              net = config.networking.subnets.untrusted;
              containerIp = net.namedAddresses.rtorrent;
            in
            {
              autoStart = true;
              privateNetwork = true;
              hostBridge = "br-untrusted";
              localAddress = "${containerIp}/${toString net.prefixLength}";
              forwardPorts =
                (map (p: {
                  hostPort = p;
                  containerPort = p;
                  protocol = "tcp";
                }) (lib.range startPort endPort))
                ++ (map (p: {
                  hostPort = p;
                  containerPort = p;
                  protocol = "udp";
                }) (lib.range startPort endPort));
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
                  networking.enableIPv6 = false;
                  networking.defaultGateway = net.gateway;
                  networking.firewall.allowedTCPPorts = (lib.range startPort endPort) ++ [ scgiPort ];
                  networking.firewall.allowedUDPPorts = lib.range startPort endPort;

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
                            startPort = toString startPort;
                            endPort = toString endPort;
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
        };
      };
  };
}
