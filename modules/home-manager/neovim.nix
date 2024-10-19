{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    # fix the below syntax for adding plugins


    plugins = with pkgs.vimPlugins; [
      LazyVim
    ];
  };
}
