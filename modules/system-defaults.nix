{
  system.primaryUser = "nxc";
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
        "/Applications/Dia.app"
        "/Applications/Arc.app"
        "/Applications/Google Chrome Dev.app"
        "/System/Applications/Messages.app"
        "/Applications/Discord.app"
        "Applications/Ghostty.app"
        "/Applications/Warp.app"
        "/Applications/Zed.app"
        "/Applications/Visual Studio Code - Insiders.app"
        "/Applications/massCode.app"
        "/System/Applications/Music.app"
        "/Applications/Spotify.app"
        "/System/Applications/Calendar.app"
        "/Applications/Affinity Photo 2.app"
        "/Applications/Pixelmator Pro.app"
        "/Applications/Eagle.app"
        "/System/Applications/System Settings.app"
        "/System/Applications/iPhone Mirroring.app"
        "/System/Applications/Weather.app"
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
}
