---
name: nixos
description: >
  Expert guidance for NixOS, Home Manager, and Flake management. Use this skill
  when searching for options, packages, or managing system state.
---

# NixOS & Home Manager Procedure

## 1. Option & Package Discovery
Always prefer `mcp_nixos_nix` over `manix` or `grep`.
- **Search:** `mcp_nixos_nix(action="search", type="options", query="...")`
- **Details:** `mcp_nixos_nix(action="info", type="option", query="...")`
- **History:** Use `mcp_nixos_nix_versions(package="...")` to find when a version changed.

## 2. Environment Verification
Before implementing, verify the current system state.
- **Eval:** `run_shell_command("nix eval .#nixosConfigurations.desktop.config.<path>")`
- **Store Paths:** `mcp_nixos_nix(action="store", type="ls", query="/nix/store/...")`

## 3. Implementation
- Update the relevant module in `modules/`.
- **Format:** Always run `run_shell_command("nixfmt <file>")` after editing.
- **Apply:** Instruct the user to run `just switch` or `nix run .#desktop -- switch`.
