{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.noice = {
    enable = true;
    extraOptions = { presets.command_palette = true; };
    lsp.override = {
      "vim.lsp.util.convert_input_to_markdown_lines" = true;
      "vim.lsp.util.stylize_markdown" = true;
      "cmp.entry.get_documentation" = true;
    };
    messages.enabled = true;
    notify.enabled = true;
  };
}
