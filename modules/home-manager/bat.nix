{ stablePkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      style = "header,header-filesize";
      # tokyonight theme applied by overlay
      # theme = "ansi";
    };

    extraPackages = with stablePkgs.bat-extras; [ batman ];
  };
}
