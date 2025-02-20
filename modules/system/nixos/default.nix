{ pkgs, config, pkgs-unstable, inputs, ... }:

let
  user = config.userConfig.userName;
  keys = config.keys;
in
{
  imports = [
    ../common
    ../../home-manager/nixos
    ./docker.nix
    ./hardware
    ./sudo.nix
    ./ssh.nix
    ./audio.nix
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
      openssh.authorizedKeys.keys = keys;
    };

    root = {
      openssh.authorizedKeys.keys = keys;
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
