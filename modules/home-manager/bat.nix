{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      style = "header,header-filesize";
      theme = "ansi";
    };

    extraPackages = with pkgs.bat-extras; [ batman ];
  };
}
