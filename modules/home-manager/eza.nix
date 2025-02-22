{
  programs.eza = {
    enable = false;
    icons = "auto";
    git = true;
    enableZshIntegration = true;
    extraOptions = [
      "-l"
      "-g"
      "--git-repos"
      "--group-directories-first"
      "--hyperlink"
      "--smart-group"
      "--no-quotes"
    ];
  };
}
