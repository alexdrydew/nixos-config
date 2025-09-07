{
  pkgs,
  config,
  ...
}: let
  user = config.userConfig.userName;
in {
  imports = [
    ../../modules/users/personal.nix
    ../../modules/system/nixos
    ./hardware-configuration.nix
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking = {
    hostName = "nixos-dell";
    networkmanager.enable = true;
    defaultGateway = "192.168.100.1";
    nameservers = ["8.8.8.8"];
    interfaces.eno2.ipv4.addresses = [
      {
        address = "192.168.100.4";
        prefixLength = 24;
      }
    ];
  };

  home-manager.sharedModules = [
    {
      home.packageSets.graphical = false;
      home.packageSets.devTools = true;
      kitty.enable = false;
    }
  ];

  time.timeZone = config.userConfig.timeZone;

  i18n.defaultLocale = "en_US.UTF-8";
  services = {
    sshd.enable = true;
  };
  ssh-server.enable = true;
  docker.enable = false;

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "audio"];
    packages = with pkgs; [];
  };
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.11";
}
