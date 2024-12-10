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

        # update
        def rebuild [] {
          cd ~/ghq/github.com/archcorsair/nix-macos
          nix flake update
          darwin-rebuild switch --flake ~/ghq/github.com/archcorsair/nix-macos#mbp --show-trace
        }

        def "version-completions" [] {
        [
          {value: "4", description: "IPv4 address (default)"},
          {value: "6", description: "IPv6 address"}
        ]}

        # Define the function with completion annotation
        def "whatismyip" [
          version?: int@version-completions # Parameter with custom completion
        ] {
          # Validate and set default version
          let version = if ($version == null) {
            4
          } else if ($version in [4 6]) {
            $version
          } else {
            error make {
            msg: "Invalid IP version. Must be either 4 or 6."
          }
        }
        # Get IP address
        let ip = (http get $"https://api($version).ipify.org")
        # Create record and display as table
        {
          $"ip($version)": $ip
        } | table
      }
    '';
  };
}
