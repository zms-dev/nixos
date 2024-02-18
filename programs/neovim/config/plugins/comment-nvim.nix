{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.comment-nvim = {
    enable = true;
    toggler = {
      line = "<leader>/";
      block = "<leader>?";
    };
  };
}
