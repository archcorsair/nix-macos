{
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type file --color=always";
    defaultOptions = [
      "--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid,numbers --line-range :500 {}'"
    ];
  };
}
