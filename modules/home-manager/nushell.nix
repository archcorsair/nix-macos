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
      wimi = "whatismyip";
    };

    envFile.text = ''
      # Environment Variables
      $env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")

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

      # update
      def _update [] {
        cd ~/ghq/github.com/archcorsair/nix-macos
        nix flake update
        darwin-rebuild switch --flake ~/ghq/github.com/archcorsair/nix-macos#mbp --show-trace
      }
    '';
  };
}
