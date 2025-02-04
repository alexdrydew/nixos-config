{ config, pkgs, pkgs-unstable, userConfig, lib, ... }:

let
  user = userConfig.userName;
  home = "/Users/${user}";
in
{
  imports = [
    ../common
    ./dock
    ./homebrew
    ./nix.nix
    ./aerospace.nix
    ./jankyborders.nix
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
      home = home;
      isHidden = false;
      shell = pkgs.zsh;
    };

    # Fully declarative dock using the latest from Nix Store
    local.dock = {
      enable = true;
      entries = [
        { path = "/Applications/Slack.app/"; }
        { path = "/Applications/Telegram.app/"; }
        { path = "${home}/Applications/Home Manager Apps/Firefox.app"; }
        { path = "${home}/Applications/Home Manager Apps/kitty.app"; }
        { path = "${home}/Applications/Home Manager Apps/IntelliJ IDEA CE.app"; }
        { path = "${pkgs-unstable.dbeaver-bin}/Applications/dbeaver.app/"; }
        { path = "/Applications/Docker.app/"; }
        { path = "${pkgs.obsidian}/Applications/Obsidian.app/"; }
        {
          path = "${config.users.users.${user}.home}/Downloads";
          section = "others";
          options = "--sort name --view grid --display folder";
        }
      ];
    };
    system = {
      stateVersion = config.darwin.stateVersion;
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
    power.sleep.display = "never";
    services.sketchybar = {
      enable = true;
      package = pkgs.sketchybar;
    };
  };
}
