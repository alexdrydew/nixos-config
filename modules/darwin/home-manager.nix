{ config, pkgs, pkgs-unstable, userConfig, nvf, ... }:

let
  user = userConfig.userName;
  home = "/Users/${user}";
  sharedFiles = import ../shared/headless/files.nix { inherit config pkgs; };
  additionalFiles = import ./files.nix { inherit user config pkgs; };
in
{
  imports = [
    ./dock
  ];

  users.users.${user} = {
    name = "${user}";
    home = home;
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix { };
    # onActivation.cleanup = "uninstall";

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    # If you have previously added these apps to your Mac App Store profile (but not installed them on this system),
    # you may receive an error message "Redownload Unavailable with This Apple ID".
    # This message is safe to ignore. (https://github.com/dustinlyons/nixos-config/issues/83)
    masApps = {
      #      "1password" = 1333542190;
    };
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }: {
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./packages.nix { inherit pkgs-unstable; };
        file = lib.mkMerge [
          sharedFiles
          additionalFiles
        ];
        stateVersion = "24.05";
      };
      programs = import ../shared/headless/home-manager.nix { inherit pkgs lib userConfig; };
    };
  };

  # Fully declarative dock using the latest from Nix Store
  local.dock.enable = true;
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
}
