{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    initExtra = ''
      # Ghostty Setup
      export PATH=$PATH:$GHOSTTY_BIN_DIR

      # fzf-tab
      # source $HOME/ghq/github.com/Aloxaf/fzf-tab/fzf-tab.plugin.zsh

      # fnm
      eval "$(fnm env --use-on-cd)"

      # options
      setopt clobber

      # carapace
      export CARAPACE_BRIDGES='zsh,bash,inshellisense' # optional
      zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
      source <(carapace _carapace)
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
      update = "cd ~/ghq/github.com/archcorsair/nix-macos && nix flake update && darwin-rebuild switch --flake ~/ghq/github.com/archcorsair/nix-macos#mbp --show-trace";
      whatismyip = "curl -s 'https://api.ipify.org?format=json' | jq -r '.ip'";
      wimi = "whatismyip";
    };

    syntaxHighlighting = {
      enable = true;
      package = pkgs.zsh-syntax-highlighting;
    };

    autosuggestion.enable = true;
  };
}
