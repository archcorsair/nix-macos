{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    initExtra = ''
      # fnm
      eval "$(fnm env --use-on-cd)"

      # options
      setopt clobber
    '';

    shellAliases = {
      update =
        "nix flake update && darwin-rebuild switch --flake ~/ghq/github.com/archcorsair/nix-macos#mbp --show-trace";
      code = "code-insiders";
      g = "git";
      grep = "rg";
      ll = "eza";
      nix-shell = "nix-shell --run $SHELL";
      man = "batman";
      cd = "z";
      whatismyip = "curl -s 'https://api.ipify.org?format=json' | jq -r '.ip'";
      wimi = "whatismyip";
    };

    syntaxHighlighting = {
      enable = true;
      package = pkgs.zsh-syntax-highlighting;
    };
  };
}
