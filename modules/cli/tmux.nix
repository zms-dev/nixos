/*
  tmux — terminal multiplexer; persistent sessions, split panes, and window management via a client-server model
  https://github.com/tmux/tmux
*/
{ ... }:
{
  den.aspects.cli._.tmux = {
    homeManager = {
      programs.tmux = {
        enable = true;
        terminal = "tmux-256color";
      };
    };
  };
}
