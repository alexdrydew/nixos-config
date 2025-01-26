{ pkgs, pkgs-unstable, userConfig, ... }:

let user = userConfig.userName; in

{
  imports = [
    ../../modules/system/common
    ../../modules/system/darwin
  ];

  services.nix-daemon.enable = true;
  local.dock.enable = true;


  system.checks.verifyNixPath = false;

  system = {
    stateVersion = 4;

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        KeyRepeat = 2; # Values: 120, 90, 60, 30, 12, 6, 2
        InitialKeyRepeat = 15; # Values: 120, 94, 68, 35, 25, 15

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;

        "com.apple.keyboard.fnState" = true;
      };

      dock = {
        autohide = false;
        show-recents = false;
        launchanim = true;
        orientation = "bottom";
        tilesize = 48;
      };

      finder = {
        _FXShowPosixPathInTitle = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = false;
      };
    };
  };
  power.sleep.display = "never";
  services.sketchybar = {
    enable = true;
  };
}
