{ config, pkgs, pkgs-unstable, userConfig, inputs, ... }:

let
  user = userConfig.userName;
  home = "/Users/${user}";
  additionalFiles = import ./files.nix { inherit user config pkgs; };
in
{
  imports = [
    ./dock
    ./homebrew
  ];

  users.users.${user} = {
    name = "${user}";
    home = home;
    isHidden = false;
    shell = pkgs.zsh;
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }: {
      imports = [
        ../../home-manager/common/zsh.nix
        ../../home-manager/common/git.nix
        ../../home-manager/common/ssh.nix
        ../../home-manager/common/gh.nix
        ../../home-manager/common/packages.nix
      ];
      home = {
        enableNixpkgsReleaseCheck = false;
        file = lib.mkMerge [
          additionalFiles
        ];
        stateVersion = "24.05";
      };
    };
    extraSpecialArgs = { inherit userConfig; inherit pkgs-unstable; };
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
