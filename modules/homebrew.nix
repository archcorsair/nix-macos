{
  homebrew = {
    enable = true;

    # Config
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;

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
}
