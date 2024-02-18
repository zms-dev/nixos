{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.harpoon = {
    enable = false;
    enableTelescope = true;
    keymaps = {
      addFile = "<leader>ha";
      navNext = "<leader>hj";
      navPrev = "<leader>hk";
    };
  };
}
