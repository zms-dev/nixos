{ config, lib, pkgs, ... }:

{
  programs.starship.enable = true;
  programs.starship.enableZshIntegration = true;
  programs.starship.settings = {
    add_newline = false;
    format = builtins.concatStringsSep "" [
      "$nix_shell"
      "$os"
      "$directory"
      "$container"
      "$git_branch $git_status"
      "$python"
      "$nodejs"
      "$lua"
      "$rust"
      "$java"
      "$c"
      "$golang"
      "$cmd_duration"
      "$status"
      "$line_break"
      "[ ](bold purple)"
    ];
    line_break = { disabled = false; };
    status = {
      symbol = "✗";
      not_found_symbol = "󰍉 Not Found";
      not_executable_symbol = " Can't Execute E";
      sigint_symbol = "󰂭 ";
      signal_symbol = "󱑽 ";
      success_symbol = "";
      format = "[$symbol](fg:red)";
      map_symbol = true;
      disabled = false;
    };
  };
}
