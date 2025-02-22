{ pkgs, ... }:

{
  programs.neovim = {
    enable = false;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;

    plugins = with pkgs.vimPlugins; [
      LazyVim
    ];
  };
}
