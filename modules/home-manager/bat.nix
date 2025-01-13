{ pkgs, stablePkgs, ... }:

{
  programs.bat = {
    enable = true;
    package = stablePkgs.bat; # import and swap the source
    config = {
      style = "header,header-filesize";
      theme = "ansi";
    };

    extraPackages = with pkgs.bat-extras; [ batman ];
  };
}
