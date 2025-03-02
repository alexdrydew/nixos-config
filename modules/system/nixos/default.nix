{ pkgs, config, pkgs-unstable, inputs, ... }:

let
  user = config.userConfig.userName;
in
{
  imports = [
    ../common
    ../../home-manager/nixos
    ./docker.nix
    ./hardware
    ./sudo.nix
    ./audio.nix
    ./kodi
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
    extraSpecialArgs = { inherit pkgs-unstable; inherit inputs; };
    users.${user} = { ... }: {
      home = {
        enableNixpkgsReleaseCheck = false;
        username = "${user}";
        homeDirectory = "/home/${user}";
        stateVersion = "24.05";
      };
    };
  };
}
