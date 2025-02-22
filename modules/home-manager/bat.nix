{ stablePkgs, ... }:

{
  programs.bat = {
    enable = false;
    config = {
      style = "header,header-filesize";
    };

    extraPackages = with stablePkgs.bat-extras; [ batman ];
  };
}
