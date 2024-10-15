{
  programs.git = {
    enable = true;
    userEmail = "archcorsair@gmail.com";
    userName = "Daniel Shneyder";
    aliases = {
      co = "checkout";
      c = "commit";
      s = "status";
      a = "add";
      d = "diff";
    };
    delta = {
      enable = true;
    };
    extraConfig = {
      delta = {
        # Tokyo Night Theme
        minus-style = "syntax #37222c";
        minus-non-emph-style = "syntax #37222c";
        minus-emph-style = "syntax #713137";
        minus-empty-line-marker-style = "syntax #37222c";
        line-numbers-minus-style = "syntax #914c54";
        plus-style = "syntax #20303b";
        plus-non-emph-style = "syntax #20303b";
        plus-emph-style = "syntax #2c5a66";
        plus-empty-line-marker-style = "syntax #20303b";
        line-numbers-plus-style = "syntax #449dab";
        line-numbers-zero-style = "syntax #3b4261";
      };
    };
  };
}
