{ pkgs, ... }:

{
  programs.helix = {
    enable = false;
    extraPackages = with pkgs; [ typescript-language-server ];
  };
}
