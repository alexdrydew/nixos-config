{ pkgs, config, ... }:
{
  imports = [
    ../../modules/system/common/nix.nix
  ];
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 42;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "v4l2loopback" ];
    kernelModules = [ "uinput" "v4l2loopback" ];
    extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];
  };

  home-manager.sharedModules = [
    {
      home.packageSets.graphical = false;
      home.packageSets.devTools = false;
      kitty = false;
    }
  ];

  time.timeZone = config.userConfig.timeZone;

  networking = {
    hostName = "htpc-alexdrydew";
    useDHCP = false;
    interfaces.eno1.useDHCP = true;
  };
  ssh-server.enable = true;
  docker.enable = false;

  services.sshd.enable = true;
  system.stateVersion = "24.11";
}
