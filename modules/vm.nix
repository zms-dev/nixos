# vm — QEMU virtual machine runner configurations for local host testing
{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.vm-desktop = pkgs.writeShellApplication {
        name = "vm-desktop";
        text =
          let
            host = inputs.self.nixosConfigurations.desktop.config;
          in
          ''
            ${host.system.build.vm}/bin/run-${host.networking.hostName}-vm "$@"
          '';
      };

      packages.vm-server = pkgs.writeShellApplication {
        name = "vm-server";
        text =
          let
            host = inputs.self.nixosConfigurations.server.config;
            toHostFwd =
              f:
              let
                proto = f.protocol or "tcp";
                hostP = toString f.hostPort;
                contP = toString (f.containerPort or f.hostPort);
              in
              "hostfwd=${proto}::${hostP}-:${contP}";

            allForwards = builtins.concatMap (c: c.forwardPorts) (builtins.attrValues host.containers);
            qemuNetOpts = builtins.concatStringsSep "," (map toHostFwd allForwards);
          in
          ''
            mkdir -p /tmp/vm-server-mnt

            export QEMU_NET_OPTS="${qemuNetOpts}"

            ${host.system.build.vm}/bin/run-${host.networking.hostName}-vm "$@"
          '';
      };
    };
}
