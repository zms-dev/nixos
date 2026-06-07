/*
  lua-language-server — Language Server Protocol (LSP) server for Lua
  https://github.com/LuaLS/lua-language-server
*/
{ ... }:
{
  den.aspects.dev._.lua-language-server = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.lua-language-server ];
      };
  };
}
