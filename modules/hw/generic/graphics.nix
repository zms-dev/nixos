# graphics — hardware.graphics subsystem; enables OpenGL/Vulkan acceleration and DRI
{ ... }:
{
  den.aspects.hw._.graphics = {
    nixos = {
      hardware.graphics = {
        enable = true;
        # enable32Bit = true;
      };

      hardware.opengl = {
        # enable = true;
        # driSupport = true;
        # driSupport32Bit = true;
      };
    };
  };
}
