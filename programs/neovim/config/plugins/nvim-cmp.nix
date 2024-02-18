{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.luasnip = {
    enable = true;
    extraConfig.enable_autosnippets = true;
  };

  programs.nixvim.plugins.cmp_luasnip = {
    enable = true;
  };

  programs.nixvim.plugins.cmp-nvim-lsp = {
    enable = true;
  };

  programs.nixvim.plugins.cmp-nvim-lsp-signature-help = {
    enable = true;
  };

  programs.nixvim.plugins.cmp-buffer = {
    enable = true;
  };

  programs.nixvim.plugins.cmp-cmdline = {
    enable = true;
  };

  programs.nixvim.plugins.cmp-zsh = {
    enable = true;
  };

  programs.nixvim.plugins.lspkind = {
    enable = true;
  };

  programs.nixvim.plugins.nvim-cmp = {
    enable = true;
    autoEnableSources = true;
    experimental = { ghost_text.hlgroup = "Comment"; };
    completion.completeopt = "menu,menuone,noselect,preview";
    sources = [
      { name = "path"; }
      { name = "nvim_lsp"; }
      { name = "luasnip"; }
      { name = "buffer"; }
    ];
    snippet.expand = "luasnip";
    mapping = {
      "<CR>" = "cmp.mapping.confirm({ select = true })";
      "<Tab>" = {
        action = "cmp.mapping.select_next_item()";
        modes = [ "i" "s" ];
      };
    };
  };
}
