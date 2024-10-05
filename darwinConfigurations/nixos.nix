{ inputs, ... }@flakeContext:

let
  darwinModule = { config, lib, pkgs, ... }: {
    documentation.enable = false;

    environment.systemPackages = [
      pkgs.rustup
    ];

    homebrew = {
      enable = true;
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
        "skitch"
        "spotify"
        "teamviewer"
        "visual-studio-code-insiders"
        "warp"
      ];
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

    programs.vim.enable = true;
    programs.zsh.enable = true;

    services.nix-daemon.enable = true;

    users.users.nxc = {
      home = /Users/nxc;
    };

    system.stateVersion = 4;
  };
in
{
  imports = [
    darwinModule
    inputs.home-manager.darwinModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.nxc = { pkgs, ... }: import ../homeConfigurations/nxc.nix { inherit inputs pkgs; };
  };
}