{
  pkgs,
  pkgs-stable,
  pkgs-unstable,
  config,
  inputs,
  ...
}: let
  user = config.userConfig.userName;
in {
  imports = [
    ../common
    ../../home-manager/nixos
    ./docker.nix
    ./hardware
    ./sudo.nix
    ./audio.nix
    ./kodi
    ./kde-plasma.nix
    ./firefox.nix
    ./rustdesk.nix
    ./pihole.nix
    ./openwebui.nix
  ];

  programs = {
    nix-ld.enable = true;
  };

  time.timeZone = config.userConfig.timeZone;

  programs.zsh.enable = true;
  users.users = {
    ${user} = {
      isNormalUser = true;
      extraGroups = [
        "wheel" # Enable ‘sudo’ for the user.
        "docker"
      ];
      shell = pkgs.zsh;
    };
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit pkgs-unstable;
      inherit pkgs-stable;
      inherit inputs;
    };
    users.${user} = _: {
      home = {
        enableNixpkgsReleaseCheck = false;
        username = "${user}";
        homeDirectory = "/home/${user}";
        stateVersion = "24.05";
      };
    };
  };
}
