{
  inputs,
  self,
  lib,
  ...
}:
{
  perSystem =
    { pkgs, system, ... }:
    let
      # Filter hosts matching this architecture
      compatibleHosts = lib.filterAttrs (
        _: cfg: cfg.config.nixpkgs.hostPlatform.system == system
      ) self.nixosConfigurations;

      nixosSystem = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          {
            nixpkgs.hostPlatform = system;

            # Fix: boot.zfs.forceImportRoot warning
            boot.zfs.forceImportRoot = false;

            isoImage.squashfsCompression = "lz4";
            nix.settings.experimental-features = [
              "nix-command"
              "flakes"
            ];

            boot.tmp.useTmpfs = true;
            boot.tmp.tmpfsSize = "90%";

            networking.networkmanager.enable = true;
            networking.wireless.enable = true;

            services.openssh = {
              enable = true;
              settings.PermitRootLogin = "prohibit-password";
            };

            services.getty.autologinUser = "nixos";

            users.users.nixos = {
              isNormalUser = true;
              extraGroups = [
                "wheel"
                "networkmanager"
                "dialout"
              ];
              # Fix: Multiple password options warning
              initialHashedPassword = lib.mkForce null;
              password = "nixos";
            };

            environment.systemPackages =
              let
                hostScripts = lib.mapAttrsToList (
                  name: cfg:
                  pkgs.writeShellScriptBin "install-${name}.sh" ''
                    exec ${lib.getExe cfg.config.system.build.install-host} "$@"
                  ''
                ) compatibleHosts;

                mountSecrets = pkgs.writeShellScriptBin "mount-secrets" ''
                  sudo mkdir -p /tmp/secrets
                  sudo mount -t 9p -o trans=virtio secrets /tmp/secrets
                  echo "Secrets mounted at /tmp/secrets"
                '';
              in
              hostScripts
              ++ [
                mountSecrets
                pkgs.git
                pkgs.vim
              ];

            # Pre-package all compatible target systems
            isoImage.storeContents = lib.mapAttrsToList (
              _: cfg: cfg.config.system.build.toplevel
            ) compatibleHosts;

            programs.bash.loginShellInit = ''
              # Auto-setup for VM testing
              if ${pkgs.systemd}/bin/systemd-detect-virt -q; then
                  # Auto-redirect logs if we're on the physical console (tty1)
                  if [ -e /dev/ttyS0 ] && [ "$(tty 2>/dev/null)" != "/dev/ttyS0" ]; then
                      exec > >(sudo tee -a /dev/ttyS0) 2>&1
                  fi
                  mount-secrets 2>/dev/null || true
              fi

              clear
              echo "Modular NixOS ISO"
              echo "========================"
              echo "Available installation scripts:"
              ${lib.concatStringsSep "\n" (
                map (name: "echo \"  - install-${name}.sh\"") (lib.attrNames compatibleHosts)
              )}

              echo ""
              if [ -d /tmp/secrets ] && mountpoint -q /tmp/secrets; then
                  echo "VM Status: Logs mirrored to guest.log, Secrets mounted at /tmp/secrets"
                  install-desktop.sh /tmp/secrets/root.txt
              else
                  echo "VM Status: Logs mirrored to guest.log"
              fi
            '';
          }
        ];
      };
    in
    {
      packages.isoImage = nixosSystem.config.system.build.isoImage;
    };
}
