{config, lib, pkgs, ... }:

{
  programs.nixvim.keymaps = [
    {
      action = "<cmd>CHADopen<cr>";
      key = "<leader>e";
    }
    {
      action = "<cmd>Telescope find_files<cr>";
      key = "<leader>d";
    }
    {
      action = "<cmd>Telescope live_grep<cr>";
      key = "<leader>f";
    }
    {
      action = "<cmd>wincmd l<cr>";
      key = "<leader><Right>";
    }
    {
      action = "<cmd>wincmd h<cr>";
      key = "<leader><Left>";
    }
  ];
}
