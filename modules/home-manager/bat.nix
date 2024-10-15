{ config, lib, pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      style = "header,header-filesize";
      theme = "base16";
    };
  };
}
