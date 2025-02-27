{ config, lib, pkgs, ... }:
{
  options = {
    kodi = {
      enable = lib.mkEnableOption "Kodi";
    };
  };
  config = lib.mkIf config.kodi.enable {
    services.xserver.enable = true;
    services.xserver.desktopManager = {
      kodi = {
        enable = true;
        package = (pkgs.kodi.withPackages (pkgs: with pkgs; [
          jellycon
          youtube 
          (pkgs.callPackage ./arctic-fuse-2.nix { xbmcswift2 = pkgs.xbmcswift2; })
          (pkgs.callPackage ./skinvariables.nix { xbmcswift2 = pkgs.xbmcswift2; })
          (pkgs.callPackage ./module-infotagger.nix { xbmcswift2 = pkgs.xbmcswift2; })
          (pkgs.callPackage ./module-jurialmunkey.nix { xbmcswift2 = pkgs.xbmcswift2; })
          (pkgs.callPackage ./texturemaker.nix { xbmcswift2 = pkgs.xbmcswift2; })
          (pkgs.callPackage ./font-robotocjksc.nix { xbmcswift2 = pkgs.xbmcswift2; })
          (pkgs.callPackage ./beautifulsoup4.nix { })
          (pkgs.callPackage ./soupsieve.nix { })
          (pkgs.callPackage ./weathericons-white.nix { })
          (pkgs.callPackage ./studioicons-coloured.nix { })
        ]));
      };
    };
    services.xserver.displayManager.lightdm.greeter.enable = false;
    users.extraUsers.kodi.isNormalUser = true;
    services.displayManager.autoLogin = {
      user = "kodi";
      enable = true;
    };
  };
}
