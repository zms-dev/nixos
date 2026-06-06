/*
  cava — terminal audio visualizer using ALSA/PipeWire; driven by FFT
  https://github.com/karlstav/cava
*/
{ ... }:
{
  den.aspects.cli._.cava = {
    homeManager =
      { ... }:
      {
        stylix.targets.cava.rainbow.enable = true;
        programs.cava.enable = true;
      };
  };
}
