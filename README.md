# Getting Started Guide

Steps you can follow after cloning this template:

- Be sure to read the [den documentation](https://vic.github.io/den)

- Update den input.

```console
nix flake update den
```

- Edit [modules/hosts.nix](modules/hosts.nix)

- Build

```console
# default action is build
nix run .#desktop

# pass any other nh action
nix run .#desktop -- switch
```

- Run the VM

We recommend to use a VM develop cycle so you can play with the system before applying to your hardware.

See [modules/vm.nix](modules/vm.nix)

```console
nix run .#vm
```

## Installation

This repository includes a custom NixOS installer ISO that embeds the configuration and provides helper scripts for automated installation.

### 1. Build the ISO

Build the installer image:

```console
nix build .#installer
```

The resulting ISO will be in `./result/iso/`.

2. **Install on Hardware**:
   Once you've flashed the ISO to a USB drive and booted from it:

   1. **Connect to the internet**: Use `nmcli` or `nmtui` if on Wi-Fi.
   2. **Run the full installer**:
      ```console
      install-host desktop
      ```
      This will:
      - Run Disko (partitioning/formatting).
      - Install the base NixOS system.
      - Automatically trigger the post-install script (password, TPM rotation).

3. **Reboot**:
   ```console
   reboot
   ```
