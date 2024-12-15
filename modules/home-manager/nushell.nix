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
      $env.XDG_DATA_HOME = ($env.HOME | path join ".local/share")
      $env.XDG_STATE_HOME = ($env.HOME | path join ".local/state")
      $env.XDG_CACHE_HOME = ($env.HOME | path join ".cache")
      $env.XDG_DATA_DIRS = ["/usr/local/share" "/usr/share"]

      # Path
      $env.PATH = (
         $env.PATH
         | split row (char esep)
         | prepend '/opt/homebrew/bin'
         | prepend '/opt/homebrew/sbin'
         | prepend '/nix/var/nix/profiles/default/bin'
         | prepend '/run/current-system/sw/bin/'
         | prepend ('/etc/profiles/per-user' | path join $env.USER bin)
         | prepend ($env.HOME | path join '.nix-profile/bin')
         | uniq # filter so the paths are unique
      )
    '';

    configFile.text = ''
        $env.config = {
          show_banner: false
        }

        # FNM
        fnm env --json | from json | load-env
        use std "path add"
        $env.FNM_BIN = $"($env.FNM_DIR)/bin"
        path add $env.FNM_BIN
        $env.FNM_MULTISHELL_PATH = $"($env.FNM_DIR)/nodejs"
        path add $env.FNM_MULTISHELL_PATH

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
