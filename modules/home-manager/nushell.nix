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
      wimi = "whatismyip";
      # nix-shell = "nix-shell --run $env.SHELL";
    };

    envFile.text = ''
      # Environment Variables
      $env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
    '';

    configFile.text = ''
        $env.config = {
          show_banner: false
        }

        # update
        def rebuild [] {
          cd ~/ghq/github.com/archcorsair/nix-macos
          nix flake update
          darwin-rebuild switch --flake ~/ghq/github.com/archcorsair/nix-macos#mbp --show-trace
        }

        # nix shell
        # def nix-shell [] {
        #   ^nix-shell --run $env.SHELL
        # }

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
