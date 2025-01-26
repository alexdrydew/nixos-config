{ config, pkgs, pkgs-unstable, userConfig, lib, inputs, ... }:

let
  user = userConfig.userName;
  home = "/Users/${user}";
  additionalFiles = import ./files.nix { inherit user config pkgs; };
in
{
  imports = [
    ./dock
    ./homebrew
    ./home-manager.nix
    ./nix.nix
  ];

  options = {
    darwin.stateVersion = lib.mkOption {
      type = lib.types.int;
      description = "The state version for this configuration.";
      example = 4;
    };
  };

  config = {
    users.users.${user} = {
      name = "${user}";
      home = home;
      isHidden = false;
      shell = pkgs.zsh;
    };

    # Fully declarative dock using the latest from Nix Store
    local.dock.entries = [
      { path = "/Applications/Slack.app/"; }
      { path = "/Applications/Telegram.app/"; }
      { path = "/Applications/Google Chrome.app/"; }
      { path = "${pkgs.jetbrains.pycharm-professional}/Applications/PyCharm.app/"; }
      { path = "${pkgs.jetbrains.webstorm}/Applications/WebStorm.app/"; }
      { path = "${pkgs-unstable.dbeaver-bin}/Applications/dbeaver.app/"; }
      { path = "/Applications/Docker.app/"; }
      { path = "${pkgs.obsidian}/Applications/Obsidian.app/"; }
      {
        path = "${config.users.users.${user}.home}/Downloads";
        section = "others";
        options = "--sort name --view grid --display folder";
      }
    ];
    system.checks.verifyNixPath = false;
    system = {
      stateVersion = config.darwin.stateVersion;

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
  };
}
