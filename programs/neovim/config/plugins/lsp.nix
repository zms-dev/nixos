{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.lspsaga = {
    enable = true;
    # nvim-lightbulb instead of this
    lightbulb.enable = false;
  };

  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      clangd = {
        enable = true;
      };

      bashls = {
        enable = true;
      };

      nil_ls = {
        enable = true;
      };
    };
    keymaps.diagnostic = {
      "<leader>j" = "goto_next";
      "<leader>k" = "goto_prev";
    };
    keymaps.lspBuf = {
      K = "hover";
      gr = "references";
      gd = "definition";
      gi = "implementation";
      gt = "type_definition";
      "<leader>ca" = "code_action";
      "<leader>ra" = "rename";
    };
  };
}
