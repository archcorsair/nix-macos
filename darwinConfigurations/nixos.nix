{ inputs, ... }@flakeContext:
let
  darwinModule = { config, lib, pkgs, ... }: {
    imports = [
      inputs.home-manager.darwinModules.home-manager
      inputs.self.homeConfigurations.vn56bq8.nixosModule
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
    config = {
      documentation = {
        enable = false;
      };
      homebrew = {
        brews = [
          "bat"
          "bat-extras-batman"
          "eza"
          "fd"
          "fnm"
          "fzf"
          "ghq"
          "git"
          "jq"
          "mas"
          "neofetch"
          "ripgrep"
          "rustup-init"
          "speedtest-cli"
          "starship"
          "tailscale"
          "zoxide"
        ];
        casks = [
          "boop"
          "daisydisk"
          "discord"
          "font-fira-code-nerd-font"
          "gitkraken"
          "hoppscotch"
          "istat-menus"
          "iterm2"
          "kap"
          "keyboardcleantool"
          "notion"
          "numi"
          "rectangle"
          "skitch"
          "spotify"
          "teamviewer"
          "visual-studio-code-insiders"
          "warp"
        ];
        enable = true;
        masApps = {
          "1Password for Safari" = 1569813296;
          Amphetamine = 937984704;
          ColorSlurp = 1287239339;
          "HEIC Converter" = 1294126402;
          TestFlight = 899247664;
        };
        taps = [
          "eth-p/software"
          "homebrew/cask-versions"
          "homebrew/cask-fonts"
        ];
      };
      programs = {
        vim = {
          enable = true;
        };
        zsh = {
          enable = true;
        };
      };
      services = {
        nix-daemon = {
          enable = true;
        };
      };
      users = {
        users = {
          vn56bq8 = {
            home = /Users/vn56bq8;
          };
        };
      };
    };
  };
in
inputs.nix-darwin.lib.darwinSystem {
  modules = [
    darwinModule
  ];
  system = "aarch64-darwin";
}
