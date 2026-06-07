# NixOS Configuration

[![CI](https://github.com/zms-dev/nixos/actions/workflows/ci.yml/badge.svg)](https://github.com/zms-dev/nixos/actions/workflows/ci.yml)
[![Release PR](https://github.com/zms-dev/nixos/actions/workflows/promote.yml/badge.svg)](https://github.com/zms-dev/nixos/actions/workflows/promote.yml)
[![Framework: Den](https://img.shields.io/badge/framework-den-blue.svg?logo=nixos&logoColor=white)](https://github.com/denful/den)
[![Formatter: nixfmt](https://img.shields.io/badge/formatter-nixfmt-orange.svg)](https://github.com/NixOS/nixfmt)

A highly modular NixOS configuration repository targeting desktop, server, and virtualized environments. 

This flake is built on a **dendritic aspect-oriented structure**, focusing on small, fully self-contained, modular, and shareable aspects. It leverages [den](https://github.com/denful/den) as the underlying configuration framework.

---

## 📂 Repository Structure

The configuration is structured as independent modules, each containing distinct aspects that package system options, home-manager environments, and dependencies together:

| Module Category | Description |
| :--- | :--- |
| 🖥️ **[apps](modules/apps/README.md)** | GUI applications (Chromium, Neovide, Wezterm, etc.) and their user configurations. |
| 🥾 **[boot](modules/boot/README.md)** | Bootloaders, systemd-initrd configurations, and Disko declarations. |
| 🐚 **[cli](modules/cli/README.md)** | Command-line utilities, shells (Zsh), terminal multiplexers (Tmux), and git configurations. |
| 📦 **[containers](modules/containers/README.md)** | Docker and OCI container services (media stacks, databases, self-hosted applications). |
| 🛠️ **[dev](modules/dev/README.md)** | Developer environments, language servers (LSPs), runtimes, and compiler setups. |
| 🔤 **[fonts](modules/fonts/README.md)** | System-wide custom font packages and rendering settings. |
| 👥 **[groups](modules/groups/README.md)** | User groups and shared access roles declarations. |
| 🖼️ **[gui](modules/gui/README.md)** | Compositor configuration (Niri), bar modules (Quickshell), and notification daemons (Mako). |
| 💻 **[hosts](modules/hosts/README.md)** | Machine-specific host profiles (`desktop`, `server`) and hardware configurations. |
| 🔌 **[hw](modules/hw/README.md)** | Hardware-specific drivers (Nvidia, AMD), controllers (liquidctl, coolercontrol), and peripherals. |
| 💿 **[iso](modules/iso/README.md)** | Custom minimal installation ISO generation rules and automated setup scripts. |
| 🌐 **[networking](modules/networking/README.md)** | Subnets, virtual bridges, bonding configs, network interfaces, and NAT tables. |
| 🔒 **[security](modules/security/README.md)** | Secret management setup utilizing SOPS-NIX and age keys. |
| ⚙️ **[services](modules/services/README.md)** | System daemons (SSH, resolving, sd-login, Btrfs scrubbing utilities). |
| 🎨 **[style](modules/style/README.md)** | Theme and system styling setup using Stylix (base16 templates). |
| 👤 **[users](modules/users/README.md)** | User account definitions and individual home-manager profiles. |

---

## 🛠️ Justfile Commands

We use a `Justfile` to organize common administration, building, and maintenance operations.

### Building & Deploying
* **`just build`**: Builds the configuration locally without applying changes (dry run).
* **`just test`**: Test changes in place temporarily (reverts on reboot).
* **`just switch`**: Apply changes immediately and switch the current system to the new profile.
* **`just boot`**: Apply changes and write them to the bootloader (active on next reboot).

### Flake Maintenance
* **`just flake`**: Regenerates the `flake.nix` output mappings using `flake-file` to register new modules.
* **`just update`**: Performs a `nix flake update` to bump all input dependencies.
* **`just update-den`**: Updates specifically the `den` framework dependency.
* **`just format`**: Formats all Nix source files recursively.

### VM Testing & Installer Development
* **`just vm-desktop`**: Launches the `desktop` configuration in a virtual machine for local testing.
* **`just vm-server`**: Launches the `server` configuration in a virtual machine.
* **`just make-iso [out]`**: Builds the custom installation ISO image (defaults output to `/tmp/nixos-installer`).
* **`just test-iso [out] [key]`**: Boots the generated installer ISO in QEMU to test partitioning and automated installs.

### System Cleanup
* **`just clean`**: Garbage collects the Nix store using root privileges.
* **`just gc`**: Runs `nh clean all` to prune old generations and optimize storage.

---

## 🚀 Getting Started

1. **Enter the environment**:
   If you have `direnv` enabled, entering the directory will automatically initialize the environment and install git hooks. Otherwise, run:
   ```console
   nix develop
   ```
2. **Apply changes**:
   Modify your settings, regenerate the flake configuration if you added new modules, and switch:
   ```console
   just flake
   just switch
   ```
