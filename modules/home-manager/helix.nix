{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [ typescript-language-server ];
  };
}
