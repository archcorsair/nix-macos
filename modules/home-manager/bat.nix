{ stablePkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      style = "header,header-filesize";
      theme = "ansi";
    };

    extraPackages = with stablePkgs.bat-extras; [ batman ];
  };
}
