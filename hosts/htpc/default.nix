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
  rustdesk-server.enable = true;

  # kodi.enable = true;
  kde-plasma.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  home-manager.sharedModules = [
    {
      home.packageSets.graphical = false;
      home.packageSets.devTools = false;
      kitty.enable = false;
      big-launcher.enable = true;
    }
  ];

  time.timeZone = config.userConfig.timeZone;

  i18n.defaultLocale = "en_US.UTF-8";
  services = {
    xserver.xkb = {
      layout = "us";
      variant = "";
    };

    getty.autologinUser = user;
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

  environment.systemPackages = with pkgs; [
    neovim
    git
  ];
  hardware.intel-gpu.enable = true;
  system.stateVersion = "24.11";
}
