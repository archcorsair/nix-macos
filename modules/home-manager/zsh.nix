{ pkgs, ... }:

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
      cd = "z";
      code = "code-insiders";
      g = "git";
      grep = "rg";
      ll = "eza";
      man = "batman";
      nix-shell = "nix-shell --run $SHELL";
      tree = ''br -c :pt "$@"'';
      update = "nix flake update && darwin-rebuild switch --flake ~/ghq/github.com/archcorsair/nix-macos#mbp --show-trace";
      whatismyip = "curl -s 'https://api.ipify.org?format=json' | jq -r '.ip'";
      wimi = "whatismyip";
    };

    syntaxHighlighting = {
      enable = true;
      package = pkgs.zsh-syntax-highlighting;
    };
  };
}
