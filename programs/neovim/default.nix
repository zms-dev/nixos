{ config, lib, pkgs, ... }:

{
  #home.file."./.config/nvim" = {
  #  source = "${pkgs.vimPlugins.nvchad}";
  #  recursive = true;
  #  executable = true;
  #};
  xdg.configFile."nvim" = {
    source = pkgs.vimPlugins.nvchad;
    recursive = true;
  };
  xdg.configFile."nvim/lua/custom" = {
    source = ./nvchad;
    recursive = true;
  };
  programs.neovim.enable = true;
  #programs.neovim.extraLuaConfig = ''
  #  doFile("${pkgs.vimPlugins.nvchad}/init.lua")
  #'';
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.plugins = with pkgs.vimPlugins; [
    bufferline-nvim
    indent-blankline-nvim
    nvim-colorizer-lua
    nvim-web-devicons
    
    dracula-vim
    one-nvim
    tokyonight-nvim

    nvim-dap
    nvim-dap-ui

    cheatsheet-nvim
    telescope-fzf-native-nvim
    telescope-nvim

    gitsigns-nvim
    vim-fugitive

    fidget-nvim
    lsp_signature-nvim
    lspkind-nvim
    null-ls-nvim
    nvim-lspconfig
    rust-tools-nvim

    nvim-treesitter-refactor
    nvim-treesitter-textobjects
    which-key-nvim

    crates-nvim

    nvim-cmp
    cmp-buffer
    cmp-calc
    cmp-nvim-lsp
    cmp-nvim-lua
    cmp-path
    cmp-treesitter
    cmp-vsnip
    vim-vsnip
    vim-vsnip-integ

    direnv-vim
    project-nvim

    todo-comments-nvim
    venn-nvim
    vim-table-mode

    nvim-autopairs
    nvim-comment
    nvim-surround

    vim-nix
    lualine-nvim
    auto-pairs
    plenary-nvim
    telescope-nvim
    nerdtree

    base46
    lazy-nvim
    nvchad
  #  nvchad-ui
  #  #nvchad-extensions

    (nvim-treesitter.withPlugins (plugins: with plugins; [
      tree-sitter-lua
      tree-sitter-rust
      tree-sitter-nix
    ]))
  ];
  programs.neovim.extraPackages = with pkgs; [
    ripgrep
    lua-language-server
    nil
    nixpkgs-fmt
    gcc
  ];
  #programs.nixvim.enable = true;
}
