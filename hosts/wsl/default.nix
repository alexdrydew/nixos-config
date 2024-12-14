{ pkgs, userConfig, ... }:

let
  user = userConfig.userName;
  keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOk8iAnIaa1deoc7jw8YACPNVka1ZFJxhnU4G74TmS+p" ];
in
{
  imports = [
    ../../modules/shared
  ];

  wsl.enable = true;
  wsl.defaultUser = user;

  time.timeZone = userConfig.timeZone;

  # Manages keys and such
  programs = {
    gnupg.agent.enable = true;

    # Needed for anything GTK related
    dconf.enable = true;

    # My shell
    zsh.enable = true;

    nix-ld.enable = true;
  };

  services = {
    # Let's be able to SSH into this machine
    openssh.enable = true;
    xserver.videoDrivers = [ "nvidia" ];
  };

  # GPU support
  hardware = {
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = false;
      open = false;
    };
    nvidia-container-toolkit.enable = true;
  };

  # Add docker daemon
  virtualisation.docker = {
    enable = true;
    logDriver = "json-file";
    daemon.settings = {
      default-runtime = "nvidia";
      runtimes.nvidia.path = "${pkgs.nvidia-docker}/bin/nvidia-container-runtime";
    };
  };

  # It's me, it's you, it's everyone
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

  # Don't require password for users in `wheel` group for these commands
  security.sudo = {
    enable = true;
    extraRules = [{
      commands = [
        {
          command = "${pkgs.systemd}/bin/reboot";
          options = [ "NOPASSWD" ];
        }
      ];
      groups = [ "wheel" ];
    }];
  };

  fonts.packages = with pkgs; [
    dejavu_fonts
    feather-font # from overlay
    jetbrains-mono
    font-awesome
    noto-fonts
    noto-fonts-emoji
  ];

  environment.systemPackages = with pkgs; [
    gitAndTools.gitFull
    inetutils
  ];

  system.stateVersion = "21.05"; # Don't change this

}
