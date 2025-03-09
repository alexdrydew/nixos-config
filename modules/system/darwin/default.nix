{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: let
  user = config.userConfig.userName;
  home = "/Users/${user}";
in {
  imports = [
    ../common
    ./dock
    ./homebrew
    ./nix.nix
    ./aerospace.nix
    ./jankyborders.nix
    ./raycast.nix
    ./sketchybar
    ../../home-manager/darwin
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
      inherit home;
      isHidden = false;
      shell = pkgs.zsh;
    };

    # Fully declarative dock using the latest from Nix Store
    local.dock = {
      enable = true;
      entries = [
        {path = "/Applications/Slack.app/";}
        {path = "/Applications/Telegram.app/";}
        {path = "${home}/Applications/Home Manager Apps/Firefox.app";}
        {path = "${home}/Applications/Home Manager Apps/kitty.app";}
        {path = "${home}/Applications/Home Manager Apps/IntelliJ IDEA CE.app";}
        {path = "${pkgs-unstable.dbeaver-bin}/Applications/dbeaver.app/";}
        {path = "/Applications/Docker.app/";}
        {path = "${pkgs.obsidian}/Applications/Obsidian.app/";}
        {
          path = "${config.users.users.${user}.home}/Downloads";
          section = "others";
          options = "--sort name --view grid --display folder";
        }
      ];
    };
    system = {
      inherit (config.darwin) stateVersion;
      checks.verifyNixPath = false;
      defaults = {
        NSGlobalDomain = {
          AppleShowAllExtensions = true;
          ApplePressAndHoldEnabled = false;

          KeyRepeat = 2;
          InitialKeyRepeat = 15;

          "com.apple.mouse.tapBehavior" = 1;
          "com.apple.sound.beep.volume" = 0.0;
          "com.apple.sound.beep.feedback" = 0;

          "com.apple.keyboard.fnState" = true;

          NSAutomaticWindowAnimationsEnabled = false;
          _HIHideMenuBar = true;
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

        spaces.spans-displays = true;
      };
    };
    system.defaults.CustomUserPreferences = {
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          # Disable 'Cmd + Space' for Spotlight Search
          "64" = {
            enabled = false;
          };
          # Disable 'Cmd + Alt + Space' for Finder search window
          "65" = {
            enabled = false;
          };
        };
      };
    };
    power.sleep.display = "never";
  };
}
