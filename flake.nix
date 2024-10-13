{
  description = "Daniel's Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
    let
      configuration = { pkgs, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages = with pkgs; [
          bun
          commitizen
          curlie
          delta
          doggo
          fd
          fnm
          ghq
          httpie
          jq
          mas
          neofetch
          neovim
          nixfmt
          pnpm
          ripgrep
          speedtest-cli
          termshark
        ];

        fonts.packages = with pkgs; [ fira-code-nerdfont ];

        # Home Manager
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.nxc = { pkgs, ... }: {
          home.stateVersion = "24.05";

          programs = {
            bat = {
              enable = true;
              config = {
                style = "header,header-filesize";
                theme = "base16";
              };
            };

            btop = {
              enable = true;
              settings = { color_theme = "tokyo-night"; };
            };

            eza = {
              enable = true;
              icons = true;
              git = true;
              enableZshIntegration = true;
              extraOptions = [ "-l" "-g" ];
            };

            fzf = {
              enable = true;
              defaultCommand = "fd --type file --color=always";
              defaultOptions = [
                "--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
              ];
            };

            git = {
              enable = true;
              userEmail = "archcorsair@gmail.com";
              userName = "Daniel Shneyder";
              aliases = {
                co = "checkout";
                p = "pull";
                s = "status";
                a = "add";
              };
              delta = { enable = true; };
              extraConfig = {
                delta = {
                  # Tokyo Night Theme
                  minus-style = "syntax #37222c";
                  minus-non-emph-style = "syntax #37222c";
                  minus-emph-style = "syntax #713137";
                  minus-empty-line-marker-style = "syntax #37222c";
                  line-numbers-minus-style = "syntax #914c54";
                  plus-style = "syntax #20303b";
                  plus-non-emph-style = "syntax #20303b";
                  plus-emph-style = "syntax #2c5a66";
                  plus-empty-line-marker-style = "syntax #20303b";
                  line-numbers-plus-style = "syntax #449dab";
                  line-numbers-zero-style = "syntax #3b4261";
                };
              };
            };

            ssh = {
              enable = true;
              extraConfig = ''
                Host *
                    IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
              '';
            };

            starship = {
              enable = true;
              enableZshIntegration = true;
              settings = {
                add_newline = true;

                command_timeout = 1000;

                character = {
                  success_symbol = "[➜](bold green)";
                  error_symbol = "[➜](bold red)";
                };

                directory = {
                  read_only = " 󰌾";
                  truncation_symbol = "../";
                };

                git_metrics = {
                  added_style = "bold blue";
                  format =
                    "[+$added]($added_style)/[-$deleted]($deleted_style) ";
                  disabled = false;
                };

                git_commit = { tag_disabled = false; };

                git_state = { cherry_pick = "[🍒 PICKING](bold red)"; };

                aws = { symbol = "  "; };

                dart = { symbol = " "; };

                docker_context = { symbol = " "; };

                elixir = { symbol = " "; };

                fossil_branch = { symbol = " "; };

                git_branch = { symbol = " "; };

                golang = { symbol = " "; };

                hg_branch = { symbol = " "; };

                hostname = { ssh_symbol = " "; };

                java = { symbol = " "; };

                kotlin = { symbol = " "; };

                lua = { symbol = " "; };

                memory_usage = { symbol = "󰍛 "; };

                nix_shell = { symbol = " "; };

                nodejs = { symbol = " "; };

                ocaml = { symbol = " "; };

                os.symbols = {
                  Alpaquita = " ";
                  Alpine = " ";
                  Amazon = " ";
                  Android = " ";
                  Arch = " ";
                  Artix = " ";
                  CentOS = " ";
                  Debian = " ";
                  DragonFly = " ";
                  Emscripten = " ";
                  EndeavourOS = " ";
                  Fedora = " ";
                  FreeBSD = " ";
                  Garuda = "󰛓 ";
                  Gentoo = " ";
                  HardenedBSD = "󰞌 ";
                  Illumos = "󰈸 ";
                  Linux = " ";
                  Mabox = " ";
                  Macos = " ";
                  Manjaro = " ";
                  Mariner = " ";
                  MidnightBSD = " ";
                  Mint = " ";
                  NetBSD = " ";
                  NixOS = " ";
                  OpenBSD = "󰈺 ";
                  openSUSE = " ";
                  OracleLinux = "󰌷 ";
                  Pop = " ";
                  Raspbian = " ";
                  Redhat = " ";
                  RedHatEnterprise = " ";
                  Redox = "󰀘 ";
                  Solus = "󰠳 ";
                  SUSE = " ";
                  Ubuntu = " ";
                  Unknown = " ";
                  Windows = "󰍲 ";
                };

                package = { symbol = "󰏗 "; };

                perl = { symbol = " "; };

                php = { symbol = " "; };

                pijul_channel = { symbol = " "; };

                python = { symbol = " "; };

                ruby = { symbol = " "; };

                rust = { symbol = " "; };

                scala = { symbol = " "; };

                swift = { symbol = " "; };

                zig = { symbol = " "; };
              };
            };

            zsh = {
              enable = true;
              initExtra = ''
                # fnm
                eval "$(fnm env --use-on-cd)"

                # options
                setopt clobber
              '';
              shellAliases = {
                code = "code-insiders";
                g = "git";
                grep = "rg";
                ll = "eza";
                nix-shell = "nix-shell --run $SHELL";
                man = "batman";
                cd = "z";
                whatismyip =
                  "curl -s 'https://api.ipify.org?format=json' | jq -r '.ip'";
                wimi = "whatismyip";
              };
              syntaxHighlighting = {
                enable = true;
                package = pkgs.zsh-syntax-highlighting;
              };
            };

            zoxide = {
              enable = true;
              enableZshIntegration = true;
            };
          };
        };

        homebrew = {
          enable = true;

          # Config
          onActivation.autoUpdate = true;
          onActivation.upgrade = true;

          # Zap delete any packages that are not explicitly listed here.
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

          taps = [ "eth-p/software" "homebrew/cask-versions" ];

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
            "com.apple.swipescrolldirection" =
              false; # Disable natural scrolling
          };
        };

        users.users.nxc = { home = "/Users/nxc"; };

        # Configuration for specific systemPackages

        programs = { zsh.enable = true; };

        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;
        # nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Create /etc/zshrc that loads the nix-darwin environment.
        # programs.zsh.enable = true;  # default shell on catalina

        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
      };
    in {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#mbp
      darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "nxc";
              autoMigrate = true;
            };
          }
          home-manager.darwinModules.home-manager
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."mbp".pkgs;
    };
}
