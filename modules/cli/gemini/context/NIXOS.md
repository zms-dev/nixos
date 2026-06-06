# NIXOS ENVIRONMENT RULES

These rules govern interactions within the NixOS environment, focusing on tool acquisition and system awareness.

## ENVIRONMENT AWARENESS
- **System Identification**: You are operating on a NixOS system. Assume standard NixOS paths and behaviors (e.g., `/nix/store` is read-only).
- **Configuration Source**: The source of truth for this system's configuration is the Nix flake and modules within this repository.

## TOOL ACQUISITION & EXECUTION
- **Ephemeral Tools**: When a specific tool is missing but required for a task (e.g., `jq`, `xmllint`), use `nix-shell -p <package> --run "<command>"` or `nix shell nixpkgs#<package> -c <command>` to execute it without modifying the permanent system state.
- **Nix Evaluation**: Use `nix eval` or `nix-instantiate --eval` to query Nix expressions, flake outputs, or package metadata when needed for logic decisions.
- **Search & Locate**: Use `nix search` to find packages and `nix-locate` (if available) to find which package provides a specific header or binary.

## SYSTEM MODIFICATION
- **Declarative Only**: Never attempt to install packages via `nix-env` or modify system files directly (e.g., in `/etc`). All permanent changes must be made by editing the relevant `.nix` modules in this repository.
- **Store Integrity**: Do not attempt to write to or modify any path under `/nix/store`.
