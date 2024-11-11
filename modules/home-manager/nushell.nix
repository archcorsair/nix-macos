{
  programs.nushell = {
    enable = true;

    shellAliases = {
      ll = "eza";
      cd = "z";
      code = "code-insiders";
      g = "git";
      grep = "rg";
      man = "batman";
      nix-shell = "nix-shell --run $env.SHELL";
      update = "cd ~/ghq/github.com/archcorsair/nix-macos and nix flake update and darwin-rebuild switch --flake ~/ghq/github.com/archcorsair/nix-macos#mbp --show-trace";
      wimi = "whatismyip";
    };

    envFile.text = ''
      # Starship Prompt
      mkdir ~/.cache/starship
      starship init nu | save -f ~/.cache/starship/init.nu

      # Zoxide
      zoxide init nushell | save -f ~/.zoxide.nu
    '';

    configFile.text = ''
      $env.config = {
        show_banner: false
      }

      # Starhip Prompt
      use ~/.cache/starship/init.nu

      # Zoxide
      source ~/.zoxide.nu

      # whatismyip
      def whatismyip [] {
        http get https://api.ipify.org?format=json | get ip
      }
    '';
  };
}
