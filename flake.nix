{
  description = "Daniel's Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        bat
        btop
        bun
        commitizen
        curlie
        doggo
        eza
        fd
        fnm
        fzf
        ghq
        git
        httpie
        jq
        mas
        neofetch
        neovim
        pnpm
        ripgrep
        speedtest-cli
        starship
        termshark
        zoxide
      ];

      fonts.packages = with pkgs; [
        fira-code-nerdfont
      ];

      homebrew = {
        enable = true;

        # Config
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;

        # Using zap will install install packages listed here. (It will delete any packages installed outside of this flake)
        # onActivation.cleanup = "zap";

        casks = [
          "arc"
          "boop"
          "daisydisk"
          "discord"
          "gitkraken"
          "google-chrome@dev"
          "hoppscotch"
          "istat-menus"
          "kap"
          "keyboardcleantool"
          "notion"
          "numi"
          "raycast"
          "skitch"
          "spotify"
          "teamviewer"
          "the-unarchiver"
          "visual-studio-code@insiders"
          "vlc"
          "warp"
          "wezterm"
        ];

        taps = [
          "eth-p/software"
          "homebrew/cask-versions"
        ];

        masApps = {
          "1Password for Safari" = 1569813296;
          Amphetamine = 937984704;
          ColorSlurp = 1287239339;
          "HEIC Converter" = 1294126402;
          TestFlight = 899247664;
        };
      };

      system.defaults = {
        dock = {
          minimize-to-application = true;
          # Hot Corners
          wvous-bl-corner = 2; # Mission Control
          wvous-br-corner = 11; # Launchpad
          wvous-tl-corner = 3; # Application Windows
          wvous-tr-corner = 4; # Desktop

          persistent-apps = [
            "/System/Applications/App Store.app"
            "/Applications/Arc.app"
            "/Applications/Google Chrome Dev.app"
            "/System/Applications/Messages.app"
            "/Applications/Discord.app"
            "/Applications/Warp.app"
            "/Applications/Visual Studio Code - Insiders.app"
            "/Applications/Cursor.app"
            "/Applications/Spotify.app"
            "/System/Applications/Calendar.app"
            "/System/Applications/System Settings.app"
            "/System/Applications/iPhone Mirroring.app"
          ];
        };

        finder = {
          FXPreferredViewStyle = "clmv"; # Column View
          FXDefaultSearchScope = "SCcf"; # Current Folder
          ShowPathbar = true;
        };

        trackpad = {
          Clicking = true; # Enables tap to click
        };

        NSGlobalDomain = {
          AppleInterfaceStyle = "Dark";
          "com.apple.swipescrolldirection" = false; # Disable natural scrolling
        };
      };

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#mbp
    darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
          nix-homebrew.darwinModules.nix-homebrew {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "nxc";
              autoMigrate = true;
            };
          }
        ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."mbp".pkgs;
  };
}
