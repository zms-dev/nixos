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
            toHostFwd = proto: port: "hostfwd=${proto}::${toString port}-:${toString port}";

            qemuNetOpts =
              let
                ports = builtins.attrValues host.networking.hostPorts;
                fwds = map (toHostFwd "tcp") ports ++ [ "hostfwd=tcp::22222-:22" ];
              in
              builtins.concatStringsSep "," fwds;
          in
          ''
            mkdir -p /tmp/vm-server-mnt

            export QEMU_NET_OPTS="${qemuNetOpts}"

            ${host.system.build.vm}/bin/run-${host.networking.hostName}-vm "$@"
          '';
      };
    };
}
