default:
    @just --list

_track:
    @git add -N .

build: flake
    nh os build .#desktop

test: flake
    nh os test .#desktop

switch: flake format
    nh os switch .#desktop

boot: flake
    nh os boot .#desktop

format: _track
    nix fmt
    #nix run nixpkgs#nixfmt -- $(fd -e nix)

vm-desktop: _track
    nix run .#vm-desktop

vm-server: _track
    nix run .#vm-server

make-iso out="/tmp/nixos-installer": _track
    #!/usr/bin/env bash
    OUT="{{out}}"
    if [ -z "$OUT" ]; then OUT="/tmp/nixos-installer"; fi
    mkdir -p "$(dirname "$OUT")"
    nix build .#isoImage --out-link "$OUT"
    ISO_PATH=$(ls "$OUT"/iso/*.iso | head -n 1)
    echo "ISO created at: $ISO_PATH"

test-iso out="/tmp/nixos-installer" key="": (make-iso out)
    #!/usr/bin/env bash
    TPM_DIR=$(mktemp -d /tmp/swtpm.XXXXXX)
    DISK_DIR=$(mktemp -d /tmp/nix-disks.XXXXXX)
    LOG_DIR="/tmp/nixos-installer-logs"
    mkdir -p "$LOG_DIR"
    OVMF_BIOS=$(nix build --no-link --print-out-paths nixpkgs#OVMF.fd)/FV/OVMF.fd

    # Use default if out is empty
    OUT_PATH="{{out}}"
    if [ -z "$OUT_PATH" ]; then OUT_PATH="/tmp/nixos-installer"; fi
    ISO_PATH=$(ls "$OUT_PATH"/iso/*.iso | head -n 1)

    SHARE_FLAG=""
    if [ -n "{{key}}" ]; then
        KEY_DIR=$(cd "$(dirname "{{key}}")" && pwd)
        SHARE_FLAG="-virtfs local,path=$KEY_DIR,mount_tag=secrets,security_model=none,readonly=on"
    fi

    nix shell nixpkgs#qemu_kvm nixpkgs#swtpm --command bash -c "
        qemu-img create -f qcow2 \"$DISK_DIR/nvme0.qcow2\" 1G
        qemu-img create -f qcow2 \"$DISK_DIR/nvme1.qcow2\" 1G
        qemu-img create -f qcow2 \"$DISK_DIR/nvme2.qcow2\" 1G
        qemu-img create -f qcow2 \"$DISK_DIR/nvme3.qcow2\" 40G
        swtpm socket --tpmstate dir=$TPM_DIR --ctrl type=unixio,path=$TPM_DIR/swtpm-sock --tpm2 &
        SWTPM_PID=\$!
        qemu-system-x86_64 \
            -enable-kvm -m 8G \
            $SHARE_FLAG \
            -bios $OVMF_BIOS \
            -chardev socket,id=chrtpm,path=$TPM_DIR/swtpm-sock \
            -tpmdev emulator,id=tpm0,chardev=chrtpm \
            -device tpm-tis,tpmdev=tpm0 \
            -cdrom \"$ISO_PATH\" \
            -serial file:\"$LOG_DIR/guest.log\" \
            -drive file=\"$DISK_DIR/nvme0.qcow2\",if=none,id=d0 -device nvme,drive=d0,serial=d0 \
            -drive file=\"$DISK_DIR/nvme1.qcow2\",if=none,id=d1 -device nvme,drive=d1,serial=d1 \
            -drive file=\"$DISK_DIR/nvme2.qcow2\",if=none,id=d2 -device nvme,drive=d2,serial=d2 \
            -drive file=\"$DISK_DIR/nvme3.qcow2\",if=none,id=d3 -device nvme,drive=d3,serial=d3 \
            -net nic -net user,hostfwd=tcp::2222-:22
        kill \$SWTPM_PID
    "
    rm -rf "$TPM_DIR" "$DISK_DIR"

flake: _track
    nix run .#write-flake

update:
    nix flake update

update-den:
    nix flake update den

clean:
    sudo nix-collect-garbage -d

gc:
    nh clean all
