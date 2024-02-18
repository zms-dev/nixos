{config, lib, pkgs, ... }:

{
  imports = [
    ./config/globals.nix
    ./config/options.nix
    ./config/keymaps.nix
    ./config/plugins/bufferline.nix
    ./config/plugins/chadtree.nix
    ./config/plugins/comment-nvim.nix
    ./config/plugins/conform-nvim.nix
    ./config/plugins/fidget.nix
    ./config/plugins/fugitive.nix
    ./config/plugins/gitsigns.nix
    ./config/plugins/harpoon.nix
    ./config/plugins/illuminate.nix
    ./config/plugins/indent-blankline.nix
    ./config/plugins/leap.nix
    ./config/plugins/lsp.nix
    ./config/plugins/lualine.nix
    ./config/plugins/mini.nix
    ./config/plugins/noice.nix
    ./config/plugins/notify.nix
    ./config/plugins/nvim-cmp.nix
    ./config/plugins/nvim-colorizer.nix
    ./config/plugins/nvim-lightbulb.nix
    ./config/plugins/persistence.nix
    ./config/plugins/project-nvim.nix
    ./config/plugins/refactoring.nix
    #./config/plugins/surround.nix
    ./config/plugins/telescope.nix
    ./config/plugins/todo-comments.nix
    ./config/plugins/treesitter.nix
    ./config/plugins/trouble.nix
    ./config/plugins/which-key.nix
    ./config/colorschemes/base16.nix
    #./config/colorschemes/catppuccin.nix
    #./config/colorschemes/dracula.nix
    #./config/colorschemes/gruvbox.nix
    #./config/colorschemes/nord.nix
    #./config/colorschemes/onedark.nix
    #./config/colorschemes/tokyonight.nix
  ];

  programs.nixvim = {
    enable = true;
    extraPlugins = [
      pkgs.vimPlugins.gruvbox
    ];
    vimAlias = true;
    clipboard.providers.wl-copy.enable = true;
    plugins.nix.enable = true;
    plugins.nix-develop.enable = true;
  };
}
