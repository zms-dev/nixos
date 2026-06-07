/*
  flood — web UI frontend for rTorrent and other BitTorrent clients
  https://github.com/jesec/flood
*/
{ den, lib, ... }:
{
  den.aspects.containers._.flood = {
    includes = [
      den.aspects.networking._.interfaces._.br-backend
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.flood = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 3000;
            description = "Flood web UI port";
          };
        };

        config = {
          containers.flood =
            let
              port = config.containerPorts.flood.port;
              rtHost = config.networking.subnets.untrusted.namedAddresses.rtorrent;
              rtPort = config.containerPorts.rtorrent.scgi;
              rootDir = "/var/lib/flood";
              net = config.networking.subnets.backend;
              containerIp = net.namedAddresses.flood;
            in
            {
              autoStart = true;
              privateNetwork = true;
              hostBridge = "br-backend";
              localAddress = "${containerIp}/${toString net.prefixLength}";
              forwardPorts = [
                {
                  hostPort = port;
                  containerPort = port;
                  protocol = "tcp";
                }
              ];
              bindMounts = {
                "${rootDir}" = {
                  hostPath = "/mnt/flood";
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
                  networking.firewall.allowedTCPPorts = [ port ];

                  environment.systemPackages = [
                    pkgs.flood
                  ];

                  users.users.flood = {
                    uid = 5002;
                    isNormalUser = true;
                  };

                  systemd.services.flood = {
                    description = "Flood Daemon";
                    after = [ "network.target" ];
                    wantedBy = [ "multi-user.target" ];

                    preStart = ''
                      mkdir -p ${rootDir}
                      chown -R ${config.users.users.flood.name} ${rootDir}
                    '';

                    environment = {
                      SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
                      CURL_CA_BUNDLE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
                    };

                    serviceConfig =
                      let
                        flood = lib.getExe pkgs.flood;

                        startScript = pkgs.writeShellScript "flood-start" ''
                          exec ${flood} \
                            --host 0.0.0.0 \
                            --port ${toString port} \
                            --rundir ${rootDir} \
                            --auth none \
                            --rthost ${rtHost} \
                            --rtport ${toString rtPort} \
                            --baseuri / \
                            --allowedpath /var/lib/rtorrent
                        '';
                      in
                      {
                        Type = "simple";
                        ExecStart = startScript;
                        WorkingDirectory = "${rootDir}";
                        User = config.users.users.flood.name;
                        PermissionsStartOnly = true;
                        Environment = "HOME=${rootDir}";
                      };
                  };
                };
            };
        };
      };
  };
}
