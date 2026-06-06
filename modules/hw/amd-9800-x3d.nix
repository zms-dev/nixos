# AMD CPU — microcode updates, amd_pstate=active driver, k10temp/kvm-amd modules, performance governor
{ ... }:
{
  den.aspects.hw._.amd-9800-x3d = {
    nixos =
      { lib, config, ... }:
      {
        hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
        boot.kernelParams = [ "amd_pstate=active" ];
        boot.kernelModules = [
          "k10temp"
          "kvm-amd"
        ];
        powerManagement.cpuFreqGovernor = "performance";
        services.irqbalance.enable = true;
        boot.kernel.sysctl = {
          "kernel.nmi_watchdog" = 0;
          "kernel.sched_autogroup_enabled" = 0;
        };
      };
  };
}
